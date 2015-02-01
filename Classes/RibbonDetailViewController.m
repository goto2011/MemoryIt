//
//  RibbonDetailViewController.m
//  MemoryIt
//
//  Created by duangan on 12-11-19.
//  显示全文。
//

#import "RibbonDetailViewController.h"
#import "Ribbons.h"
#import "UI_manager.h"

@interface RibbonDetailViewController ()

@end

@implementation RibbonDetailViewController
@synthesize current_ribbon;
@synthesize root_view_controller;

- (void)viewDidUnload
{
    [current_ribbon release];
    current_ribbon = nil;
    
    [root_view_controller release];
    root_view_controller = nil;
        
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

// 显示 ribbon list 界面
- (void)show_ribbon_list_view{
    if (root_view_controller != nil) {
        [root_view_controller show_view_by_type:RIBBON_LIST_FIRST_VIEW];
    }
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Ribbons *current_ribbons = [Ribbons sharedRibbons];
    if([current_ribbons get_current_ribbon_info] != nil){
        current_ribbon = [[Ribbon alloc]init:
                          [current_ribbons get_current_ribbon_info].File_name];
    }else{
        current_ribbon = nil;
    }
    
    [current_ribbons release];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
// 指定行数
-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section {
    // 因为Q-A对。
	return [current_ribbon card_count] * 2;
}

// 设置行高
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return [UI_manager get_ribbon_detail_line_hight];
}


// 设置表格的显示风格和内容
-(UITableViewCell *)tableView:(UITableView *)tableView
		cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	static NSString *SimpleTableIdentifier = @"Ribbon Detail Cell";
	
	UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
	if(cell == nil){
		// 初始化表单元，并给定显示风格。
		cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle
									  reuseIdentifier:SimpleTableIdentifier]autorelease];
        
        UILabel *Datalabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 44)];
        [Datalabel setTag:100];
        Datalabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [cell.contentView addSubview:Datalabel];
        [Datalabel release];
	}
    
	NSUInteger row = [indexPath row];
    NSUInteger ribbon_index = row / 2;
    NSMutableString *cell_content = [[NSMutableString alloc] init];
    UILabel *CellLabel = (UILabel *)[cell.contentView viewWithTag:100];

	// 设置显示的文本
    if (row % 2 == 0) {
        cell_content = [@"Q:" mutableCopy];
        [cell_content appendString:[[current_ribbon get_card_at_index:ribbon_index] question_string]];
        
        [CellLabel setFont:[UI_manager get_ribbon_detail_caption_font]];
        [CellLabel setBackgroundColor:[UIColor clearColor]];
    }else{
        cell_content = [@"A:" mutableCopy];
        [cell_content appendString:[[current_ribbon get_card_at_index:ribbon_index] answer_string]];
        
        [CellLabel setFont:[UI_manager get_ribbon_detail_context_font]];
        [CellLabel setBackgroundColor:[UIColor clearColor]];
    }
    
    CellLabel.numberOfLines = [UI_manager get_ribbon_detail_lines];
    CellLabel.text = cell_content;
    
	// cell.textLabel.text = cell_content;
    // cell.textLabel.font = [UI_manager get_ribbon_detail_main_font];
    
    // 设置显示风格
    // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

	return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
