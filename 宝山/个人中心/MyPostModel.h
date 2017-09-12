//
//  MyPostModel.h
//  宝山
//
//  Created by 尤超 on 17/5/2.
//  Copyright © 2017年 尤超. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface MyPostModel : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *context;
@property (nonatomic, copy) NSString *images;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)postWithDict:(NSDictionary *)dic;

@end
