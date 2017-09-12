//
//  SB2Cell.m
//  宝山
//
//  Created by 尤超 on 2017/5/15.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "SB2Cell.h"
#import "SB2Model.h"
#import "YCHead.h"

@implementation SB2Cell

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderWidth = 2;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 0.0;
        
        [self setUpUI];
    }
    return self;
}


- (void)setUpUI {
    CreatControls *creatControls = [[CreatControls alloc] init];
    
    //图片
    self.icon = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:self.icon];
    
    UIView *back = [[UIView alloc] init];
    back.backgroundColor = COLOR(0, 0, 0, 0.8);
    [self.contentView addSubview:back];
    
    
    //添加label
    self.title = [[UILabel alloc] init];
    [creatControls historyLab:self.title andNumber:18];
    [self.contentView addSubview:self.title];
    self.title.textColor = [UIColor whiteColor];
    self.title.textAlignment = NSTextAlignmentCenter;
    self.title.backgroundColor = [UIColor clearColor];
    
    
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.icon.mas_bottom).offset(0);
        make.left.equalTo(self.icon.mas_left).offset(0);
        make.size.mas_equalTo(CGSizeMake(self.icon.bounds.size.width, 40));
    }];
    
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.icon.mas_bottom).offset(0);
        make.left.equalTo(self.icon.mas_left).offset(0);
        make.size.mas_equalTo(CGSizeMake(self.icon.bounds.size.width, 40));
    }];
    
    
}

- (void)setSb2Model:(SB2Model *)sb2Model {
    _sb2Model = sb2Model;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:Main_URL,_sb2Model.icon]]];
    
    self.title.text = _sb2Model.title;
    
    
}

@end
