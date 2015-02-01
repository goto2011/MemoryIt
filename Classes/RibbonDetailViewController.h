//
//  RibbonDetailViewController.h
//  MemoryIt
//
//  Created by duangan on 12-11-19.
//
//

#import <UIKit/UIKit.h>
#import "Ribbon.h"
#import "MemoryItViewController.h"

@interface RibbonDetailViewController : UITableViewController{
    MemoryItViewController *root_view_controller;
    Ribbon *current_ribbon;
}

@property (retain, nonatomic)Ribbon *current_ribbon;
@property (retain, nonatomic)MemoryItViewController *root_view_controller;

@property (nonatomic, retain)IBOutlet UITableView *tableView;

@end
