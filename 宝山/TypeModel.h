//
//  TypeModel.h
//  宝山
//
//  Created by 尤超 on 17/4/20.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TypeModel : NSObject

@property (nonatomic, strong) NSString *type;

+ (TypeModel *)shareModel;

@end
