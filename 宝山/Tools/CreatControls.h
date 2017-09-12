//
//  CreatControls.h
//  宝山城市规划馆
//
//  Created by YC on 16/11/15.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CreatControls : NSObject

//添加imageView
- (void)image:(UIImageView *)imageView Name:(NSString *)name Frame:(CGRect)frame;

//添加textField
- (void)text:(UITextField *)text Title:(NSString *)title Frame:(CGRect)frame Image:(UIImage *)image;

- (void)text:(UITextField *)text Title:(NSString *)title Frame:(CGRect)frame;

//添加button
- (void)button:(UIButton *)button Title:(NSString *)title Frame:(CGRect)frame TitleColor:(UIColor *)color Selector:(SEL)selector BackgroundColor:(UIColor *)color2 Image:(UIImage *)image;

//添加透明Button
- (void)button:(UIButton *)button Frame:(CGRect)frame Selector:(SEL)selector;


//添加Label
- (void)label:(UILabel *)label Name:(NSString *)name andFrame:(CGRect)frame;

- (void)historyLab:(UILabel *)label andNumber:(NSInteger)number;

@end
