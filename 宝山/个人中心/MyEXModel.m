//
//  MyEXModel.m
//  宝山
//
//  Created by 尤超 on 2017/5/2.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "MyEXModel.h"

@implementation MyEXModel

- (instancetype)initWithDict:(NSDictionary *)dic {
    if (self = [super init]) {
        self.icon = [dic valueForKey:@"logo"];
        self.title = [dic valueForKey:@"title"];
        self.time = [dic valueForKey:@"start_time"];
        
    }
    return self;
    
}

+ (instancetype)myEXWithDict:(NSDictionary *)dic {
    return [[self alloc]initWithDict:dic];
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%@",key);
}


@end
