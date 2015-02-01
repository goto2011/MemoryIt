//
//  Ribbon_info.m
//  MemoryIt
//
//  Created by duangan on 12-7-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Ribbon_info.h"
#import "base_types.h"

@implementation Ribbon_info

@synthesize Ribbon_id;
@synthesize Ribbon_name;
@synthesize File_name;
@synthesize Last_momery_time;
@synthesize Current_mode;
@synthesize Last_momery_thread;
@synthesize Card_count;
@synthesize Thread_count;
@synthesize Global_rank;
@synthesize Ribbon_type;
@synthesize Ribbon_version;
@synthesize Create_time;
@synthesize Last_modify_time;
@synthesize Repeat_count;
@synthesize Other_int1;
@synthesize Other_int2;
@synthesize Other_int3;
@synthesize Other_int4;
@synthesize Other_int5;
@synthesize Other_int6;
@synthesize Other_1;
@synthesize Other_2;
@synthesize Other_3;
@synthesize Other_4;
@synthesize Other_5;
@synthesize Other_6;

// 获取记忆指数
- (float)get_finished_percent{
    if (Thread_count > 0) {
        // +1是为了补充0位
        return ((float)(Last_momery_thread + 1) / Thread_count) * 100;
    }else{
        return 0;
    }
}

// 对当前选中节点打印，这些值非常重要。
- (void)print_info{
    NSLog(@"%@:: %d--%d--%d.", File_name, Card_count, Thread_count, Last_momery_thread);
}

// 判断ribbon是否处在就绪态
- (Boolean)is_ready{
    return (Card_count >= RIBBON_READY_STANDARD);
}

// 判断ribbon是否完成了.
// 由于数据库有一定的误差，所以相差1-2个为完成。
- (Boolean)is_finished{
    return (fabsf(Last_momery_thread - Thread_count) < 3);
}

// 完成两次
- (Boolean)is_finished_twins{
    return [self is_finished] && (Repeat_count == 1);
}

// 完成三次或更多
- (Boolean)is_finished_more{
    return [self is_finished] && (Repeat_count > 1);
}

// 获取memory指数.
// 考虑到有些疯子会长期、重量级的使用本软件，导致其memory指数会超过4字节整数的范围，所以除以10.
- (float)get_this_ribbon_memory_index{
    float this_user_memory_index = 0;
    
    // 计算memory指数。
    this_user_memory_index = (float)Last_momery_thread / 10;

    // 奖励。
    // 奖励只针对处在就绪态的ribbon。
    if([self is_ready]){
        if ([self is_finished]){
            // 完成1次，奖励thread数的0.5倍.
            this_user_memory_index += (float)Last_momery_thread / 20;
        }else if([self is_finished_twins]){
            // 完成2次，奖励thread数的1倍；
            this_user_memory_index += (float)Last_momery_thread / 20;
        }else if([self is_finished_more]){
            // 完成3次及以上的，奖励thread数的2倍.
            this_user_memory_index += (float)Last_momery_thread / 10;
        }
    }
    
    return this_user_memory_index;
}

@end
