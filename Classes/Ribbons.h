//
//  ribbon_files.h
//  MemoryIt
//
//  Created by duangan on 12-5-1.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "base_types.h"
// #import "/usr/include/sqlite3.h"
#import <sqlite3.h>
#import "Ribbon_info.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"

// 请关注，ribbons没有保持任何ribboon的数据。
// 目前的处理是，每次进入ribbon的显示，都是重新从数据源读取数据的，相关操作，由ribbon负责。

@interface Ribbons : NSObject {
    @private NSMutableArray *Ribbon_infos;          // 保存所有ribbon_info。禁止外部直接访问。
    @private FMDatabase *mi_db;

    int Current_ribbon_info_index;                  // 指向当前的ribbon_info。
}

// save all thread data.
@property (nonatomic, retain)NSMutableArray *Ribbon_infos;
@property (nonatomic, assign)int Current_ribbon_info_index;
@property (nonatomic, retain)FMDatabase *mi_db;

// 获取单例对象
+ (Ribbons *)sharedRibbons;

// init ribbons.
- (id) init;

// 写入一个ribbon的数据行到数据库
- (db_handler_error)insert_ribbon_info_to_db:(NSString *)_ribbon_name
                ribbon_file_name:(NSString *)_ribbon_file_name;

// 获取当前ribbon 数量
- (int)get_ribbon_count;

// 获取当前选择的ribbon info。
- (Ribbon_info *)get_current_ribbon_info;

// 根据对象index获取对象
- (Ribbon_info *)get_ribbon_info:(int)_ribbon_index;

// 更新 Last_momery_thread
- (db_handler_error)update_Last_momery_thread:(int)_Last_momery_thread;

// 更新 Card_count
- (db_handler_error)update_Card_count:(int)_Card_count;

// 更新 Thread_count
- (db_handler_error)update_Thread_count:(int)_Thread_count;

@end
