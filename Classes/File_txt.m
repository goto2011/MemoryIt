//
//  File_txt.m
//  MemoryIt
//
//  Created by duangan on 12-6-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "File_txt.h"
#import "Card.h"

#import <Foundation/NSCharacterSet.h>

@implementation File_txt
@synthesize ribbon_file_name;

// init with ribbon file name.
- (id) init:(NSString *)_ribbon_file_name{
    ribbon_file_name = _ribbon_file_name;
    
    return self;
}

// read data from plist file to cards.
/*
 // : 注释
 ;; : 注释
 :: : 注释
 Q: : question string
 A: : answer string
 Q: and A: must one by one.
 */
- (id) read_data_to_card:(NSMutableArray *)_Cards{
    // read file.
    NSError **my_error = NULL;
    NSString *temp_question = NULL;
    NSString *temp_answer = NULL;
    NSString *total_content = [[NSString alloc]initWithContentsOfFile:ribbon_file_name
                                                             encoding:NSUTF8StringEncoding 
                                                                error:my_error];
    // string separate.
    NSArray *line_strings = [total_content componentsSeparatedByString:@"\n"];
    
    for(NSString *line_string in line_strings){
        // trim space.
        // other param:whitespaceAndNewlineCharacterSet
        [line_string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        // delete blank line.
        if([line_string length] < 2)continue;
        
        NSString *head_string = [line_string substringToIndex:2];
        
        if([head_string isEqualToString:@"Q:"]){
            temp_question = [line_string substringFromIndex:2];
        }
        
        // 不要求 Q 和 A 成对出现，最大限度容忍错误。
        if([head_string isEqualToString:@"A:"] && [line_string length] > 2){
            temp_answer = [line_string substringFromIndex:2];
                
            // NSLog(@"read_data_from_file() Q:%@; A:%@.", temp_question, temp_answer);
            
            // TODO:here need a refactory.
            // class init.
            Card *this_card = [[Card alloc]init];
            this_card.question_string = temp_question;
            this_card.answer_string = temp_answer;
            
            // array add a object.
            [_Cards addObject:this_card];
        }
        
//        NSLog(@"read_data_from_file() now cards has %d items.", [_Cards count]);
    }
    
    return self;
}

@end
