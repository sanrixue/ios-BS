
//
//  SB2Model.m
//  宝山
//
//  Created by 尤超 on 2017/5/15.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "SB2Model.h"

@implementation SB2Model
- (instancetype)initWithDict:(NSDictionary *)dic {
    if (self = [super init]) {
        self.icon = [dic valueForKey:@"logo"];
        self.title = [dic valueForKey:@"ename"];
        self.ID = [dic valueForKey:@"id"];
        
    }
    return self;
    
}

+ (instancetype)sb2WithDict:(NSDictionary *)dic {
    return [[self alloc]initWithDict:dic];
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%@",key);
}

@end
