//
//  MemoryItViewController.m
//  MemoryIt
//
//  Created by duangan on 12-5-3.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//


#import "base_types.h"
#import "base_ST_obj.h"
#import "MemoryItViewController.h"
#import "ThreadShowViewController.h"
#import "RibbonListViewController.h"
#import "RibbonDetailViewController.h"

@implementation MemoryItViewController

@synthesize thread_show_view;
@synthesize ribbon_list_view;
@synthesize ribbon_detail_view;

#pragma mark -
#pragma mark prinf view layout.
// 打印视图树
- (void) print_view_tree:(UIView *)aView  at_index:(int)indent
{
	NSMutableString *outstring = [[NSMutableString alloc] init];
    
	for (int i = 0; i < indent; i++) {
        [outstring appendString:@"--"];
    }
	[outstring appendFormat:@"[%2d] %@\n", indent, [[aView class] description]];
    NSLog(@"%@", outstring);
    
	for (UIView *view in [aView subviews]){
        [self print_view_tree:view at_index:indent + 1];
    }
}


// 以动画方式切换界面.内部函数
- (void)thread_switch_use_animation:(UIViewController *)_new_view
                          from_view:(UIViewController *)_old_view{
    [UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationDuration:0.6];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:
     UIViewAnimationTransitionFlipFromRight
                           forView:self.view cache:YES];
    
    // [_old_view viewWillAppear:YES];
    // [_new_view viewWillDisappear:YES];
    [_old_view.view removeFromSuperview];
    [self.view insertSubview:_new_view.view atIndex:0];
    [_new_view viewDidDisappear:YES];
    [_old_view viewDidAppear:YES];

    // print view layout.
    // 打印太多，后续调界面再打开。
    // [self print_view_tree:self.view at_index:0];
}

// 获取主页的类型。
- (BOOL)show_view_by_type:(first_view_type)_spec_view_type{
    // thread show.
    NSLog(@"show_view_by_type() enter.");
    
    if (_spec_view_type == THREAD_SHOW_FIRST_VIEW) {
        if (self.thread_show_view == nil) {
            ThreadShowViewController *temp_thread_show_view = [[ThreadShowViewController alloc]initWithNibName:@"ThreadShowViewController" bundle:nil];
            
            self.thread_show_view = temp_thread_show_view;
            temp_thread_show_view.root_view_controller = self;
            
            [temp_thread_show_view release];
        }
        [self thread_switch_use_animation:thread_show_view from_view:ribbon_list_view];
        
        // 将 tab bar界面隐藏起来。
        
    // ribbon list.
    }else if(_spec_view_type == RIBBON_LIST_FIRST_VIEW) {
        if (self.ribbon_list_view == nil) {
            RibbonListViewController *temp_ribbon_list_view = [[RibbonListViewController alloc]initWithNibName:@"RibbonListViewController" bundle:nil];
            
            self.ribbon_list_view = temp_ribbon_list_view;
            temp_ribbon_list_view.root_view_controller = self;
            
            [temp_ribbon_list_view release];
        }
        [self thread_switch_use_animation:ribbon_list_view from_view:thread_show_view];
    // ribbon detail
    }else if(_spec_view_type == RIBBON_DETAIL_SHOW){
        if (self.ribbon_detail_view == nil) {
            RibbonDetailViewController *temp_ribbon_detail_view = [[RibbonDetailViewController alloc]initWithNibName:@"RibbonDetailViewController" bundle:nil];
            
            self.ribbon_detail_view = temp_ribbon_detail_view;
            temp_ribbon_detail_view.root_view_controller = self;
            
            [temp_ribbon_detail_view release];
        }
        [self thread_switch_use_animation:ribbon_detail_view from_view:ribbon_list_view];
    }
    return TRUE;
}

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    // show ribbon list.
    [self show_view_by_type:RIBBON_LIST_FIRST_VIEW];
    
    [super viewDidLoad];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    // return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return TRUE;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	self.thread_show_view = nil;
    self.ribbon_list_view = nil;
}


- (void)dealloc {
    [thread_show_view release];
    [ribbon_list_view release];
    
    [super dealloc];
}

@end
