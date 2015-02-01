//
//  Statistics.m
//  MemoryIt
//
//  Created by duangan on 12-10-28.
//
//

#import "Statistics.h"
#import "Ribbon_info.h"

@implementation Statistics

@synthesize root_ribbons;
@synthesize user_serial;

@synthesize data_flag;

@synthesize ribbon_count;
@synthesize ready_ribbon_count;
@synthesize card_total;
@synthesize thread_total;
@synthesize finish_one_time_count;
@synthesize finish_two_time_count;
@synthesize finish_three_or_more_time_count;
@synthesize finish_thread_count;

@synthesize this_user_champion;
@synthesize champion_des;

@synthesize this_user_memory_index;
@synthesize this_user_global_rank;

// 请求重新刷新数据
- (void)you_need_update_data{
    data_flag = STATISTICS_DATA_DIRTY;
}

-(void)zero_data{
    ribbon_count = 0;
    ready_ribbon_count = 0;
    card_total = 0;
    thread_total = 0;
    finish_one_time_count = 0;
    finish_two_time_count = 0;
    finish_three_or_more_time_count = 0;
    finish_thread_count = 0;
    this_user_memory_index = 0.0;
    this_user_global_rank = 0;
    
    [champion_des removeAllObjects];
    [this_user_champion removeAllObjects];
    
    [champion_des addObject:@"初试鹰啼"];
    [this_user_champion addObject:[NSNumber numberWithInt:0]];
    [champion_des addObject:@"初试鹰啼.温故知新"];
    [this_user_champion addObject:[NSNumber numberWithInt:0]];
    [champion_des addObject:@"牛刀小试"];
    [this_user_champion addObject:[NSNumber numberWithInt:0]];
    [champion_des addObject:@"牛刀小试.温故知新"];
    [this_user_champion addObject:[NSNumber numberWithInt:0]];
    [champion_des addObject:@"登堂入室"];
    [this_user_champion addObject:[NSNumber numberWithInt:0]];
    [champion_des addObject:@"登堂入室.温故知新"];
    [this_user_champion addObject:[NSNumber numberWithInt:0]];
    [champion_des addObject:@"筑基小成"];
    [this_user_champion addObject:[NSNumber numberWithInt:0]];
    [champion_des addObject:@"筑基小成.温故知新"];
    [this_user_champion addObject:[NSNumber numberWithInt:0]];
    [champion_des addObject:@"中流击楫"];
    [this_user_champion addObject:[NSNumber numberWithInt:0]];
    [champion_des addObject:@"中流击楫.温故知新"];
    [this_user_champion addObject:[NSNumber numberWithInt:0]];
    [champion_des addObject:@"渐入佳境"];
    [this_user_champion addObject:[NSNumber numberWithInt:0]];
    [champion_des addObject:@"渐入佳境.温故知新"];
    [this_user_champion addObject:[NSNumber numberWithInt:0]];
    [champion_des addObject:@"蔚为大观"];
    [this_user_champion addObject:[NSNumber numberWithInt:0]];
    [champion_des addObject:@"蔚为大观.温故知新"];
    [this_user_champion addObject:[NSNumber numberWithInt:0]];
    [champion_des addObject:@"宗师出世"];
    [this_user_champion addObject:[NSNumber numberWithInt:0]];
    [champion_des addObject:@"宗师出世.温故知新"];
    [this_user_champion addObject:[NSNumber numberWithInt:0]];
}

// init
- (id) init:(Ribbons *)_root_ribbons
user_serial:(NSString *)_user_serial{
    if(self = [super init]){
        data_flag = STATISTICS_DATA_DIRTY;
        
        this_user_champion = [NSMutableArray arrayWithCapacity:CHAMPION_COUNT_MAX];
        champion_des = [NSMutableArray arrayWithCapacity:CHAMPION_COUNT_MAX];
        [this_user_champion retain];
        [champion_des retain];
        
        [self champion_des];
        
        if (_root_ribbons == nil){
            return nil;
        }else{
            root_ribbons = _root_ribbons;
        }
        
        if (_user_serial == nil){
            return nil;
        }else{
            user_serial = _user_serial;
        }
    }
    return (self);
}

