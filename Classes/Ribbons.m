//
//  ribbon_files.m
//  MemoryIt
//
//  Created by duangan on 12-5-1.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Ribbons.h"
#import "Ribbon_info.h"
#import "base_types.h"
#import "Base_ST_obj.h"
#import "Singleton_object.h"

@implementation Ribbons
SYNTHESIZE_SINGLETON_FOR_CLASS(Ribbons);

// globle param.
@synthesize Ribbon_infos;
@synthesize Current_ribbon_info_index;
@synthesize mi_db;

// 生成uuid
- (NSString *) create_UUID {
    CFUUIDRef    uuidObj = CFUUIDCreate(nil);//create a new UUID
    //get the string representation of the UUID
    NSString    *uuidString = (NSString*)CFUUIDCreateString(nil, uuidObj);
    CFRelease(uuidObj);
    return [uuidString autorelease];
}


// 拼接数据库文件路径。
- (NSString *)get_database_name {
    // ios下Document路径，Document为ios中可读写的文件夹
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:MEMORYIT_DATABASE_NAME];
}


// 打开数据库。成功返回true，失败返回false。数据库名暂时不可修改。
- (db_handler_error)open_db{
    // 打开数据库实例 db。 如果没有会自动创建。
    mi_db = [FMDatabase databaseWithPath:[self get_database_name]];
    if (![mi_db open]) {
        return DB_OPEN_FAIL;
    }else{
        [mi_db retain];
        return DB_EXEC_OK;
    }
}

// 执行请求
- (db_handler_error)execute_query:(NSString *)_sql_query{
    if (mi_db == nil){
        return DB_OPEN_FAIL;
    }else{
        if([mi_db executeUpdate:_sql_query]){
            return DB_EXEC_OK;
        }else{
            return DB_EXEC_FAIL;
        }
    }
}

// 新建表，如果已存在或新建成功，返回true，失败返回false。
- (db_handler_error)create_table{
    NSString *sql_query = @"CREATE TABLE IF NOT EXISTS RIBBON_TABLE(Ribbon_id char(128) PRIMARY KEY, Ribbon_name char(128), File_name varchar(256), Last_momery_time timestamp, Current_mode interger, Last_momery_thread interger, Card_count interger, Thread_count interger, Global_rank interger, Ribbon_type interger, Ribbon_version interger, Create_time timestamp  NOT NULL DEFAULT (datetime('now','localtime')), Last_modify_time timestamp, Repeat_count interger, Other_int1 interger, Other_int2 interger, Other_int3 interger, Other_int4 interger, Other_int5 interger, Other_int6 interger, Other_1 char(64), Other_2 char(64), Other_3 char(64), Other_4 char(64), Other_5 char(64) , Other_6 char(64));";
    
    return [self execute_query:sql_query];
}


// 写入1行数据。成功返回true；失败返回false。
- (db_handler_error)insert_ribbon_info_to_db:(NSString *)_ribbon_name
                ribbon_file_name:(NSString *)_ribbon_file_name{
    db_handler_error ret = DB_EXEC_FAIL;
    
    if (mi_db == nil){
        return DB_OPEN_FAIL;
    }else{
        Ribbon_info *this_ribbon = [[Ribbon_info alloc]init];
    
        this_ribbon.Ribbon_id       = [self create_UUID];
        this_ribbon.Ribbon_name     = _ribbon_name;
        this_ribbon.File_name       = _ribbon_file_name;
        this_ribbon.Ribbon_type     = 1;
        this_ribbon.Ribbon_version  = 1;
    
        // 判断是否有同名文件
        // stringForQuery 返回一个字符串.
        NSString *db_file_name = [mi_db stringForQuery:@"select File_name from RIBBON_TABLE where File_name = ?", this_ribbon.File_name];
        if(db_file_name != nil)return DB_TABLE_HAS_DUMP_DATA;
        
        // 如果没有同名文件，则写入.
        if([mi_db executeUpdate:@"insert or REPLACE INTO RIBBON_TABLE (Ribbon_id, Ribbon_name, File_name, Ribbon_type, Ribbon_version) VALUES (?, ?, ?, ?, ?);", this_ribbon.Ribbon_id, this_ribbon.Ribbon_name, this_ribbon.File_name, [NSNumber numberWithInt:this_ribbon.Ribbon_type], [NSNumber numberWithInt:this_ribbon.Ribbon_version]]){
            ret = DB_EXEC_OK;
        }else{
            ret = DB_INSERT_FAIL;
        }
    
        // TODO:看看，从下面这行可看出sqlitepersistentobjects是多么的轻便、多么的顺畅。有时间一定要把这个框架继续做下去。
        // [this_ribbon save];
#ifdef MI_ST
        // [Ribbon_infos addObject:this_ribbon];
#endif
        [this_ribbon release];
        
        return ret;
    }
}


