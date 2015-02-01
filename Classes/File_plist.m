//
//  File_plist.m
//  MemoryIt
//
//  Created by duangan on 12-6-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "File_plist.h"
#import "Card.h"

@implementation File_plist
@synthesize ribbon_file_name;

// init with ribbon file name.
- (id) init:(NSString *)_ribbon_file_name{
    ribbon_file_name = _ribbon_file_name;
    
    return self;
}

// read data from plist file to cards.
- (id) read_data_to_card:(NSMutableArray *)_Cards{
    // read file.
    NSDictionary * q_a_dict = [[NSDictionary alloc]initWithContentsOfFile:ribbon_file_name];
    NSArray *question_list = [q_a_dict allKeys];

    for(NSString *temp_question in question_list){
        NSString *temp_answer = [q_a_dict objectForKey:temp_question];
        NSLog(@"read_data_from_file() Q:%@; A:%@.", temp_question, temp_answer);
    
        // class init.
        Card *this_card = [[Card alloc]init];
        this_card.question_string = temp_question;
        this_card.answer_string = temp_answer;
    
        // array add a object.
        [_Cards addObject:this_card];
        NSLog(@"read_data_from_file() now cards has %d items.", [_Cards count]);
    }
    
    return self;
}

@end
