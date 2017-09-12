//
//  LSModel.h
//  宝山
//
//  Created by 尤超 on 2017/5/12.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSModel : NSObject

@property (nonatomic, copy) NSString *icon;       //图片
@property (nonatomic, copy) NSString *title;      //标题
@property (nonatomic, copy) NSString *start_time; //开始时间
@property (nonatomic, copy) NSString *ID;        


- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)lsWithDict:(NSDictionary *)dic;

@end
