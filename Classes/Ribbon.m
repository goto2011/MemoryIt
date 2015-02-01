//
//  Ribbon.m
//  MemoryIt
//
//  Created by duangan on 12-5-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
//  This module handle file system api to isolate file phsical changes in the futher with other modules.

#import "base_types.h"
#import "Ribbon.h"
#import "Card.h"
#import "Thread.h"
#import "Way.h"
#import "File_plist.h"
#import "File_txt.h"

@implementation Ribbon

// #define DEFALUT_RIBBON_FILE @"english_chinese_4_grace.plist"
#define DEFALUT_RIBBON_FILE @"read_me.txt"

@synthesize ribbon_file_name;
@synthesize card_count;
@synthesize thread_count;
@synthesize Cards;
@synthesize Threads;

// get preset resource file in app. only for UT.
- (NSString *)get_preset_file:(NSString *)_file_name{
	NSBundle *main_bundle = [NSBundle mainBundle];
	return [main_bundle pathForResource:_file_name ofType:nil];
}

// return ribbon file name.
- (NSString *) ribbon_file_name{
	return ribbon_file_name;
}


// return card count.
- (NSInteger)card_count{
    // array item count.
    return [Cards count];
}


// return thread count.
- (NSInteger)thread_count{
    // array item count.
    return [Threads count];
}

// get card object from card index.
- (Card *)get_card_at_index:(uint32)card_index{
    
    if (card_index > [Cards count]) {
        NSLog(@"get_card_at_index() error:card index is too big. Max value is %d; current value is %d.",[Cards count], card_index);
    }
    return [Cards objectAtIndex:card_index];
}

// get card object from thread index.
-(Card *)get_thread_at_index:(uint32)display_index{
    if (display_index >= [Threads count]) {
        NSLog(@"get_card_at_index() error:display index is too big. Max value is %d; current value is %d.",[Threads count], display_index);
        return nil;
    }
    
    // get card index from thread index.
    Thread *temp_thread = [Threads objectAtIndex:display_index];
    uint32 card_index = [temp_thread card_index];
    
    return [self get_card_at_index:card_index];
}

// core function: create threads from cards.
/*
 also use this form:
 - (void) create_threads_from_cards:(NSMutableArray *)_Cards
                         to_threads:(NSMutableArray *)_Threads
 */
- (void) create_threads_from_cards{
    Way *crrent_way = [[Way alloc]init];
    [crrent_way create_threads_from_cards:[Cards count]
                               to_threads:Threads];
    
    // [crrent_way release];
    
    // NSLog(@"create_threads_from_cards() cards has %d items.", [Cards count]);
    // NSLog(@"create_threads_from_cards() threads has %d items.", [Threads count]);
}

// read card data to array.
- (void)read_data_from_file:(NSString *)ribbon_file{
    File_txt *current_data_file = [[File_txt alloc]init:ribbon_file];
    [current_data_file read_data_to_card:Cards];
    
    NSLog(@"read_data_from_file() is finish.");
}

// init data from file
- (void) init_data{
    // check file exists.
    if ([[NSFileManager defaultManager] fileExistsAtPath:ribbon_file_name]){
        // init array
        Cards = [NSMutableArray arrayWithCapacity:DEFAULT_CARD_COUNT];
        Threads = [NSMutableArray arrayWithCapacity:DEFAULT_THREAD_COUNT];
        
        [Cards retain];
        [Threads retain];
        
        // read file.
        [self read_data_from_file:ribbon_file_name];
        
        // hash.
        [self create_threads_from_cards];
    }else {
        // fatol error print(notice: how to print a string?)
        NSLog(@"Class:Ribbon init_data(). error: no spec ribbon file: %@",ribbon_file_name);
    }
}


// init ribbon without param.
- (id) init{
    if(self = [super init]){
        ribbon_file_name = [self get_preset_file:DEFALUT_RIBBON_FILE];
        [self init_data];
    }
    return (self);
}


// init ribbon from spec file.
- (id) init:(NSString *)ribbon_file{
    if(self = [super init]){
        // check param is valid.
        if([ribbon_file length] == 0){
            // use default ribbon.
            ribbon_file_name = [self get_preset_file:DEFALUT_RIBBON_FILE];
        }else{
            ribbon_file_name = [self get_preset_file:ribbon_file];
        }
        
        [self init_data];
    }
    
    return (self);
}

// delete myself
- (void) dealloc{
    [Cards release];
    [Threads release];
    
    [super dealloc];
}

@end
