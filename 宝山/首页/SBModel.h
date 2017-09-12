//
//  SBModel.h
//  宝山
//
//  Created by 尤超 on 2017/5/15.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBModel : NSObject

@property (nonatomic, copy) NSString *icon;       //图片
@property (nonatomic, copy) NSString *title;      //标题
@property (nonatomic, copy) NSString *ID;


- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)sbWithDict:(NSDictionary *)dic;

@end
