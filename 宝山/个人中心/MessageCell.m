//
//  MessageCell.m
//  宝山
//
//  Created by 尤超 on 2017/5/2.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "MessageCell.h"
#import "YCHead.h"  
#import "MessageModel.h"

@implementation MessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    CreatControls *creatControls = [[CreatControls alloc] init];
    
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
    
    self.time = [[UILabel alloc] init];
    [creatControls historyLab:self.time andNumber:12];
    [self.contentView addSubview:self.time];
    self.time.textColor = [UIColor grayColor];
    self.time.textAlignment = NSTextAlignmentLeft;
    
    
    
    __weak __typeof(&*self)weakSelf = self;
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(8);
        make.left.equalTo(weakSelf.mas_left).offset(20);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    
    
    [self.context mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).offset(5);
        make.left.equalTo(weakSelf.mas_left).offset(20);
        make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH - 40, 60));
    }];
    
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(10);
        make.right.equalTo(weakSelf.mas_right).offset(-20);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    
}

- (void)setMessageModel:(MessageModel *)MessageModel {
    _MessageModel = MessageModel;
    
    self.title.text = _MessageModel.title;
    self.context.text = _MessageModel.context;
    NSString *time = [_MessageModel.time substringToIndex:10];
    self.time.text = time;
    
}

@end
