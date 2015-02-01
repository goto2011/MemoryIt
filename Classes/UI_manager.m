//
//  UI_mamager.m
//  MemoryIt
//
//  Created by duangan on 12-10-21.
//
//

#import "UI_manager.h"
#import "Singleton_object.h"

@implementation UI_manager
//SYNTHESIZE_SINGLETON_FOR_CLASS(UI_manager);

// 返回ribbon detail view下的行高
+ (float)get_ribbon_detail_line_hight{
    // 50 表示一屏有7行
    return 50;
}

// 返回ribbon detail view下的行数
+ (NSInteger)get_ribbon_detail_lines{
    return 3;
}

// 返回ribbon detail view下的Q字体
+ (UIFont *)get_ribbon_detail_caption_font{
    return [UIFont boldSystemFontOfSize:15];
}
// 返回ribbon detail view下的A字体
+ (UIFont *)get_ribbon_detail_context_font{
    return [UIFont systemFontOfSize:13];
}

// 返回ribbon list view下的行高
+ (float)get_ribbon_list_line_hight{
    // 50 表示一屏有7行
    return 50;
}

// 返回ribbon list view下的主字体
+ (UIFont *)get_ribbon_list_main_font{
    return [UIFont boldSystemFontOfSize:18];
}

// 根据百分比，返回进度条图标。入参为0到100之间的浮点数（包括0和100）。
+ (UIImage *)get_ribbon_list_percent_icon:(float)percent_value{
    int icon_index = 0;
    
    // 数据库运行一段时间后，的确可能有各种错误，此处多处理几种例外。
    if(percent_value < 0){
        icon_index = 0;
    }else if(percent_value > 100){
        icon_index = 100;
    }else{
        icon_index = ((int)(percent_value / 10)) * 10;
    }

//    NSLog(@"get_ribbon_list_percent_icon(): percent is %f; index is %d",
//          percent_value, icon_index);

    return [UIImage imageNamed:[NSString stringWithFormat:@"percent_%d_good.png", icon_index]];
}

// 根据百分比，返回进度条图标的选中模式。入参为0到100之间的浮点数（包括0和100）。目前用同一个。
+ (UIImage *)get_ribbon_list_percent_icon_selected:(float)percent_value{
    return [self get_ribbon_list_percent_icon:percent_value];
}

@end
