
//
//  HomeModel.m
//  宝山
//
//  Created by 尤超 on 17/4/18.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

- (instancetype)initWithDict:(NSDictionary *)dic {
    if (self = [super init]) {
        self.name = [dic valueForKey:@"title"];
        self.image = [dic valueForKey:@"banner"];

    }
    return self;
}

+ (instancetype)homeWithDict:(NSDictionary *)dict {
    return [[self alloc]initWithDict:dict];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%@",key);
}

@end
