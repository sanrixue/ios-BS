//
//  ZXcountModel.h
//  宝山
//
//  Created by 尤超 on 2017/5/17.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXcountModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *ename;
@property (nonatomic, copy) NSString *count;
@property (nonatomic, copy) NSString *total_time;


- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)zxWithDict:(NSDictionary *)dic;

@end
