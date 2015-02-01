//
//  Ribbon_info.h
//  MemoryIt
//
//  Created by duangan on 12-7-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ribbon_info : NSObject{
    NSString * Ribbon_id;
    NSString * Ribbon_name;
    NSString * File_name;
    NSString * Last_momery_time;
    int Current_mode;
    int Last_momery_thread;
    int Card_count;
    int Thread_count;
    int Global_rank;
    int Ribbon_type;
    int Ribbon_version;
    int Repeat_count;
    int Other_int1;
    int Other_int2;
    int Other_int3;
    int Other_int4;
    int Other_int5;
    int Other_int6;
    NSString * Create_time;
    NSString * Last_modify_time;
    NSString * Other_1;
    NSString * Other_2;
    NSString * Other_3;
    NSString * Other_4;
    NSString * Other_5;
    NSString * Other_6;
}

@property (retain, nonatomic)NSString *Ribbon_id;
@property (retain, nonatomic)NSString *Ribbon_name;
@property (retain, nonatomic)NSString *File_name;
@property (retain, nonatomic)NSString *Last_momery_time;
@property (assign, nonatomic)int Current_mode;
@property (assign, nonatomic)int Last_momery_thread;
@property (assign, nonatomic)int Card_count;
@property (assign, nonatomic)int Thread_count;
@property (assign, nonatomic)int Global_rank;
@property (assign, nonatomic)int Ribbon_type;
@property (assign, nonatomic)int Ribbon_version;
@property (assign, nonatomic)int Repeat_count;
@property (assign, nonatomic)int Other_int1;
@property (assign, nonatomic)int Other_int2;
@property (assign, nonatomic)int Other_int3;
@property (assign, nonatomic)int Other_int4;
@property (assign, nonatomic)int Other_int5;
@property (assign, nonatomic)int Other_int6;
@property (retain, nonatomic)NSString *Create_time;
@property (retain, nonatomic)NSString *Last_modify_time;
@property (retain, nonatomic)NSString *Other_1;
@property (retain, nonatomic)NSString *Other_2;
@property (retain, nonatomic)NSString *Other_3;
@property (retain, nonatomic)NSString *Other_4;
@property (retain, nonatomic)NSString *Other_5;
@property (retain, nonatomic)NSString *Other_6;

// 获取记忆指数
- (float)get_finished_percent;

// 对当前选中节点打印，这些值非常重要。
- (void)print_info;

// 判断ribbon是否处在就绪态.
- (Boolean)is_ready;

// 判断ribbon是否完成了.
- (Boolean)is_finished;

// 完成两次
- (Boolean)is_finished_twins;

// 完成三次或更多
- (Boolean)is_finished_more;

// 获取当前ribbon的memory指数.
- (float)get_this_ribbon_memory_index;


@end
