//
//  HomeModel.h
//  宝山
//
//  Created by 尤超 on 17/4/18.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject

@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *name;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)homeWithDict:(NSDictionary *)dic;

@end