- (void)dealloc {
    [Statistics release];
    [root_ribbons release];
    
    [super dealloc];
}

// 计算冠军勋章。
// 完成第1个就绪的ribbon，叫“初试音啼”；
// 完成第10个就绪的ribbon，叫“牛刀小试”
// 完成第20个就绪的ribbon，叫“登堂入室"
// 完成第50个就绪的ribbon，叫“筑基小成"
// 完成第100个就绪的ribbon，叫”中流击楫"
// 完成第200个就绪的ribbon，叫“渐入佳境"
// 完成第500个就绪的ribbon，叫“蔚为大观"
// 完成第1000个就绪的ribbon，叫“宗师出世"
// 完成上面数据的第三遍者，获得同类型加衔“温故知新”
// 共计16枚勋章。
- (int)calculate_champion:(int)_finished_ribbon_count
            review_ribbon:(int)_finished_review_ribbon_count{
    int champion_count = 0;
        
    if (_finished_ribbon_count >= 1) {
        [this_user_champion setObject:[NSNumber numberWithInt:1] atIndexedSubscript:0];
        champion_count++;
    }
    if(_finished_review_ribbon_count >= 1){
        [this_user_champion setObject:[NSNumber numberWithInt:1] atIndexedSubscript:1];
        champion_count++;
    }
    if(_finished_ribbon_count >= 10){
        [this_user_champion setObject:[NSNumber numberWithInt:1] atIndexedSubscript:2];
        champion_count++;
    }
    if(_finished_review_ribbon_count >= 10){
        [this_user_champion setObject:[NSNumber numberWithInt:1] atIndexedSubscript:3];
        champion_count++;
    }
    if(_finished_ribbon_count >= 20){
        [this_user_champion setObject:[NSNumber numberWithInt:1] atIndexedSubscript:4];
        champion_count++;
    }
    if(_finished_review_ribbon_count >= 20){
        [this_user_champion setObject:[NSNumber numberWithInt:1] atIndexedSubscript:5];
        champion_count++;
    }
    if(_finished_ribbon_count >= 50){
        [this_user_champion setObject:[NSNumber numberWithInt:1] atIndexedSubscript:6];
        champion_count++;
    }
    if(_finished_review_ribbon_count >= 50){
        [this_user_champion setObject:[NSNumber numberWithInt:1] atIndexedSubscript:7];
        champion_count++;
    }
    if(_finished_ribbon_count >= 100){
        [this_user_champion setObject:[NSNumber numberWithInt:1] atIndexedSubscript:8];
        champion_count++;
    }
    if(_finished_review_ribbon_count >= 100){
        [this_user_champion setObject:[NSNumber numberWithInt:1] atIndexedSubscript:9];
        champion_count++;
    }
    if(_finished_ribbon_count >= 200){
        [this_user_champion setObject:[NSNumber numberWithInt:1] atIndexedSubscript:10];
        champion_count++;
    }
    if(_finished_review_ribbon_count >= 200){
        [this_user_champion setObject:[NSNumber numberWithInt:1] atIndexedSubscript:11];
        champion_count++;
    }
    if(_finished_ribbon_count >= 500){
        [this_user_champion setObject:[NSNumber numberWithInt:1] atIndexedSubscript:12];
        champion_count++;
    }
    if(_finished_review_ribbon_count >= 500){
        [this_user_champion setObject:[NSNumber numberWithInt:1] atIndexedSubscript:13];
        champion_count++;
    }
    if(_finished_ribbon_count >= 1000){
        [this_user_champion setObject:[NSNumber numberWithInt:1] atIndexedSubscript:14];
        champion_count++;
    }
    if(_finished_review_ribbon_count >= 1000){
        [this_user_champion setObject:[NSNumber numberWithInt:1] atIndexedSubscript:15];
        champion_count++;
    }
    
    return champion_count;
}

