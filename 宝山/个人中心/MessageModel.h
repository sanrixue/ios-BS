//
//  MessageModel.h
//  宝山
//
//  Created by 尤超 on 2017/5/2.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *context;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)messageWithDict:(NSDictionary *)dic;

@end
