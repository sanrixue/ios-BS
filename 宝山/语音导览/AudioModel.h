//
//  AudioModel.h
//  宝山
//
//  Created by 尤超 on 2017/5/5.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioModel : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *look;
@property (nonatomic, copy) NSString *like;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)audioWithDict:(NSDictionary *)dic;

@end
