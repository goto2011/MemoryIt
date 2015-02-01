//
//  ThreadShowViewController.h
//  MemoryIt
//
//  Created by duangan on 12-6-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "base_types.h"
#import "Ribbons.h"
#import "Ribbon.h"
#import "MemoryItViewController.h"

@interface ThreadShowViewController : UIViewController{
	UITextView          *uio_question_text;
	UITextView          *uio_answer_text;
    MemoryItViewController *root_view_controller;
    @private Ribbons     *current_ribbons;
    @private Ribbon      *current_ribbon;
    @private uint32      thread_index;
    @private Boolean     need_flush_data;
}

@property (retain, nonatomic)IBOutlet UITextView *uio_question_text;
@property (retain, nonatomic)IBOutlet UITextView *uio_answer_text;
@property (retain, nonatomic)Ribbons     *current_ribbons;
@property (retain, nonatomic)Ribbon      *current_ribbon;
@property (retain, nonatomic)MemoryItViewController *root_view_controller;
@property uint32    thread_index;
@property Boolean   need_flush_data;

-(IBAction)buttonPressed:(id)sender;
-(IBAction)oneFingerSwipeLeft:(UISwipeGestureRecognizer *)recognizer;

@end
