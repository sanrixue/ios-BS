
//
//  ZXcountModel.m
//  宝山
//
//  Created by 尤超 on 2017/5/17.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "ZXcountModel.h"

@implementation ZXcountModel

- (instancetype)initWithDict:(NSDictionary *)dic {
    if (self = [super init]) {
        self.ename = [dic valueForKey:@"ename"];
        self.title = [dic valueForKey:@"title"];
        self.count = [dic valueForKey:@"count"];
        self.total_time = [dic valueForKey:@"total_time"];
    }
    return self;
    
}

+ (instancetype)zxWithDict:(NSDictionary *)dic {
    return [[self alloc]initWithDict:dic];
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%@",key);
}

@end
