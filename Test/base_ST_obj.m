//
//  base_ST_code.m
//  MemoryIt
//
//  Created by duangan on 12-7-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Base_ST_obj.h"
#import "base_types.h"
#import "Ribbons.h"
#import "Singleton_object.h"

@implementation Base_ST_obj
// 我是一个单例
SYNTHESIZE_SINGLETON_FOR_CLASS(Base_ST_obj);

// 写入测试数据
+ (void)insert_data_to_ribbon{
    Ribbons *ribbons_temp = [Ribbons sharedRibbons];

    [ribbons_temp insert_ribbon_info_to_db:@"Invest time"
                          ribbon_file_name:@"invest.txt"];
    
    [ribbons_temp insert_ribbon_info_to_db:@"华为软件管理"
                          ribbon_file_name:@"huawei-code.txt"];
    
    [ribbons_temp insert_ribbon_info_to_db:@"HAL层 android系统"
                          ribbon_file_name:@"android-drv.txt"];
    
    [ribbons_temp insert_ribbon_info_to_db:@"IPhone"
                          ribbon_file_name:@"iphone.txt"];
    
    [ribbons_temp insert_ribbon_info_to_db:@"创新 专利"
                          ribbon_file_name:@"innovation.txt"];
    
    [ribbons_temp insert_ribbon_info_to_db:@"oeminfo simlock rfnv 加密算法 安全"
                        ribbon_file_name:@"security.txt"];
    
    [ribbons_temp insert_ribbon_info_to_db:@"诗词"
                        ribbon_file_name:@"poetry.txt"];
    
    [ribbons_temp insert_ribbon_info_to_db:@"内存 nand sd卡 emmc"
                        ribbon_file_name:@"storage.txt"];
    
    [ribbons_temp insert_ribbon_info_to_db:@"Android应用 framework"
                        ribbon_file_name:@"android.txt"];
    
    [ribbons_temp insert_ribbon_info_to_db:@"LCD 显示技术"
                        ribbon_file_name:@"lcd.txt"];
    
    [ribbons_temp insert_ribbon_info_to_db:@"rex系统"
                        ribbon_file_name:@"rex.txt"];
    
    [ribbons_temp insert_ribbon_info_to_db:@"问题解决思路"
                        ribbon_file_name:@"debug-experience.txt"];
    
    [ribbons_temp insert_ribbon_info_to_db:@"用户体验 用户设计"
                        ribbon_file_name:@"user-design.txt"];
    
    [ribbons_temp insert_ribbon_info_to_db:@"射频 通讯 3G"
                        ribbon_file_name:@"rf-mobile.txt"];
    
    [ribbons_temp insert_ribbon_info_to_db:@"人生"
                        ribbon_file_name:@"love.txt"];
    
    [ribbons_temp insert_ribbon_info_to_db:@"read me"
                        ribbon_file_name:@"read-me.txt"];
    
    [ribbons_temp insert_ribbon_info_to_db:@"读书笔记 随感"
                        ribbon_file_name:@"notes.txt"];
    
    [ribbons_temp insert_ribbon_info_to_db:@"商业 模式 数据 判断"
                        ribbon_file_name:@"business.txt"];
    
    [ribbons_temp insert_ribbon_info_to_db:@"代码 设计 模式 重构"
                        ribbon_file_name:@"code.txt"];
    
    [ribbons_temp insert_ribbon_info_to_db:@"管理 方法"
                        ribbon_file_name:@"how_to.txt"];
    
    [ribbons_temp insert_ribbon_info_to_db:@"debug 死机 工具使用"
                        ribbon_file_name:@"debug.txt"];
    
    [ribbons_temp insert_ribbon_info_to_db:@"camera 常识表"
                        ribbon_file_name:@"camera-basic.txt"];
    
    [ribbons_temp insert_ribbon_info_to_db:@"camera方案"
                        ribbon_file_name:@"camera.txt"];
    
    [ribbons_temp insert_ribbon_info_to_db:@"GPS" 
                        ribbon_file_name:@"gps.txt"];
    
    [ribbons_temp insert_ribbon_info_to_db:@"蓝牙" 
                        ribbon_file_name:@"bt.txt"];
    
    [ribbons_temp insert_ribbon_info_to_db:@"WIFI" 
                        ribbon_file_name:@"wifi.txt"];
    
    [ribbons_temp insert_ribbon_info_to_db:@"生产装备_升级_试制等" 
                        ribbon_file_name:@"factory1.txt"];
    
    [ribbons_temp insert_ribbon_info_to_db:@"USB方案_生产流程_安全等"
                        ribbon_file_name:@"factory2.txt"];
    
    [ribbons_temp insert_ribbon_info_to_db:@"电路、充电、功耗"
                        ribbon_file_name:@"electric.txt"];
    
    [ribbons_temp insert_ribbon_info_to_db:@"arm芯片、硬件相关"
                        ribbon_file_name:@"arm.txt"];
    
    [ribbons_temp insert_ribbon_info_to_db:@"音频"
                        ribbon_file_name:@"audio.txt"];
    
    [ribbons_temp insert_ribbon_info_to_db:@"linux相关"
                        ribbon_file_name:@"linux.txt"];
    
    [ribbons_temp insert_ribbon_info_to_db:@"NFC"
                        ribbon_file_name:@"nfc.txt"];
    
    for (uint32 ii = 1; ii < 12; ii++){
        [ribbons_temp insert_ribbon_info_to_db:[NSString stringWithFormat:@"新概念2单词表%d", ii]
                            ribbon_file_name:[NSString stringWithFormat:@"english-nc2-%d.txt", ii]];
    }
}
@end
