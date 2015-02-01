//
//  StatisticsViewController.h
//  MemoryIt
//
//  Created by duangan on 12-10-25.
//
//

#import <UIKit/UIKit.h>
#import "Statistics.h"

#define kLabelTag                   4096
#define KTextViewTag                4097

@interface StatisticsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
@private NSArray *fieldLabels;
@private NSMutableArray *fieldTextview;
@private Statistics *stat_data;
@private Ribbons *root_ribbons;
}

@property(retain, nonatomic)NSArray         *fieldLabels;
@property(retain, nonatomic)NSMutableArray  *fieldTextview;
@property(retain, nonatomic)Statistics      *stat_data;
@property(retain, nonatomic)Ribbons         *root_ribbons;

@property (nonatomic, retain)IBOutlet UITableView *tableView;

-(IBAction)goBack:(id)sender;

@end
