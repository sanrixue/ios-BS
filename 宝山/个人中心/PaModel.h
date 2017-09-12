//
//  PaModel.h
//  宝山
//
//  Created by 尤超 on 2017/5/15.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaModel : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *ID;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)paWithDict:(NSDictionary *)dic;

@end
