//
//  TicketModel.h
//  宝山
//
//  Created by 尤超 on 2017/5/15.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TicketModel : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *content;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)ticketWithDict:(NSDictionary *)dic;

@end