// 从ribbo数据表结果集的当前行中读取数据
- (db_handler_error)read_data{
    if (mi_db == nil){
        return DB_OPEN_FAIL;
    }else{
        // 按“上次记忆时间”来排列。
        FMResultSet *rs = [mi_db executeQuery:@"select * from RIBBON_TABLE order by Last_momery_time desc"];
        if(rs == nil)return DB_SELECT_FAIL;
        
        while ([rs next]){
            Ribbon_info *this_ribbon = [[Ribbon_info alloc]init];
            
            this_ribbon.Ribbon_id           = [rs stringForColumn:@"Ribbon_id"];
            this_ribbon.Ribbon_name         = [rs stringForColumn:@"Ribbon_name"];
            this_ribbon.File_name           = [rs stringForColumn:@"File_name"];
            this_ribbon.Last_momery_time    = [rs stringForColumn:@"Last_momery_time"];
            
            this_ribbon.Current_mode        = [rs intForColumn:@"Current_mode"];
            this_ribbon.Last_momery_thread  = [rs intForColumn:@"Last_momery_thread"];
            this_ribbon.Card_count          = [rs intForColumn:@"Card_count"];
            this_ribbon.Thread_count        = [rs intForColumn:@"Thread_count"];
            this_ribbon.Global_rank         = [rs intForColumn:@"Global_rank"];
            this_ribbon.Ribbon_type         = [rs intForColumn:@"Ribbon_type"];
            this_ribbon.Ribbon_version      = [rs intForColumn:@"Ribbon_version"];
            this_ribbon.Repeat_count        = [rs intForColumn:@"Repeat_count"];
            this_ribbon.Other_int1          = [rs intForColumn:@"Other_int1"];
            this_ribbon.Other_int2          = [rs intForColumn:@"Other_int2"];
            this_ribbon.Other_int3          = [rs intForColumn:@"Other_int3"];
            this_ribbon.Other_int4          = [rs intForColumn:@"Other_int4"];
            this_ribbon.Other_int5          = [rs intForColumn:@"Other_int5"];
            this_ribbon.Other_int6          = [rs intForColumn:@"Other_int6"];
            
            this_ribbon.Create_time         = [rs stringForColumn:@"Create_time"];
            this_ribbon.Last_modify_time    = [rs stringForColumn:@"Last_modify_time"];
            this_ribbon.Other_1             = [rs stringForColumn:@"Other_1"];
            this_ribbon.Other_2             = [rs stringForColumn:@"Other_2"];
            this_ribbon.Other_3             = [rs stringForColumn:@"Other_3"];
            this_ribbon.Other_4             = [rs stringForColumn:@"Other_4"];
            this_ribbon.Other_5             = [rs stringForColumn:@"Other_5"];
            this_ribbon.Other_6             = [rs stringForColumn:@"Other_6"];
            
            [Ribbon_infos addObject:this_ribbon];

            [this_ribbon release];
        }
        
        [rs close];
        
        return DB_EXEC_OK;
    }
}

// 获取当前ribbon 数量
- (int)get_ribbon_count{
    return Ribbon_infos.count;
}

// 获取当前选择的ribbon info。
- (Ribbon_info *)get_current_ribbon_info{
    return [self get_ribbon_info:Current_ribbon_info_index];
}

