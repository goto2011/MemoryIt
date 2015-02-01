//
//  ThreadShowViewController.m
//  MemoryIt
//
//  Created by duangan on 12-6-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ThreadShowViewController.h"

@implementation ThreadShowViewController

@synthesize uio_question_text;
@synthesize uio_answer_text;
@synthesize current_ribbons;
@synthesize current_ribbon;
@synthesize thread_index;
@synthesize need_flush_data;
@synthesize root_view_controller;

- (void)viewDidUnload
{
    // flush data.
    NSLog(@"viewDidUnload() enter: flag is %d", need_flush_data);
    [self flush_data_to_base];
    
    self.uio_question_text = nil;
    self.uio_answer_text = nil;
    
    [current_ribbon release];
    current_ribbon = nil;
    
    [current_ribbons release];
    current_ribbons = nil;
    
    [root_view_controller release];
    root_view_controller = nil;
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark -
#pragma mark listen gesture.
- (void)oneFingerSwipeLeft:(UISwipeGestureRecognizer *)recognizer
{
    CGPoint point = [recognizer locationInView:[self view]];
    NSLog(@"oneFingerSwipeLeft() - start point: %f,%f", point.x, point.y);
    
    [self show_ribbon_list_view];
}

// show next thread.
-(IBAction)buttonPressed:(id)sender{
    need_flush_data = TRUE;
    
	if ([self update_text:[current_ribbon get_thread_at_index:++thread_index]] == FALSE){
        thread_index = [current_ribbon thread_count] - 1;
        
        // 显示“回头是岸”
        [self show_back_top_prompt];
        
        // 切换到 ribbon list界面
        [self show_ribbon_list_view];
    }
}


#pragma mark -
#pragma mark update data.
// 更新数据，更新对象为当前记忆 thread、 thread 总数、card 总数。
- (BOOL)flush_data_to_base{
    if (need_flush_data == TRUE) {
        if([current_ribbons update_Last_momery_thread:thread_index] != DB_EXEC_OK){
            NSLog(@"ThreadShowViewController - exit(): fail to update last momery point.");
        }
        if([current_ribbons update_Card_count:[current_ribbon card_count]] != DB_EXEC_OK){
            NSLog(@"ThreadShowViewController - exit(): fail to update card count.");
        }
        if([current_ribbons update_Thread_count:[current_ribbon thread_count]] != DB_EXEC_OK){
            NSLog(@"ThreadShowViewController - exit(): fail to update thread count.");
        }
        need_flush_data = FALSE;
    }
    
    return TRUE;
}

// 界面退出时, 刷新数据库。
- (void)applicationWillTerminate:(NSNotification *)notification{
    NSLog(@"applicationWillTerminate() enter: flag is %d", need_flush_data);
    
    [self flush_data_to_base];
}

// 用户按home键进后台时，刷新数据库
- (void)applicationWillSuspend:(NSNotification *)notification{
    NSLog(@"applicationWillSuspend() enter: flag is %d", need_flush_data);
    
    [self flush_data_to_base];
}

// TODO:功能无效
// 用户退出当前界面时，刷新数据库
- (void)viewWillDisappear:(BOOL)animated{
    NSLog(@"viewWillDisappear() enter: flag is %d", need_flush_data);
    [self flush_data_to_base];
    
    [self hideTabBar:FALSE];
}

#pragma mark -
#pragma mark process display.
// show next thread by card index.
-(BOOL)update_text:(Card *)_card
{
    if(nil == _card)return FALSE;
    
    //	NSLog(@"update_text() is %@, %@.", [_card question_string], [_card answer_string]);
	uio_question_text.text = [_card question_string];
	uio_answer_text.text = [_card answer_string];
    
    return TRUE;
}

// 显示“回头是岸”
- (void)show_back_top_prompt{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"回头是岸" message:@"恭喜你搞定了一条丝带。"  delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alert show];
    [alert release];
}


// 显示 ribbon list 界面
- (void)show_ribbon_list_view{
    // flush data to base.
    NSLog(@"show_ribbon_list_view() enter: flag is %d", need_flush_data);
    [self flush_data_to_base];
    
    if (root_view_controller != nil) {
        [root_view_controller show_view_by_type:RIBBON_LIST_FIRST_VIEW];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

// 界面显示时重新加载ribbon内容。
- (void)viewWillAppear:(BOOL)animated{
    // init ribbons.
    thread_index = 0;
    need_flush_data = TRUE;
    current_ribbons = [Ribbons sharedRibbons];
    
    // init ribbon.
    if([current_ribbons get_current_ribbon_info] != nil){
        current_ribbon = [[Ribbon alloc]init:
                          [current_ribbons get_current_ribbon_info].File_name];
        // 跳到上次访问的点
        thread_index = [current_ribbons get_current_ribbon_info].Last_momery_thread;
    }else{
        current_ribbon = [[Ribbon alloc]init];
        thread_index = 0;
    }
    
    // 处理可能的非法值，是否有必要，存疑。
    if (thread_index > current_ribbon.thread_count) {
        thread_index = current_ribbon.thread_count;
    }
    
    // init first screen.
	[self update_text:[current_ribbon get_thread_at_index:thread_index]];
    
    // 隐藏 tab bar视图.
    [self makeTabBarHidden:TRUE];
    
    [current_ribbon retain];
}

// 隐藏 tab bar视图.
- (void)makeTabBarHidden:(BOOL)hide {
    if ( [self.view.subviews count] < 2 )
        return;
    
    UIView *contentView;
    
    if ( [[self.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
        contentView = [self.view.subviews objectAtIndex:1];
    else
        contentView = [self.view.subviews objectAtIndex:0];
    
    if ( hide ){
        contentView.frame = self.view.bounds;
    }
    else{
        contentView.frame = CGRectMake(self.view.bounds.origin.x,
                                       self.view.bounds.origin.y,
                                       self.view.bounds.size.width,
                                       self.view.bounds.size.height
                                       - self.view.superview.frame.size.height);
    }
    
    self.view.superview.hidden = hide;
}

- (void) hideTabBar:(BOOL) hidden{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0];
    for(UIView *view in self.tabBarController.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            if (hidden) {
                [view setFrame:CGRectMake(view.frame.origin.x, 320, view.frame.size.width, view.frame.size.height)];
            } else {
                [view setFrame:CGRectMake(view.frame.origin.x, 320-49, view.frame.size.width, view.frame.size.height)];
            }
        }
        else
        {
            if (hidden) {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 320)];
            } else {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 320-49)];
            }
        }
    }
    [UIView commitAnimations];
}

- (void)viewDidLoad
{
    // define view display style.
    uio_question_text.layer.borderWidth = 1.0;
    uio_answer_text.layer.borderWidth = 1.0;
    
	// 注册notification:在进程退出时保存数据。
	UIApplication *app = [UIApplication sharedApplication];
	[[NSNotificationCenter defaultCenter] addObserver:self
                            selector:@selector(applicationWillTerminate:)
                                name:UIApplicationWillTerminateNotification
                              object:app];
    
    // 注册notification:进入后台状态时保存数据。
    [[NSNotificationCenter defaultCenter] addObserver:self
                            selector:@selector(applicationWillSuspend:)
                                name:UIApplicationDidEnterBackgroundNotification
                              object:app];
    [super viewDidLoad];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return TRUE;
}

@end
