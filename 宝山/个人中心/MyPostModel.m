//
//  MyPostModel.m
//  WX
//
//  Created by 尤超 on 2017/5/2.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "MyPostModel.h"

@implementation MyPostModel

- (instancetype)initWithDict:(NSDictionary *)dic {
    if (self = [super init]) {
        self.icon = [dic valueForKey:@"icon"];
        self.title = [dic valueForKey:@"title"];
        self.context = [dic valueForKey:@"context"];
        self.time = [dic valueForKey:@"time"];
        self.images = [dic valueForKey:@"images"];
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
