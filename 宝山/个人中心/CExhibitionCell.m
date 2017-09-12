//
//  CExhibitionCell.m
//  宝山
//
//  Created by 尤超 on 17/4/24.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "CExhibitionCell.h"
#import "YCHead.h"
#import "CExhibitionModel.h"

@implementation CExhibitionCell

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
    
    
    //添加label
    self.title = [[UILabel alloc] init];
    [creatControls historyLab:self.title andNumber:15];
    [self.contentView addSubview:self.title];
    self.title.textColor = [UIColor blackColor];
    self.title.textAlignment = NSTextAlignmentLeft;
    
    
    self.context = [[UILabel alloc] init];
    [creatControls historyLab:self.context andNumber:13];
    [self.contentView addSubview:self.context];
    self.context.textColor = [UIColor grayColor];
    self.context.textAlignment = NSTextAlignmentLeft;
    self.context.numberOfLines = 2;
    
    UILabel *lab = [[UILabel alloc] init];
    lab.text = @"上海宝山规划馆";
    lab.textAlignment = NSTextAlignmentLeft;
    lab.textColor = [UIColor grayColor];
    lab.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:lab];
    
    
    UIImageView *img = [[UIImageView alloc] init];
    img.image = [UIImage imageNamed:@"time"];
    [self.contentView addSubview:img];
    
    
    self.time = [[UILabel alloc] init];
    [creatControls historyLab:self.time andNumber:14];
    [self.contentView addSubview:self.time];
    self.time.textColor = [UIColor grayColor];
    self.time.textAlignment = NSTextAlignmentLeft;
    
    
    
    
    
    __weak __typeof(&*self)weakSelf = self;
    
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(10);
        make.left.equalTo(weakSelf.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 90));
    }];
    
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(15);
        make.left.equalTo(self.icon.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    
    
    [self.context mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).offset(5);
        make.left.equalTo(self.icon.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH - 130, 40));
    }];
    
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.context.mas_bottom).offset(5);
        make.left.equalTo(self.icon.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 10));
    }];
    
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.icon.mas_bottom).offset(3);
        make.left.equalTo(weakSelf.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.icon.mas_bottom).offset(5);
        make.left.equalTo(img.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(150, 10));
    }];
    
    
}

- (void)setCExhibitionModel:(CExhibitionModel *)CExhibitionModel {
    _CExhibitionModel = CExhibitionModel;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:Main_URL,_CExhibitionModel.icon]]];
    
    self.title.text = _CExhibitionModel.title;
    
   
    NSString *time = [_CExhibitionModel.start_time substringToIndex:10];
    
    self.time.text = time;
    
    
    
}


@end
