//
//  AudioCell.m
//  宝山
//
//  Created by 尤超 on 2017/5/5.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "AudioCell.h"
#import "YCHead.h"
#import "AudioModel.h"

@implementation AudioCell

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
    
    
    UIImageView *icon1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"look"]];
    [self.contentView addSubview:icon1];
    
    UIImageView *icon2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"like"]];
    [self.contentView addSubview:icon2];
    
    //添加label
    self.title = [[UILabel alloc] init];
    [creatControls historyLab:self.title andNumber:16];
    [self.contentView addSubview:self.title];
    self.title.textColor = [UIColor blackColor];
    self.title.textAlignment = NSTextAlignmentLeft;
    
    
    self.look = [[UILabel alloc] init];
    [creatControls historyLab:self.look andNumber:14];
    [self.contentView addSubview:self.look];
    self.look.textColor = [UIColor grayColor];
    self.look.textAlignment = NSTextAlignmentLeft;
    
    self.like = [[UILabel alloc] init];
    [creatControls historyLab:self.like andNumber:14];
    [self.contentView addSubview:self.like];
    self.like.textColor = [UIColor grayColor];
    self.like.textAlignment = NSTextAlignmentLeft;
    
    
    UILabel *lineLab = [[UILabel alloc] init];
    lineLab.backgroundColor = [UIColor grayColor];
    lineLab.alpha=0.3;
    [self.contentView addSubview:lineLab];
    
    
    __weak __typeof(&*self)weakSelf = self;
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(0);
        make.left.equalTo(weakSelf.mas_left).offset(0);
        make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH, 180));
    }];
    
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.icon.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.mas_left).offset(20);
        make.size.mas_equalTo(CGSizeMake(300, 20));
    }];
    
    
    [icon1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.mas_left).offset(20);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [self.look mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).offset(10);
        make.left.equalTo(icon1.mas_right).offset(0);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    
    [icon2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).offset(10);
        make.left.equalTo(self.look.mas_right).offset(0);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [self.like mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).offset(10);
        make.left.equalTo(icon2.mas_right).offset(0);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    
    [lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.like.mas_bottom).offset(5);
        make.left.equalTo(weakSelf.mas_left).offset(0);
        make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH, 5));
    }];
}

- (void)setAudioModel:(AudioModel *)audioModel {
    _audioModel = audioModel;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:Main_URL,_audioModel.icon]]];
    
    self.title.text = _audioModel.title;
    
    if ([[NSString stringWithFormat:@"%@",_audioModel.look] isEqualToString:@"<null>"]) {
        self.look.text = @"0";
    } else {
        self.look.text = [NSString stringWithFormat:@"%@",_audioModel.look];
    }
    
    self.like.text = [NSString stringWithFormat:@"%@",_audioModel.like];
    
}

@end
