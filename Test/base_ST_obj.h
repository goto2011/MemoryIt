//
//  base_ST_code.h
//  MemoryIt
//
//  Created by duangan on 12-7-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

// 定义第一个显示的界面
// #define DEFALUT_FIRST_VIEW THREAD_SHOW_FIRST_VIEW;
#define DEFALUT_FIRST_VIEW RIBBON_LIST_FIRST_VIEW;


@interface Base_ST_obj : NSObject

+ (Base_ST_obj *)sharedBase_ST_obj;
+ (void)insert_data_to_ribbon;
@end
