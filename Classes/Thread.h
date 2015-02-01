//
//  Thread.h
//  MemoryIt
//
//  Created by duangan on 12-6-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "base_types.h"

@interface Thread : NSObject{
    uint32 card_index;
    step_type current_step;
}

@property (assign, nonatomic, readwrite)uint32 card_index;
@property (assign, nonatomic, readwrite)step_type current_step;

@end
