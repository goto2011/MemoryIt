//
//  RibbonListViewController.h
//  MemoryIt
//
//  Created by duangan on 12-6-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ribbons.h"
#import "MemoryItViewController.h"
#import "PopupListComponent.h"

@class ThreadShowViewController;

@interface RibbonListViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource, PopupListComponentDelegate>{
    MemoryItViewController *root_view_controller;
    Ribbons *current_ribbons;
}

@property (retain, nonatomic)Ribbons *current_ribbons;
@property (retain, nonatomic)MemoryItViewController *root_view_controller;

@property (nonatomic, retain)IBOutlet UITableView *tableView;

@end
