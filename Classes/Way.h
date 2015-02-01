//
//  Way.h
//  MemoryIt
//
//  Created by duangan on 12-5-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "base_types.h"

@interface Way : NSObject{
    way_type thread_way_type;
    int pressure_index;
    int unit_item_count;
    int review_point;
    @private int card_item_count;     // card item count.
}

// spec the way to create threads from cards.
@property (assign, nonatomic)way_type thread_way_type;

// spec the pressure index during create threads from cards.
@property (assign, nonatomic)int pressure_index;

@property (assign, nonatomic)int unit_item_count;
@property (assign, nonatomic)int review_point;
@property (assign, nonatomic)int card_item_count;

- (void) create_threads_from_cards:(int)_cards_count
                        to_threads:(NSMutableArray *)_Threads;

- (id) init;

@end
