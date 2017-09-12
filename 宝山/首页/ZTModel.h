//
//  ZTModel.h
//  宝山
//
//  Created by 尤超 on 2017/5/9.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTModel : NSObject

@property (nonatomic, copy) NSString *icon;       //图片
@property (nonatomic, copy) NSString *title;      //标题
@property (nonatomic, copy) NSString *ID;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)ztWithDict:(NSDictionary *)dic;

@end
