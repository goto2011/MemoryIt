//
//  Ribbon.h
//  MemoryIt
//
//  Created by duangan on 12-5-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "base_types.h"
#import "Card.h"

// 请注意，为何ribbon还需要维护card_count 和 thread_count，毕竟 ribbons 中有 ribbon_info。
// 因为ribbon中的这两个值是从数据源（txt）中读出来的，是真实的值。而ribbon_info是从数据库中读出的，可能是错误的。

@interface Ribbon : NSObject{
	NSString *ribbon_file_name;
    NSInteger card_count;
    NSInteger thread_count;
    
    @private NSMutableArray *Cards;         // save all card data(ori).
    @private NSMutableArray *Threads;       // save all thread data.
}

@property (retain, nonatomic)NSMutableArray *Cards;
@property (retain, nonatomic)NSMutableArray *Threads;

@property (retain, nonatomic)NSString *ribbon_file_name;
@property (assign, nonatomic, readonly)NSInteger card_count;
@property (assign, nonatomic, readonly)NSInteger thread_count;


- (id) init;
- (id) init:(NSString *)ribbon_file_name;

- (Card *)get_thread_at_index:(uint32)display_index;
- (Card *)get_card_at_index:(uint32)card_index;

- (NSInteger)card_count;
- (NSInteger)thread_count;

@end
