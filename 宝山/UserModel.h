//
//  UserModel.h
//  宝山
//
//  Created by 尤超 on 17/4/20.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic, copy) NSString *user_id;         //用户ID
@property (nonatomic, copy) NSString *user_name;       //用户名字
@property (nonatomic, copy) NSString *user_loginName;  //用户登录名
@property (nonatomic, copy) NSString *user_logo;       //用户头像
@property (nonatomic, copy) NSString *user_phone;      //用户手机号
@property (nonatomic, copy) NSString *user_sex;        //用户性别
@property (nonatomic, copy) NSString *user_type;       //用户权限
@property (nonatomic, copy) NSString *user_QRcode;     //用户二维码

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)userWithDict:(NSDictionary *)dic;

@end
