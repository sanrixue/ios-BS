//
//  ActivityModel.m
//  宝山
//
//  Created by 尤超 on 17/4/20.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "ActivityModel.h"

@implementation ActivityModel

- (instancetype)initWithDict:(NSDictionary *)dic {
    if (self = [super init]) {
        self.icon = [dic valueForKey:@"logo"];
        self.title = [dic valueForKey:@"title"];
        self.content = [dic valueForKey:@"sketch"];
        self.start_time = [dic valueForKey:@"start_time"];
        self.end_time = [dic valueForKey:@"end_time"];
        self.state = [dic valueForKey:@"state"];
        self.type = [dic valueForKey:@"type"];
        self.bm_people = [dic valueForKey:@"bm_people"];
        self.people = [dic valueForKey:@"people"];
    }
    return self;
    
}

+ (instancetype)activityWithDict:(NSDictionary *)dic {
    return [[self alloc]initWithDict:dic];
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%@",key);
}

@end
