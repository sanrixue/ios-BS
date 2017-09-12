//
//  NSString+Password.h
//  01-用户登录
//
//  Created by lin on 15/9/8.
//  Copyright (c) 2015年 itxdl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Password)

/**
 *  32位MD5加密
 *
 *  @return 32位MD5加密结果
 */
- (NSString *)MD5;

/**
 *  SHA1加密
 *
 *  @return SHA1加密结果
 */
- (NSString *)SHA1;

@end
