//
//  UI_mamager.h
//  MemoryIt
//
//  Created by duangan on 12-10-21.
//
//

#import <Foundation/Foundation.h>

@interface UI_manager : NSObject

+ (float)get_ribbon_list_line_hight;
+ (UIFont *)get_ribbon_list_main_font;
+ (UIImage *)get_ribbon_list_percent_icon:(float)percent_value;
+ (UIImage *)get_ribbon_list_percent_icon_selected:(float)percent_value;

+ (float)get_ribbon_detail_line_hight;
+ (UIFont *)get_ribbon_detail_caption_font;
+ (UIFont *)get_ribbon_detail_context_font;

+ (NSInteger)get_ribbon_detail_lines;

@end