// 刷新统计数据
- (void)update_static_data{
    if (data_flag == STATISTICS_DATA_DIRTY){
        if (root_ribbons != nil) {
            [self zero_data];
            
            for (Ribbon_info *my_ribbon_info in root_ribbons.Ribbon_infos){
                card_total += my_ribbon_info.Card_count;        // card 总数
                thread_total += my_ribbon_info.Thread_count;    // thread 总数
                finish_thread_count += my_ribbon_info.Last_momery_thread;       // 已完成的thread总数。
                this_user_memory_index += [my_ribbon_info get_this_ribbon_memory_index];  // 计算memory指数。
                
                // 计算 ready ribbon 的数量。
                if([my_ribbon_info is_ready]){
                    ready_ribbon_count++;
                    
                    // 计算已完成的就绪的ribbon的数量。
                    if ([my_ribbon_info is_finished]){
                        finish_one_time_count++;
                        if ([my_ribbon_info is_finished_twins]) {
                            finish_two_time_count++;
                        }else if([my_ribbon_info is_finished_more]) {
                            finish_three_or_more_time_count++;
                        }
                    }
                }
            }
            // 国民收入倍增计划.
            int champion_count = [self calculate_champion:finish_one_time_count review_ribbon:finish_three_or_more_time_count];
            for (int ii = 0; ii < champion_count; ii++) {
                this_user_memory_index *= 2.0;
            }
            
            // switch
            data_flag = STATISTICS_DATA_UPDATED;
        }
    }
}

// 获取ribbon总数
- (int)get_ribbon_count{
    if (root_ribbons != nil) {
        return root_ribbons.Ribbon_infos.count;
    }else{
        return 0;
    }
}

// 获取就绪的ribbon
// 对于就绪的标准，目前只有一个：card数超过95的。将来所有的ribbon都在服务器端完成，则可以加上由领域专家审核通过后的原则。
- (int)get_ready_ribbon_count{
    [self update_static_data];
    return ready_ribbon_count;
}

// 获取总的card数
- (int)get_card_total{
    [self update_static_data];
    return card_total;
}

// 获取总的thread数
- (int)get_thread_total{
    [self update_static_data];
    return thread_total;
}

// 获取记忆完成一次或更多的ribbon数（为了推动人们总是一个个ribbon的记完整，未完成的不计）
- (int)get_finish_one_time_count{
    [self update_static_data];
    return finish_one_time_count;
}

- (int)get_finish_two_time_count{
    [self update_static_data];
    return finish_two_time_count;
}

- (int)get_finish_three_or_more_time_count{
    [self update_static_data];
    return finish_three_or_more_time_count;
}

// 获取总的记忆过的thread的数量。包括未就绪的ribbon也算。
- (int)get_finish_thread_count{
    [self update_static_data];
    return finish_thread_count;
}

// 获取当前用户的勋章
- (NSMutableArray *)get_this_user_champion{
    [self update_static_data];
    return this_user_champion;
}

// 获取当前勋章描述字符串
- (NSMutableArray *)get_champion_des{
    [self update_static_data];
    return champion_des;
}

// 获取当前用户的memory 指数
// memory指数以完成的thread为基础。并加上如下三个双方：
// 1.对于完成记忆的就绪thread，要给予奖励。
// (1)完成1次，奖励thread数的0.5倍；
// (2)完成2次，奖励thread数的1倍；
// (3)完成3次及以上的，奖励thread数的2倍.
// 2.对于勋章者，要重重有奖，每多获得一枚勋章，直接*2. (这个倍增有点狠，后续可能会调整。)
// 3.在倍增的情况下，总体指数，如果一个人得到“宗师出世”且加衔“温故知新”的话，那他的memory指数可能会超过int的范围，所以规定总数 / 10.（每记一个thread，指数增加0.1，可以看出来）
- (float)get_this_user_memory_index{
    [self update_static_data];
    return this_user_memory_index;
}

// 获取当前用户的全球排名. 排名的标准就素memory指数。
- (int)get_this_user_global_rank{
    return 1;
}

@end
