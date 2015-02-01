//
//  StatisticsViewController.m
//  MemoryIt
//
//  Created by duangan on 12-10-25.
//
//

#import "StatisticsViewController.h"
#import "User_manager.h"

@interface StatisticsViewController ()

@end

@implementation StatisticsViewController

@synthesize fieldLabels;
@synthesize fieldTextview;
@synthesize stat_data;
@synthesize root_ribbons;

// 返回前一个界面.
-(IBAction)goBack:(id)sender{
    [stat_data you_need_update_data];
    [self.navigationController popViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

// 刷新数据
- (void)update_data{
    [self.fieldTextview replaceObjectAtIndex:0 withObject:[NSNumber numberWithInt:[stat_data get_ribbon_count]]];
    [self.fieldTextview replaceObjectAtIndex:1 withObject:[NSNumber numberWithInt:[stat_data get_ready_ribbon_count]]];
    [self.fieldTextview replaceObjectAtIndex:2 withObject:[NSNumber numberWithInt:[stat_data get_card_total]]];
    [self.fieldTextview replaceObjectAtIndex:3 withObject:[NSNumber numberWithInt:[stat_data get_thread_total]]];
    [self.fieldTextview replaceObjectAtIndex:4 withObject:[NSNumber numberWithInt:[stat_data get_finish_one_time_count]]];
    [self.fieldTextview replaceObjectAtIndex:5 withObject:[NSNumber numberWithInt:[stat_data get_finish_two_time_count]]];
    [self.fieldTextview replaceObjectAtIndex:6 withObject:[NSNumber numberWithInt:[stat_data get_finish_three_or_more_time_count]]];
    [self.fieldTextview replaceObjectAtIndex:7 withObject:[NSNumber numberWithInt:[stat_data get_finish_thread_count]]];
    [self.fieldTextview replaceObjectAtIndex:8 withObject:[NSNumber numberWithFloat:[stat_data get_this_user_memory_index]]];
    [self.fieldTextview replaceObjectAtIndex:9 withObject:[NSNumber numberWithInt:[stat_data get_this_user_global_rank]]];
}

// 界面重新刷新.
// TODO:更优的方案是指定cell刷新。
- (void)viewWillAppear:(BOOL)animated{
    [stat_data you_need_update_data];
    [self update_data];
    
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 初始化数据
    root_ribbons = [Ribbons sharedRibbons];
    stat_data = [[Statistics alloc]init:root_ribbons user_serial:[User_manager get_user_serial]];
    
    NSArray *array = [[NSArray alloc] initWithObjects:@"Ribbon数量累计:", @"就绪Ribbon数量累计:",
                      @"Card数量累计:", @"Thread数量累计:", @"完成记忆的ribbon数量:", @"记忆两次的ribbon数量:",
                      @"记忆三次及以上的ribbon数量:", @"完成记忆的thread数量:", @"总体Memory指数:",
                      @"Memory指数全球排名:", @"你收集到的勋章:", nil];
    self.fieldLabels = array;
    [array release];

    NSMutableArray *array2 = [[NSMutableArray alloc]initWithObjects:
           [NSNumber numberWithInt:[stat_data get_ribbon_count]],
           [NSNumber numberWithInt:[stat_data get_ready_ribbon_count]],
           [NSNumber numberWithInt:[stat_data get_card_total]],
           [NSNumber numberWithInt:[stat_data get_thread_total]],
           [NSNumber numberWithInt:[stat_data get_finish_one_time_count]],
           [NSNumber numberWithInt:[stat_data get_finish_two_time_count]],
           [NSNumber numberWithInt:[stat_data get_finish_three_or_more_time_count]],
           [NSNumber numberWithInt:[stat_data get_finish_thread_count]],
           [NSNumber numberWithFloat:[stat_data get_this_user_memory_index]],
           [NSNumber numberWithInt:[stat_data get_this_user_global_rank]],
           @" ", nil];
    self.fieldTextview = array2;
    [array2 release];
    
    UIBarButtonItem *goBackButton = [[UIBarButtonItem alloc]
                                     initWithTitle:@"返回"
                                     style:UIBarButtonItemStyleDone
                                     target:self
                                     action:@selector(goBack:)];
    self.navigationItem.leftBarButtonItem = goBackButton;
    [goBackButton release];
}

- (void)dealloc {
    [fieldLabels release];
    [fieldTextview release];
    [Statistics release];
    [root_ribbons release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return 27;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *StatisticsCellIdentifier = @"Statistics";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             StatisticsCellIdentifier];
    if (cell == nil) {
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:StatisticsCellIdentifier] autorelease];
        // cell.textLabel.textAlignment = UITextAlignmentCenter;
        
        // text label.
        UILabel *label = [[UILabel alloc] initWithFrame:
                          CGRectMake(10, 10, 180, 25)];
        label.textAlignment = UITextAlignmentRight;
        label.tag = kLabelTag;
        label.font = [UIFont boldSystemFontOfSize:14];
        [cell.contentView addSubview:label];
        [label release];
        
        // text view.
        UITextView *textView = [[UITextView alloc] initWithFrame:
                                CGRectMake(200, 12, 100, 25)];
        textView.editable = NO;
        textView.tag = KTextViewTag;
        [cell.contentView addSubview:textView];
        [textView release];
    }
    NSUInteger row = [indexPath row];
    
    UILabel *label = (UILabel *)[cell viewWithTag:kLabelTag];
    UITextView *textView = (UITextView *)[cell viewWithTag:KTextViewTag];
    
    // 显示统计数据。
    int line_limit = [fieldLabels count];
    if (row < line_limit) {
        label.text = [fieldLabels objectAtIndex:row];
        textView.text = [NSString stringWithFormat:@"%@", [fieldTextview objectAtIndex:row]];
    }else{
        // 显示勋章。
        if (row < [[stat_data get_champion_des] count] + line_limit) {
            label.text = [[stat_data get_champion_des] objectAtIndex:(row - line_limit)];
            
            NSNumber *temp_number = [[stat_data get_this_user_champion] objectAtIndex:(row - line_limit)];
            textView.text = [NSString stringWithFormat:@"%d", [temp_number intValue]];
        }
    }
    
    return cell;
}


@end
