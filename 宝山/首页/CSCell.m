//
//  CSCell.m
//  宝山
//
//  Created by 尤超 on 2017/5/9.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "CSCell.h"
#import "CSModel.h"
#import "YCHead.h"

@implementation CSCell

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
    [creatControls historyLab:self.title andNumber:16];
    [self.contentView addSubview:self.title];
    self.title.textColor = [UIColor blackColor];
    self.title.textAlignment = NSTextAlignmentLeft;
    
    
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
        make.left.equalTo(self.icon.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(150, 20));
    }];
    
    [lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).offset(8);
        make.left.equalTo(self.icon.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH, 2));
    }];
}

- (void)setCsModel:(CSModel *)csModel {
    _csModel = csModel;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:Main_URL,_csModel.icon]]];
    
    self.title.text = _csModel.title;
    
    
}


@end
