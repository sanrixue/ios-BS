
//
//  CExhibitionModel.m
//  宝山
//
//  Created by 尤超 on 17/4/24.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "CExhibitionModel.h"

@implementation CExhibitionModel

- (instancetype)initWithDict:(NSDictionary *)dic {
    if (self = [super init]) {
        self.icon = [dic valueForKey:@"logo"];
        self.title = [dic valueForKey:@"title"];
        self.start_time = [dic valueForKey:@"create_time"];
        self.type = [dic valueForKey:@"type"];
        
    }
    return self;
    
}

+ (instancetype)CExhibitionWithDict:(NSDictionary *)dic {
    return [[self alloc]initWithDict:dic];
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%@",key);
}

@end
