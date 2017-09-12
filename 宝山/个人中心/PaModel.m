
//
//  PaModel.m
//  宝山
//
//  Created by 尤超 on 2017/5/15.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "PaModel.h"

@implementation PaModel

- (instancetype)initWithDict:(NSDictionary *)dic {
    if (self = [super init]) {
        self.icon = [dic valueForKey:@"logo"];
        self.title = [dic valueForKey:@"title"];
        self.endTime = [dic valueForKey:@"end_time"];
        self.startTime = [dic valueForKey:@"start_time"];
        self.ID = [dic valueForKey:@"id"];
    }
    return self;
    
}

+ (instancetype)paWithDict:(NSDictionary *)dic {
    return [[self alloc]initWithDict:dic];
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%@",key);
}

@end
