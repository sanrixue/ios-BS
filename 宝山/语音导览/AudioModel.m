//
//  AudioModel.m
//  宝山
//
//  Created by 尤超 on 2017/5/5.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "AudioModel.h"

@implementation AudioModel

- (instancetype)initWithDict:(NSDictionary *)dic {
    if (self = [super init]) {
        self.ID = [dic valueForKey:@"id"];
        self.title = [dic valueForKey:@"title"];
        self.icon = [dic valueForKey:@"logo"];
        self.look = [dic valueForKey:@"browse"];
        self.like = [dic valueForKey:@"scnumber"];
    }
    return self;
    
}

+ (instancetype)audioWithDict:(NSDictionary *)dic {
    return [[self alloc]initWithDict:dic];
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%@",key);
}

@end
