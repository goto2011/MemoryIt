//
//  User_manager.h
//  MemoryIt
//
//  Created by duangan on 12-10-28.
//
//

#import <Foundation/Foundation.h>

@interface User_manager : NSObject{
    NSString *user_id;
    NSString *user_password;
    NSString *user_serial;
}

@property (retain, nonatomic)NSString *user_id;
@property (retain, nonatomic)NSString *user_password;
@property (retain, nonatomic)NSString *user_serial;

+ (NSString *)get_user_serial;

@end
