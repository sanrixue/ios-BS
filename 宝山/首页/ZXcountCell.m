//
//  ZXcountCell.m
//  宝山
//
//  Created by 尤超 on 2017/5/17.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "ZXcountCell.h"
#import "ZXcountModel.h"
#import "YCHead.h"

@implementation ZXcountCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    CreatControls *creatControls = [[CreatControls alloc] init];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, KSCREENWIDTH-20, 20)];
    img.image = [UIImage imageNamed:@"S1"];
    [self.contentView addSubview:img];
    
    //添加label
    self.title = [[UILabel alloc] init];
    [creatControls historyLab:self.title andNumber:12];
    [self.contentView addSubview:self.title];
    self.title.textColor = [UIColor grayColor];
    self.title.textAlignment = NSTextAlignmentLeft;
    
    
    self.count = [[UILabel alloc] init];
    [creatControls historyLab:self.count andNumber:12];
    [self.contentView addSubview:self.count];
    self.count.textColor = [UIColor grayColor];
    self.count.textAlignment = NSTextAlignmentLeft;

    
    self.time = [[UILabel alloc] init];
    [creatControls historyLab:self.time andNumber:12];
    [self.contentView addSubview:self.time];
    self.time.textColor = [UIColor grayColor];
    self.time.textAlignment = NSTextAlignmentRight;
    
    
   
    
    __weak __typeof(&*self)weakSelf = self;
    
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(0);
        make.left.equalTo(weakSelf.mas_left).offset(30);
        make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH/3, 20));
    }];
    
    
    [self.count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(0);
        make.left.equalTo(self.title.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake((KSCREENWIDTH-40)/3, 20));
    }];
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(0);
        make.right.equalTo(weakSelf.mas_right).offset(-30);
        make.size.mas_equalTo(CGSizeMake((KSCREENWIDTH-40)/3, 20));
    }];
    
    
}

- (void)setZxcountModel:(ZXcountModel *)zxcountModel {
    _zxcountModel = zxcountModel;
    
    self.title.text = [NSString stringWithFormat:@"%@:%@",_zxcountModel.title,_zxcountModel.ename];
    self.count.text = [NSString stringWithFormat:@"人数:%@/人",_zxcountModel.count];
    self.time.text = [NSString stringWithFormat:@"总时间:%@小时",_zxcountModel.total_time];
    
   
}


@end
