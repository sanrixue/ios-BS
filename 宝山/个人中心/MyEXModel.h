//
//  MyEXModel.h
//  宝山
//
//  Created by 尤超 on 2017/5/2.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyEXModel : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *time;


- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)myEXWithDict:(NSDictionary *)dic;

@end
