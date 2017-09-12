//
//  CActivityModel.h
//  宝山
//
//  Created by 尤超 on 17/4/24.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CActivityModel : NSObject

@property (nonatomic, copy) NSString *icon;       //图片
@property (nonatomic, copy) NSString *title;      //标题
@property (nonatomic, copy) NSString *sketch;     //简介
@property (nonatomic, copy) NSString *start_time; //开始时间
@property (nonatomic, copy) NSString *type;       //类型

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)CActivityWithDict:(NSDictionary *)dic;

@end
