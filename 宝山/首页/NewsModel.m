
//
//  NewsModel.m
//  宝山
//
//  Created by 尤超 on 2017/5/4.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

- (instancetype)initWithDict:(NSDictionary *)dic {
    if (self = [super init]) {
        self.icon = [dic valueForKey:@"logo"];
        self.title = [dic valueForKey:@"title"];
        self.content = [dic valueForKey:@"sketch"];
        self.start_time = [dic valueForKey:@"create_time"];
        self.ID = [dic valueForKey:@"id"];
      
    }
    return self;
    
}

+ (instancetype)newsWithDict:(NSDictionary *)dic {
    return [[self alloc]initWithDict:dic];
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%@",key);
}

@end
