//
//  PhotoModle.h
//  Ecological
//
//  Created by 尤超 on 16/9/2.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoModle : NSObject

@property (nonatomic, strong) NSMutableArray *dict;

+ (PhotoModle *)shareModel;

@end
