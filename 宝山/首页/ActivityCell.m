//
//  ActivityCell.m
//  宝山
//
//  Created by 尤超 on 17/4/20.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "ActivityCell.h"
#import "ActivityModel.h"
#import "YCHead.h"

@implementation ActivityCell

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
    
 
    self.type = [[UIButton alloc] init];
    self.type.layer.borderColor = [UIColor blueColor].CGColor;
    self.type.layer.cornerRadius = 3;
    self.type.layer.borderWidth = 1;
    [self.type setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.type.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.type];
    
    
    __weak __typeof(&*self)weakSelf = self;
    
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(10);
        make.left.equalTo(weakSelf.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 80));
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
    
    
    [self.type mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.context.mas_bottom).offset(5);
        make.right.equalTo(weakSelf.mas_right).offset(-10);
        make.size.mas_equalTo(CGSizeMake(60, 20));
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
        
        result = [NSString stringWithFormat:@"%ld月前",temp];
        
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
        
        result = [NSString stringWithFormat:@"%ld月后开始",temp];
        
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

- (void)setActivityModel:(ActivityModel *)activityModel {
    _activityModel = activityModel;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:Main_URL,_activityModel.icon]]];
    
    self.title.text = _activityModel.title;
    
    self.context.text = _activityModel.content;
    
    if ([[NSString stringWithFormat:@"%@",_activityModel.state] isEqualToString:@"1"]) {
        self.time.text = [self compareCurrentTime2:_activityModel.start_time];
        
        
        if ([[NSString stringWithFormat:@"%@",_activityModel.type] isEqualToString:@"1"]) {
            self.type.hidden = YES;
            
        } else if ([[NSString stringWithFormat:@"%@",_activityModel.type] isEqualToString:@"2"]) {
            self.type.hidden = NO;
            if ([_activityModel.bm_people intValue] < [_activityModel.people intValue] ) {
                [self.type setTitle:@"报名" forState:UIControlStateNormal];
                self.type.layer.borderColor = COLOR(25, 232, 230, 1).CGColor;
                [self.type setTitleColor:COLOR(25, 232, 230, 1) forState:UIControlStateNormal];
                
            } else {
                [self.type setTitle:@"人数已满" forState:UIControlStateNormal];
                self.type.layer.borderColor = [UIColor redColor].CGColor;
                [self.type setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            }
            
        } else if ([[NSString stringWithFormat:@"%@",_activityModel.type] isEqualToString:@"3"]) {
            self.type.hidden = NO;
            [self.type setTitle:@"活动调查" forState:UIControlStateNormal];
            self.type.layer.borderColor = COLOR(35, 130, 47, 1).CGColor;
            [self.type setTitleColor:COLOR(35, 130, 47, 1) forState:UIControlStateNormal];
            
        } else if ([[NSString stringWithFormat:@"%@",_activityModel.type] isEqualToString:@"4"]) {
            self.type.hidden = NO;
            [self.type setTitle:@"评选" forState:UIControlStateNormal];
            self.type.layer.borderColor = COLOR(35, 130, 47, 1).CGColor;
            [self.type setTitleColor:COLOR(35, 130, 47, 1) forState:UIControlStateNormal];
            
        }

        
        
        

    } else if ([[NSString stringWithFormat:@"%@",_activityModel.state] isEqualToString:@"2"]){
        self.time.text = [self compareCurrentTime3:_activityModel.end_time];
        
        self.type.hidden = NO;
        [self.type setTitle:@"人数已满" forState:UIControlStateNormal];
        self.type.layer.borderColor = [UIColor redColor].CGColor;
        [self.type setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
    } else if ([[NSString stringWithFormat:@"%@",_activityModel.state] isEqualToString:@"3"]){
        self.time.text = [self compareCurrentTime:_activityModel.end_time];
        
        self.type.hidden = NO;
        [self.type setTitle:@"查看" forState:UIControlStateNormal];
        self.type.layer.borderColor = COLOR(213, 174, 85, 1).CGColor;
        [self.type setTitleColor:COLOR(213, 174, 85, 1) forState:UIControlStateNormal];
        
    }
    
    
    
   
    
}


@end
