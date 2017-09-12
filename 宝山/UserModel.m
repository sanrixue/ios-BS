//
//  UserModel.m
//  宝山
//
//  Created by 尤超 on 17/4/20.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (instancetype)initWithDict:(NSDictionary *)dic {
    if (self = [super init]) {
        self.user_id = [dic valueForKey:@"id"];
        self.user_name = [dic valueForKey:@"user_name"];
        self.user_loginName = [dic valueForKey:@"login_name"];
        self.user_logo = [dic valueForKey:@"logo"];
        self.user_phone = [dic valueForKey:@"phone"];
        self.user_sex = [dic valueForKey:@"sex"];
        self.user_type = [dic valueForKey:@"type"];
        self.user_QRcode = [dic valueForKey:@"qr_code"];
        
        
    }
    return self;
}

+ (instancetype)userWithDict:(NSDictionary *)dic {
    return [[self alloc]initWithDict:dic];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%@",key);
}

@end
