//
//  Statistics.h
//  MemoryIt
//
//  Created by duangan on 12-10-28.
//
//

#import <Foundation/Foundation.h>
#import "Ribbons.h"
#import "base_types.h"

@interface Statistics : NSObject{
@private        Ribbons     *root_ribbons;
// user_serial 并非 user id，而是新建用户是创建的一个32位全球唯一字符串。目前尚不需要处理。
@private        NSString    *user_serial;
@private    statistics_data_flag data_flag;
@private    int     ribbon_count;
@private    int     ready_ribbon_count;
@private    int     card_total;
@private    int     thread_total;
@private    int     finish_one_time_count;
@private    int     finish_two_time_count;
@private    int     finish_three_or_more_time_count;
@private    int     finish_thread_count;
@private    NSMutableArray     *this_user_champion;
@private    NSMutableArray     *champion_des;
@private    float   this_user_memory_index;
@private    int     this_user_global_rank;
}

@property (retain, nonatomic)Ribbons *root_ribbons;
@property (retain, nonatomic)NSString *user_serial;

@property (assign, nonatomic)statistics_data_flag data_flag;
@property (assign, nonatomic)int ribbon_count;
@property (assign, nonatomic)int ready_ribbon_count;
@property (assign, nonatomic)int card_total;
@property (assign, nonatomic)int thread_total;
@property (assign, nonatomic)int finish_one_time_count;
@property (assign, nonatomic)int finish_two_time_count;
@property (assign, nonatomic)int finish_three_or_more_time_count;
@property (assign, nonatomic)int finish_thread_count;
@property (retain, nonatomic)NSMutableArray *this_user_champion;
@property (retain, nonatomic)NSMutableArray *champion_des;
@property (assign, nonatomic)float this_user_memory_index;
@property (assign, nonatomic)int this_user_global_rank;

// 获取ribbon总数
- (int)get_ribbon_count;

// 获取就绪的ribbon
// 对于就绪的标准，目前只有一个：card数超过95的。将来所有的ribbon都在服务器端完成，则可以加上由领域专家审核通过后的原则。
- (int)get_ready_ribbon_count;

// 获取总的card数
- (int)get_card_total;

// 获取总的thread数
- (int)get_thread_total;

// 获取记忆完成一次或更多的ribbon数（为了推动人们总是一个个ribbon的记完整，未完成的不计）
- (int)get_finish_one_time_count;
- (int)get_finish_two_time_count;
- (int)get_finish_three_or_more_time_count;

// 获取总的记忆过的thread的数量。包括未就绪的ribbon也算。
- (int)get_finish_thread_count;

// 获取当前用户的勋章
// 完成第1个就绪的ribbon，叫“初试音啼”；
// 完成第10个就绪的ribbon，叫“小试牛刀”
// 完成第20个就绪的ribbon，叫“登堂入室"
// 完成第50个就绪的ribbon，叫“筑基小成"
// 完成第100个就绪的ribbon，叫”中流击楫"
// 完成第200个就绪的ribbon，叫“渐入佳境"
// 完成第500个就绪的ribbon，叫“蔚为大观"
// 完成第1000个就绪的ribbon，叫“宗师出世"
// 完成上面数据的第三遍者，获得同类型加衔“温故知新”
// 共计16枚勋章。
- (NSMutableArray *)get_this_user_champion;
- (NSMutableArray *)get_champion_des;

// 获取当前用户的memory 指数
// memory指数以完成的thread为基础。并加上如下三个双方：
// 1.对于完成记忆的就绪thread，要给予奖励。
// (1)完成1次，奖励thread数的0.5倍；
// (2)完成2次，奖励thread数的1倍；
// (3)完成3次及以上的，奖励thread数的2倍.
// 2.对于勋章者，要重重有奖，每多获得一枚勋章，直接*2. (这个倍增有点狠，后续可能会调整。)
// 3.在倍增的情况下，总体指数，如果一个人得到“宗师出世”且加衔“温故知新”的话，那他的memory指数可能会超过int的范围，所以规定总数 / 10.（每记一个thread，指数增加0.1，可以看出来）
- (float)get_this_user_memory_index;

// 获取当前用户的全球排名. 排名的标准就素memory指数。
- (int)get_this_user_global_rank;

// init
- (id) init:(Ribbons *)_root_ribbons
user_serial:(NSString *)_user_serial;


// 请求重新刷新数据
- (void)you_need_update_data;

@end
