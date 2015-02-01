//
//  File_txt.h
//  MemoryIt
//
//  Created by duangan on 12-6-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface File_txt : NSObject{
    @private NSString * ribbon_file_name;
}

@property(retain, nonatomic)NSString *ribbon_file_name;

- (id) init:(NSString *)_ribbon_file_name;
- (id) read_data_to_card:(NSMutableArray *)_Cards;

@end