// 根据对象index获取对象
- (Ribbon_info *)get_ribbon_info:(int)_ribbon_index{
    if (_ribbon_index >= 0) {
        return [Ribbon_infos objectAtIndex:_ribbon_index];
    }else{
        return nil;
    }
}

// 执行条件更新操作
- (db_handler_error)update_query_with_condition:(NSString *)_update_filed
                                     with_value:(int)_update_value
                               need_update_time:(BOOL)_need_update_time{
    if (mi_db == nil){
        return DB_OPEN_FAIL;
    }else{
        NSString *sql_query;
        
        if (_need_update_time == FALSE) {
            sql_query = [NSString stringWithFormat:@"UPDATE RIBBON_TABLE SET %@ = ? WHERE Ribbon_id = ? ", _update_filed];
        }else{
            sql_query = [NSString stringWithFormat:@"UPDATE RIBBON_TABLE SET %@ = ?, Last_momery_time=datetime('now','localtime') WHERE Ribbon_id = ? ", _update_filed];                
        }
        // 注意，要用 NSNumber对象。
        if([mi_db executeUpdate:sql_query, [NSNumber numberWithInt:_update_value],
            [self get_current_ribbon_info].Ribbon_id]){
            return DB_EXEC_OK;
        }else{
            return DB_UPDATE_FAIL;
        }
    }
}


// 更新 Last_momery_thread
- (db_handler_error)update_Last_momery_thread:(int)_Last_momery_thread{
    // @"UPDATE RIBBON_TABLE SET Last_momery_thread = ? WHERE Ribbon_id = ? "
    if (self.Current_ribbon_info_index >= 0){
        [self get_current_ribbon_info].Last_momery_thread = _Last_momery_thread;
        return [self update_query_with_condition:@"Last_momery_thread"
                                      with_value:_Last_momery_thread
                                need_update_time:TRUE];
    }
    else{
        return DB_OTHER_FAIL;
    }
}

// 更新 Card_count
- (db_handler_error)update_Card_count:(int)_Card_count{
    if (self.Current_ribbon_info_index >= 0){
        [self get_current_ribbon_info].Card_count = _Card_count;
        return [self update_query_with_condition:@"Card_count"
                                      with_value:_Card_count
                                need_update_time:FALSE];
        
    }else{
        return DB_OTHER_FAIL;
    }
}

// 更新 Thread_count
- (db_handler_error)update_Thread_count:(int)_Thread_count{
    if (self.Current_ribbon_info_index >= 0){
        [self get_current_ribbon_info].Thread_count = _Thread_count;
        return [self update_query_with_condition:@"Thread_count"
                                      with_value:_Thread_count
                                need_update_time:FALSE];
    }else{
        return DB_OTHER_FAIL;
    }
}


// init ribbons.
- (id) init{
    if(self = [super init]){
        // init array
        Ribbon_infos = [NSMutableArray arrayWithCapacity:MAX_RIBBON_COUNT];
        [Ribbon_infos retain];
        
        // init current ribbon.
        Current_ribbon_info_index = -1;

#ifdef MI_ST
        // 删除数据库，ST测试代码。
        // [[NSFileManager defaultManager] removeItemAtPath:[self get_database_name] error:nil];
#endif
        
        // open db.
        if ([self open_db] != DB_EXEC_OK) {
            NSLog(@"Ribbons - init(): Could not open db.");
        }
        
        // create table.
        if ([self create_table] != DB_EXEC_OK) {
            NSLog(@"Ribbons - init(): Could not create table : RIBBON_TABLE.");
        }

#ifdef MI_ST
        [Base_ST_obj insert_data_to_ribbon];
#endif
        if ([self read_data] != DB_EXEC_OK) {
            NSLog(@"Ribbons - init(): Could not read database.");
        }
        
        // Ribbon_infos = [Ribbon_info findByCriteria:@""];
        NSLog(@"Ribbons - init(): db has %d ribbons.", [Ribbon_infos count]);
        
    }
    return (self);
}

// delete myself
- (void) dealloc{
    [Ribbon_infos release];
    Ribbon_infos = nil;
    
    [mi_db close];
    [mi_db release];
    mi_db = nil;
    
    [super dealloc];
}

@end
