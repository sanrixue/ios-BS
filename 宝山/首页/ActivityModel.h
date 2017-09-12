//
//  ActivityModel.h
//  宝山
//
//  Created by 尤超 on 17/4/20.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityModel : NSObject

@property (nonatomic, copy) NSString *icon;       //图片
@property (nonatomic, copy) NSString *title;      //标题
@property (nonatomic, copy) NSString *content;    //简介
@property (nonatomic, copy) NSString *start_time; //开始时间
@property (nonatomic, copy) NSString *end_time;   //结束时间
@property (nonatomic, copy) NSString *state;      //状态
@property (nonatomic, copy) NSString *bm_people;  //报名人数
@property (nonatomic, copy) NSString *people;     //人数
@property (nonatomic, copy) NSString *type;       //类型

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)activityWithDict:(NSDictionary *)dic;

@end
