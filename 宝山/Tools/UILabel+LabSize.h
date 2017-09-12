//
//  UILabel+LabSize.h
//  Lab展开与收起
//
//  Created by 尤超 on 16/9/26.
//  Copyright © 2016年 尤超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LabSize)

+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;

+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;

@end
