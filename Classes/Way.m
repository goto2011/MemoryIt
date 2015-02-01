//
//  Way.m
//  MemoryIt
//
//  Created by duangan on 12-5-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "base_types.h"
#import "Way.h"
#import "Thread.h"

@implementation Way

@synthesize thread_way_type;
@synthesize pressure_index;
@synthesize unit_item_count;
@synthesize review_point;
@synthesize card_item_count;

#define REVIEW_ITEM_COUNT  (unit_item_count * review_point)

// create threads from cards.
- (void) create_threads_from_cards:(int)_cards_count
                        to_threads:(NSMutableArray *)_Threads{
    
    card_item_count = _cards_count;
    
    switch (thread_way_type) {
        case NORMAL_WAY:
            // 三个一组，逢二回环。
            unit_item_count = 3;
            review_point = 2;
            
            [self create_threads_by_normal_way:_Threads];
            break;
            
        default:
            break;
    }
}

// create threads by normal way.
- (void) create_threads_by_normal_way:(NSMutableArray *)_Threads{
     
    for(uint32 cycle_index = 0; cycle_index < card_item_count; cycle_index++){
        // 三个一组
        if((cycle_index % unit_item_count) == 0){
            [self create_memory_threads_to:_Threads
                          start_card_index:cycle_index];
        }
        
        // 逢二回环
        if(((cycle_index + 1) % REVIEW_ITEM_COUNT) == 0){
            [self create_review_threads_to:_Threads 
                             recycle_count:((cycle_index + 1) / unit_item_count)
                            recycle_length:REVIEW_ITEM_COUNT
                            end_card_index:(cycle_index + 1)];
        }
        
        // TODO: rest card need to recycle.
    }
    
//    NSLog(@"create_threads_by_normal_way():  %d threads.", [_Threads count]);
//    for (Thread *temp_thread in _Threads) {
//        NSLog(@"create_threads_by_normal_way():  %d", [temp_thread card_index]);
//    }
}

// create memory threads from cards.
// _Threads: des object.
// _start_card_index: the first index to recycle.
- (void)create_memory_threads_to:(NSMutableArray *)_Threads
                  start_card_index:(uint32)_start_card_index{
    
    for(uint32 add_unit = 0; add_unit < unit_item_count; add_unit++){
        for(uint32 add_index = (_start_card_index + add_unit); 
                 add_index < (_start_card_index + unit_item_count); 
                 add_index++){
            [self add_uint32_to_array:_Threads 
                             from_int:add_index
                              at_step:MEMORY_STEP];
        }
        
        // recycle.
        for(uint32 add_index = _start_card_index; 
                   add_index < (_start_card_index + add_unit); add_index++){
                [self add_uint32_to_array:_Threads 
                                 from_int:add_index
                                  at_step:MEMORY_STEP];
        }
    }    
}

// create review threads from cards.
// _Threads: des object.
// recycle_count: unit recycle count controller.
// end_card_index: end card index during unit recycle. readonly.
- (void)create_review_threads_to:(NSMutableArray *)_Threads
                   recycle_count:(uint32)_recycle_count
                  recycle_length:(uint32)_recycle_length
                  end_card_index:(uint32)_end_card_index{
    
    if(_recycle_count >= review_point){
        if((_recycle_count % review_point) == 0){
            for(uint32 add_index = (_end_card_index - _recycle_length); 
                                    add_index < _end_card_index; 
                                    add_index++){
                [self add_uint32_to_array:_Threads 
                                 from_int:add_index
                                  at_step:REVIEW_STEP];
            }
            
            [self create_review_threads_to:_Threads 
                             recycle_count:(_recycle_count / review_point)
                            recycle_length:(_recycle_length * review_point)
                            end_card_index:_end_card_index];
        }
    }
}

// add uint32 to array.
- (id)add_uint32_to_array:(NSMutableArray *)_des_array 
                 from_int:(uint32)_res_number 
                  at_step:(step_type)_step_type {
    
    // confirm card index is valid.
    if(_res_number < (card_item_count - 1))
    {
        Thread *temp_thread = [[Thread alloc]init];
    
        // pls notice how to handle number.
        temp_thread.card_index = _res_number;
        temp_thread.current_step = _step_type;
    
        [_des_array addObject:temp_thread];
    
        [temp_thread release];
    }
    
    return _des_array;
}

// init with 0 param.
- (id) init{
    if (self = [super init]){
        thread_way_type = NORMAL_WAY;
        pressure_index = 10;
    }
    
    return (self); 
}

@end
