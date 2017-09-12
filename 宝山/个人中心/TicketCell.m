
//
//  TicketCell.m
//  宝山
//
//  Created by 尤超 on 2017/5/15.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "TicketCell.h"
#import "YCHead.h"
#import "TicketModel.h"

@implementation TicketCell

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
    
    self.time = [[UILabel alloc] init];
    [creatControls historyLab:self.time andNumber:14];
    [self.contentView addSubview:self.time];
    self.time.textColor = [UIColor grayColor];
    self.time.textAlignment = NSTextAlignmentLeft;
    
    self.title = [[UILabel alloc] init];
    [creatControls historyLab:self.title andNumber:14];
    [self.contentView addSubview:self.title];
    self.title.textColor = [UIColor grayColor];
    self.title.textAlignment = NSTextAlignmentLeft;
    
    self.content = [[UILabel alloc] init];
    [creatControls historyLab:self.content andNumber:14];
    [self.contentView addSubview:self.content];
    self.content.textColor = [UIColor grayColor];
    self.content.textAlignment = NSTextAlignmentLeft;
    
    __weak __typeof(&*self)weakSelf = self;
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(0);
        make.left.equalTo(weakSelf.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(90, 120));
    }];
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(10);
        make.left.equalTo(self.icon.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(250, 20));
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.time.mas_bottom).offset(5);
        make.left.equalTo(self.icon.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(250, 20));
    }];

    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).offset(5);
        make.left.equalTo(self.icon.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(250, 60));
    }];
}

- (void)setTicketModel:(TicketModel *)ticketModel {
    _ticketModel = ticketModel;

    [self.icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:Main_URL,[NSString stringWithFormat:@"%@",_ticketModel.icon]]]];
    
    self.title.text = [NSString stringWithFormat:@"票务类型:%@",_ticketModel.title];
    
    self.time.text = [NSString stringWithFormat:@"有效日期:%@",_ticketModel.time];
    
    self.content.text = _ticketModel.content;
    self.content.numberOfLines = 3;
}

@end
