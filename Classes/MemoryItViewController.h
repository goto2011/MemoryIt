//
//  MemoryItViewController.h
//  MemoryIt
//
//  Created by duangan on 12-5-3.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "base_types.h"

@class ThreadShowViewController;
@class RibbonListViewController;
@class RibbonDetailViewController;

@interface MemoryItViewController : UIViewController{
    ThreadShowViewController *thread_show_view;
    RibbonListViewController *ribbon_list_view;
    RibbonDetailViewController *ribbon_detail_view;
}

@property (retain, nonatomic)ThreadShowViewController *thread_show_view;
@property (retain, nonatomic)RibbonListViewController *ribbon_list_view;
@property (retain, nonatomic)RibbonDetailViewController *ribbon_detail_view;

- (BOOL)show_view_by_type:(first_view_type)_spec_view_type;

@end

