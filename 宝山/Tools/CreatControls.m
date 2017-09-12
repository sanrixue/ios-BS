//
//  CreatControls.h
//  宝山城市规划馆
//
//  Created by YC on 16/11/15.
//
//

#import "CreatControls.h"

@implementation CreatControls

- (void)image:(UIImageView *)imageView Name:(NSString *)name Frame:(CGRect)frame {
    imageView.frame = frame;
    imageView.image = [UIImage imageNamed:name];
}

- (void)text:(UITextField *)text Title:(NSString *)title Frame:(CGRect)frame {
    text.frame = frame;
    text.backgroundColor = [UIColor whiteColor];
    text.font = [UIFont fontWithName:@"Arial" size:15.0f];
    text.placeholder = title;
    text.textColor = [UIColor whiteColor];
    text.textAlignment = NSTextAlignmentLeft;
    text.borderStyle = UITextBorderStyleRoundedRect;
    UIView *View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 30)];
    UIImageView *passView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 20, 20)];
    [View addSubview:passView];
    text.leftView = View;
    [text setLeftViewMode:UITextFieldViewModeAlways];
    text.borderStyle = UITextBorderStyleNone;
    text.layer.cornerRadius = 10;
    text.layer.masksToBounds = YES;
    text.layer.borderColor = [[UIColor clearColor] CGColor];
    text.layer.borderWidth = 1.0;

}


- (void)text:(UITextField *)text Title:(NSString *)title Frame:(CGRect)frame Image:(UIImage *)image {
    text.frame = frame;
    text.backgroundColor = [UIColor whiteColor];
    text.font = [UIFont fontWithName:@"Arial" size:15.0f];
    text.placeholder = title;
    text.textColor = [UIColor whiteColor];
    text.textAlignment = NSTextAlignmentLeft;
    text.borderStyle = UITextBorderStyleRoundedRect;
    UIView *View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 35)];
    UIImageView *passView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 3, 25, 25)];
    [passView setImage:image];
    [View addSubview:passView];
    text.leftView = View;
    [text setLeftViewMode:UITextFieldViewModeAlways];
    text.borderStyle = UITextBorderStyleNone;
    text.layer.cornerRadius = 10;
    text.layer.masksToBounds = YES;
    text.layer.borderColor = [[UIColor clearColor] CGColor];
    text.layer.borderWidth = 1.0;
    
}



- (void)button:(UIButton *)button Title:(NSString *)title Frame:(CGRect)frame TitleColor:(UIColor *)color Selector:(SEL)selector BackgroundColor:(UIColor *)color2 Image:(UIImage *)image {
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    button.backgroundColor = [color2 colorWithAlphaComponent:0.6];
    button.layer.borderWidth = 1;
    button.layer.cornerRadius = 1;
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
}


- (void)button:(UIButton *)button Title:(NSString *)title Frame:(CGRect)frame TitleColor:(UIColor *)color Selector:(SEL)selector BackgroundColor:(UIColor *)color2 Image:(NSString *)image SelectImage:(NSString *)Simage  BorderColor:(UIColor *) color3{
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:10];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:Simage] forState:UIControlStateSelected];
    button.backgroundColor = [color2 colorWithAlphaComponent:0.6];
    button.layer.masksToBounds =YES;
    button.layer.cornerRadius = 5;
    button.layer.borderWidth = 1;
    button.layer.borderColor = color3.CGColor;
}

- (void)button:(UIButton *)button Frame:(CGRect)frame Selector:(SEL)selector {
    button.frame = frame;
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
}

- (void)label:(UILabel *)label Name:(NSString *)name andFrame:(CGRect)frame {
    label.frame = frame;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:18];
    [label setText:[NSString stringWithFormat:@"%@",name]];
}


- (void)historyLab:(UILabel *)label andNumber:(NSInteger)number {
    label.font = [UIFont systemFontOfSize:number];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];


}

- (void)label:(UILabel *)label Font:(UIFont *)font Name:(NSString *)name andFrame:(CGRect)frame {
    label.frame = frame;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = font;
    [label setText:[NSString stringWithFormat:@"%@",name]];


}

@end
