//
//  RibbonListViewController.m
//  MemoryIt
//
//  Created by duangan on 12-6-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RibbonListViewController.h"
#import "Ribbon_info.h"
#import "UI_manager.h"

// private
@interface RibbonListViewController ()
   @property (nonatomic, strong) PopupListComponent* activePopup;
@end

@implementation RibbonListViewController

@synthesize current_ribbons;
@synthesize root_view_controller;
@synthesize activePopup;

- (void)viewDidUnload
{
    [current_ribbons release];
    current_ribbons = nil;
    
    [root_view_controller release];
    root_view_controller = nil;
    
    [activePopup release];
    activePopup = nil;
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // 初始化 ribbons 类
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    current_ribbons = [Ribbons sharedRibbons];
    // Do any additional setup after loading the view from its nib.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return TRUE;
}

// 界面重新刷新.
// TODO:更优的方案是指定cell刷新。
- (void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark Table View data source methods
// 指定行数
-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section {
	return [current_ribbons get_ribbon_count];
}

// 设置行高
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return [UI_manager get_ribbon_list_line_hight];
}

// 设置表格的显示风格和内容
-(UITableViewCell *)tableView:(UITableView *)tableView
		cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	static NSString *SimpleTableIdentifier = @"Ribbon list cell";
	
	UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
	if(cell == nil){
		// 初始化表单元，并给定显示风格。
		cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle
									  reuseIdentifier:SimpleTableIdentifier]autorelease];
	}
	NSUInteger row = [indexPath row];
	
    // 设置图标    
	cell.imageView.image = [UI_manager get_ribbon_list_percent_icon:[[current_ribbons get_ribbon_info:row]  get_finished_percent]];
	cell.imageView.highlightedImage = [UI_manager get_ribbon_list_percent_icon_selected:[[current_ribbons get_ribbon_info:row]  get_finished_percent]];
    
	// 设置显示的文本
    NSString *this_ribbon_name = [[current_ribbons get_ribbon_info:row] Ribbon_name];
    NSString *this_ribbon_file = [[current_ribbons get_ribbon_info:row] File_name];
    int card_count      = [[current_ribbons get_ribbon_info:row] Card_count];
    NSString *detail_string = [[NSString alloc]initWithFormat:@"%@  (%d)", this_ribbon_file, card_count];
        
	cell.textLabel.text = this_ribbon_name;
	cell.detailTextLabel.text = detail_string;
	
	// 设置字体
	cell.textLabel.font = [UI_manager get_ribbon_list_main_font];
    
    // 设置显示风格
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    // 设置选中状态，并滚动过去。
    if (row == [current_ribbons Current_ribbon_info_index]) {
        [[current_ribbons get_ribbon_info:row] print_info];
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
        [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
	
	return cell;
}

#pragma mark -
#pragma mark Table Delegate Methods
// 处理交互，用户选择处理的前端。
-(NSIndexPath *)tableView:(UITableView *)tableView
 willSelectRowAtIndexPath:(NSIndexPath *)indexPath{	
#if (0)
    // 第一行不让选要这样做。
	NSUInteger row = [indexPath row];

	if (row == 0)
		return nil;
#endif
    
	return indexPath;
}


// 显示 thread view 界面
- (void)show_thread_view{
    if (root_view_controller != nil) {
        [root_view_controller show_view_by_type:THREAD_SHOW_FIRST_VIEW];
    }
}


// 用户选择行处理的后端。
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    current_ribbons.Current_ribbon_info_index = [indexPath row];
    
    // TODO:将这行设置为脏数据，这个是最顺理成章的办法。
    
    // 显示 thread view 界面
    [self show_thread_view];

	// [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
#if 0
    NSUInteger row = [indexPath row];
	SecondViewController *nextController = [self.controllers objectAtIndex:row];
	[self.navigationController pushViewController:nextController animated:YES];
#endif
}

// 用户选中展示按钮时
- (void)tableView:(UITableView *)tableView
accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    current_ribbons.Current_ribbon_info_index = [indexPath row];

    if (root_view_controller != nil) {
        [root_view_controller show_view_by_type:RIBBON_DETAIL_SHOW];
    }
}

// 显示弹出式菜单
- (void) show_popmenu{
    // Put up a list of images with captions
    if (self.activePopup) {
        // A popup is already active. Since we re-use our PopupListComponent object
        // for all popups, we need to cancel the active popup first:
        [self.activePopup hide];
    }
    
    PopupListComponent *popupList = [[PopupListComponent alloc] init];
    NSArray* listItems = nil;
    listItems = [NSArray arrayWithObjects:
                 [[PopupListComponentItem alloc] initWithCaption:@"Red" image:[UIImage imageNamed:@"color_red"]
                                                          itemId:1 showCaption:YES],
                 [[PopupListComponentItem alloc] initWithCaption:@"Green"  image:[UIImage imageNamed:@"color_green"]
                                                          itemId:2 showCaption:YES],
                 [[PopupListComponentItem alloc] initWithCaption:@"Blue Text Here"  image:[UIImage imageNamed:@"color_blue"]
                                                          itemId:3 showCaption:YES],
                 nil];
    
    // Optional: override any default properties you want to change:
    popupList.imagePaddingHorizontal = 5;
    popupList.imagePaddingVertical = 2;  // Images are taller than text, so this will be determining factor!
    popupList.textPaddingHorizontal = 5;
    popupList.alignment = UIControlContentHorizontalAlignmentLeft;
    [popupList useSystemDefaultFontNonBold];  // Instead of bold font, which is component default.
    
    // Optional: store any object you want to have access to in the delegeate callback(s):
    popupList.userInfo = @"Value to hold on to";
    
    [popupList showAnchoredTo:nil inView:self.view withItems:listItems withDelegate:self];
    // [popupList showAnchoredTo:nil inView:self.view withItems:listItems withDelegate:self];
    
    self.activePopup = popupList;
}

#pragma mark - Delegate Callbacks
- (void) popupListcomponent:(PopupListComponent *)sender choseItemWithId:(int)itemId
{
    NSLog(@"User chose item with id = %d", itemId);
    
    // If you stored a "userInfo" object in the popup, access it as:
    id anyObjectToPassToCallback = sender.userInfo;
    NSLog(@"popup userInfo = %@", anyObjectToPassToCallback);
    
    // Free component object, since our action method recreates it each time:
    self.activePopup = nil;
}

- (void) popupListcompoentDidCancel:(PopupListComponent *)sender
{
    NSLog(@"Popup cancelled");
    
    // Free component object, since our action method recreates it each time:
    self.activePopup = nil;
}

@end
