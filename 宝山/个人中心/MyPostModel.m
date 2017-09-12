//
//  MyPostModel.m
//  宝山
//
//  Created by 尤超 on 17/5/2.
//  Copyright © 2017年 尤超. All rights reserved.
//


#import "MyPostModel.h"

@implementation MyPostModel

- (instancetype)initWithDict:(NSDictionary *)dic {
    if (self = [super init]) {
        self.icon = [dic valueForKey:@"logo"];
        self.title = [dic valueForKey:@"title"];
        self.context = [dic valueForKey:@"content"];
        self.time = [dic valueForKey:@"create_time"];
        self.images = [dic valueForKey:@"imgs"];
    }
    return self;
    
}

+ (instancetype)postWithDict:(NSDictionary *)dic {
    return [[self alloc]initWithDict:dic];
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%@",key);
}


@end
