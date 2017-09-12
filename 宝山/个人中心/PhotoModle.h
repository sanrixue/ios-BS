//
//  PhotoModle.h
//  宝山
//
//  Created by 尤超 on 17/5/2.
//  Copyright © 2017年 尤超. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface PhotoModle : NSObject

@property (nonatomic, strong) NSMutableArray *dict;

+ (PhotoModle *)shareModel;

@end
