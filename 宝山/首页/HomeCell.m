

//
//  HomeCell.m
//  宝山
//
//  Created by 尤超 on 17/4/18.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "HomeCell.h"
#import "HomeModel.h"
#import "YCHead.h"

@implementation HomeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    CreatControls *creatControls = [[CreatControls alloc] init];
    
   
    self.image = [[UIImageView alloc] init];
    [self.contentView addSubview:self.image];
    
    
    UILabel *lab = [[UILabel alloc] init];
    lab.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:lab];
    
    self.name = [[UILabel alloc] init];
    [creatControls historyLab:self.name andNumber:12];
    [self.contentView addSubview:self.name];
    self.name.textColor = [UIColor blackColor];
    self.name.backgroundColor = [UIColor whiteColor];
    self.name.textAlignment = NSTextAlignmentCenter;


    
    __weak __typeof(&*self)weakSelf = self;
    
    
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(8*KSCREENWIDTH/375);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH, 180*KSCREENWIDTH/375));
    }];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(188*KSCREENWIDTH/375+14*KSCREENWIDTH/375);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(120, 1.5));
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(188*KSCREENWIDTH/375);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
}

- (void)setHomeModel:(HomeModel *)homeModel {
    _homeModel = homeModel;
    
    self.name.text = [NSString stringWithFormat:@"%@",homeModel.name];
    [self.image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:Main_URL,homeModel.image]]];
    
}


@end
