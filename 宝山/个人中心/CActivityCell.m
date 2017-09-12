//
//  CActivityCell.m
//  宝山
//
//  Created by 尤超 on 17/4/24.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "CActivityCell.h"
#import "CActivityModel.h"
#import "YCHead.h"

@implementation CActivityCell

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
    
    self.time = [[UILabel alloc] init];
    [creatControls historyLab:self.time andNumber:12];
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
        make.top.equalTo(weakSelf.mas_top).offset(8);
        make.left.equalTo(self.icon.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    
    
    [self.context mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).offset(5);
        make.left.equalTo(self.icon.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH - 130, 40));
    }];
    
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.context.mas_bottom).offset(5);
        make.left.equalTo(self.icon.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 10));
    }];
    
    
        
    
}


//过期
- (NSString *) compareCurrentTime:(NSString *)str {
    
    //把字符串转为NSdate
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *timeDate = [dateFormatter dateFromString:str];
    
    NSDate *currentDate = [NSDate date];
    
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:timeDate];
    
    long temp = 0;
    
    NSString *result;
    
    if (timeInterval/60 < 1) {
        
        result = [NSString stringWithFormat:@"刚刚"];
        
    }
    
    else if((temp = timeInterval/60) <60){
        
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
        
    }
    
    else if((temp = temp/60) <24){
        
        result = [NSString stringWithFormat:@"%ld小时前",temp];
        
    }
    
    else if((temp = temp/24) <30){
        
        result = [NSString stringWithFormat:@"%ld天前",temp];
        
    }
    
    else if((temp = temp/30) <12){
        
        result = [NSString stringWithFormat:@"%ld个月前",temp];
        
    }
    
    else{
        
        temp = temp/12;
        
        result = [NSString stringWithFormat:@"%ld年前",temp];
        
    }
    
    return result;
    
}

//未来
- (NSString *) compareCurrentTime2:(NSString *)str {
    
    //把字符串转为NSdate
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *timeDate = [dateFormatter dateFromString:str];
    
    NSDate *currentDate = [NSDate date];
    
    NSTimeInterval timeInterval = [timeDate timeIntervalSinceDate:currentDate];
    
    long temp = 0;
    
    NSString *result;
    
    if (timeInterval/60 < 1) {
        
        result = [NSString stringWithFormat:@"刚刚"];
        
    }
    
    else if((temp = timeInterval/60) <60){
        
        result = [NSString stringWithFormat:@"%ld分钟后开始",temp];
        
    }
    
    else if((temp = temp/60) <24){
        
        result = [NSString stringWithFormat:@"%ld小时后开始",temp];
        
    }
    
    else if((temp = temp/24) <30){
        
        result = [NSString stringWithFormat:@"%ld天后开始",temp];
        
    }
    
    else if((temp = temp/30) <12){
        
        result = [NSString stringWithFormat:@"%ld个月后开始",temp];
        
    }
    
    else{
        
        temp = temp/12;
        
        result = [NSString stringWithFormat:@"%ld年后开始",temp];
        
    }
    
    return result;
    
}

//活动中
- (NSString *) compareCurrentTime3:(NSString *)str {
    
    //把字符串转为NSdate
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *timeDate = [dateFormatter dateFromString:str];
    
    NSDate *currentDate = [NSDate date];
    
    NSTimeInterval timeInterval = [timeDate timeIntervalSinceDate:currentDate];
    
    long temp = 0;
    
    NSString *result;
    
    if (timeInterval/60 < 1) {
        
        result = [NSString stringWithFormat:@"刚刚"];
        
    }
    
    else if((temp = timeInterval/60) <60){
        
        result = [NSString stringWithFormat:@"%ld分钟后结束",temp];
        
    }
    
    else if((temp = temp/60) <24){
        
        result = [NSString stringWithFormat:@"%ld小时后结束",temp];
        
    }
    
    else if((temp = temp/24) <30){
        
        result = [NSString stringWithFormat:@"%ld天后结束",temp];
        
    }
    
    else if((temp = temp/30) <12){
        
        result = [NSString stringWithFormat:@"%ld月后结束",temp];
        
    }
    
    else{
        
        temp = temp/12;
        
        result = [NSString stringWithFormat:@"%ld年后结束",temp];
        
    }
    
    return result;
    
}

- (void)setCActivityModel:(CActivityModel *)CActivityModel {
    _CActivityModel = CActivityModel;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:Main_URL,_CActivityModel.icon]]];
    
    self.title.text = _CActivityModel.title;
    
    self.context.text = _CActivityModel.sketch;
    
   
    self.time.text = [self compareCurrentTime:_CActivityModel.start_time];
        
    
    
}


@end
