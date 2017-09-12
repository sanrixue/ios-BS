//
//  PostModel.m
//  宝山
//
//  Created by 尤超 on 2017/5/5.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "PostModel.h"

@implementation PostModel

- (instancetype)initWithDict:(NSDictionary *)dic {
    if (self = [super init]) {
        self.ID = [dic valueForKey:@"id"];
        self.icon = [dic valueForKey:@"logo"];
        self.title = [dic valueForKey:@"title"];
        self.content = [dic valueForKey:@"content"];
        self.start_time = [dic valueForKey:@"create_time"];
        self.image = [dic valueForKey:@"imgs"];
        self.name = [dic valueForKey:@"user_name"];
        self.like = [dic valueForKey:@"scNumber"];
        self.look = [dic valueForKey:@"readNumber"];
        self.comment = [dic valueForKey:@"commentNumber"];
        self.tag = [dic valueForKey:@"tag"];
        
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
