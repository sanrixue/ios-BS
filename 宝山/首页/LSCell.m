//
//  LSCell.m
//  宝山
//
//  Created by 尤超 on 2017/5/12.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "LSCell.h"
#import "LSModel.h"
#import "YCHead.h"

@implementation LSCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    CreatControls *creatControls = [[CreatControls alloc] init];
    
    //图片
    self.icon = [[UIImageView alloc] init];
    [self.contentView addSubview:self.icon];
    
    
    UIImageView *timeIcon = [[UIImageView alloc] init];
    timeIcon.image = [UIImage imageNamed:@"timeLS"];
    [self.contentView addSubview:timeIcon];
    
    //添加label
    self.title = [[UILabel alloc] init];
    [creatControls historyLab:self.title andNumber:15];
    [self.contentView addSubview:self.title];
    self.title.textColor = [UIColor blackColor];
    self.title.textAlignment = NSTextAlignmentLeft;
    
    
    
    self.time = [[UILabel alloc] init];
    [creatControls historyLab:self.time andNumber:12];
    [self.contentView addSubview:self.time];
    self.time.textColor = [UIColor grayColor];
    self.time.textAlignment = NSTextAlignmentLeft;
    
    
    
    UILabel *lineLab = [[UILabel alloc] init];
    lineLab.backgroundColor = COLOR(242, 243, 244, 1);
    [self.contentView addSubview:lineLab];

    
    
    __weak __typeof(&*self)weakSelf = self;
    
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(0);
        make.left.equalTo(weakSelf.mas_left).offset(0);
        make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH, 180));
    }];
    
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.icon.mas_bottom).offset(8);
        make.left.equalTo(self.icon.mas_left).offset(20);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.icon.mas_bottom).offset(8);
        make.right.equalTo(self.icon.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    [timeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.icon.mas_bottom).offset(8);
        make.right.equalTo(self.time.mas_left).offset(0);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).offset(5);
        make.left.equalTo(self.icon.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH, 2));
    }];

    
}

- (void)setLsModel:(LSModel *)lsModel {
    _lsModel = lsModel;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:Main_URL,_lsModel.icon]]];
    
    self.title.text = _lsModel.title;
    self.time.text = [_lsModel.start_time substringToIndex:10];
}

@end
