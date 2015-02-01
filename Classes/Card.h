//
//  Cards.h
//  MemoryIt
//
//  Created by duangan on 12-5-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject{
    NSString *question_string;
    NSString *answer_string;
}

@property (retain, nonatomic)NSString *question_string;
@property (retain, nonatomic)NSString *answer_string;

@end
