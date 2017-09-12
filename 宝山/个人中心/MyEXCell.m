//
//  MyEXCell.m
//  宝山
//
//  Created by 尤超 on 2017/5/2.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "MyEXCell.h"
#import "YCHead.h"
#import "MyEXModel.h"

@implementation MyEXCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    CreatControls *creatControls = [[CreatControls alloc] init];
    
    
    self.icon = [[UIImageView alloc] init];
    [self.contentView addSubview:self.icon];
    
    
    UIImageView *timeIcon = [[UIImageView alloc] init];
    timeIcon.image = [UIImage imageNamed:@"timeIcon"];
    [self.contentView addSubview:timeIcon];
    
    
    

    self.title = [[UILabel alloc] init];
    [creatControls historyLab:self.title andNumber:16];
    [self.contentView addSubview:self.title];
    self.title.textColor = [UIColor blackColor];
    self.title.textAlignment = NSTextAlignmentLeft;
    
    

    self.time = [[UILabel alloc] init];
    [creatControls historyLab:self.time andNumber:14];
    [self.contentView addSubview:self.time];
    self.time.textColor = [UIColor grayColor];
    self.time.textAlignment = NSTextAlignmentLeft;
    
    
    
    __weak __typeof(&*self)weakSelf = self;
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(10);
        make.left.equalTo(weakSelf.mas_left).offset(20);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(20);
        make.left.equalTo(self.icon.mas_right).offset(20);
        make.size.mas_equalTo(CGSizeMake(250, 20));
    }];
    
    [timeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).offset(18);
        make.left.equalTo(self.icon.mas_right).offset(20);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).offset(20);
        make.left.equalTo(timeIcon.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(150, 20));
    }];
    
 

    
    
}

- (void) setMyEXModel:(MyEXModel *)myEXModel {
    _myEXModel = myEXModel;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:Main_URL,[NSString stringWithFormat:@"%@",_myEXModel.icon]]]];
    
    self.title.text = _myEXModel.title;
    
    self.time.text = [_myEXModel.time substringToIndex:10];
    
    
    
}

@end
