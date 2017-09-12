//
//  NewsModel.h
//  宝山
//
//  Created by 尤超 on 2017/5/4.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

@property (nonatomic, copy) NSString *icon;       //图片
@property (nonatomic, copy) NSString *title;      //标题
@property (nonatomic, copy) NSString *content;    //简介
@property (nonatomic, copy) NSString *start_time; //开始时间
@property (nonatomic, copy) NSString *ID;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)newsWithDict:(NSDictionary *)dic;

@end
