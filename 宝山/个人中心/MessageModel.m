//
//  MessageModel.m
//  宝山
//
//  Created by 尤超 on 2017/5/2.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel

- (instancetype)initWithDict:(NSDictionary *)dic {
    if (self = [super init]) {
        self.ID = [dic valueForKey:@"id"];
        self.title = [dic valueForKey:@"title"];
        self.context = [dic valueForKey:@"content"];
        self.time = [dic valueForKey:@"create_time"];
        
    }
    return self;
    
}

+ (instancetype)messageWithDict:(NSDictionary *)dic {
    return [[self alloc]initWithDict:dic];
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%@",key);
}

@end
