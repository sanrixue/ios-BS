//
//  ActivityCell.m
//  宝山城市规划馆
//
//  Created by YC on 16/11/17.
//
//
/**
 ———————————————————————————————————————————————————————————
 |--------------------------_ooOoo_------------------------|
 |------------------------o888888888o----------------------|
 |------------------------88"" . ""88----------------------|
 |------------------------(|  - -  |)----------------------|
 |------------------------0\   =   /0----------------------|
 |------------------------_/` --- '\____-------------------|
 |-------------------.'  \\|       |//  `. ----------------|
 |------------------/  \\|||   :   |||//  \ ---------------|
 |---------------- /  _|||||  -:-  |||||-  \---------------|
 |---------------- |   | \\\   -   /// |   |---------------|
 |---------------- | \_|  ``\ --- /''  |   |---------------|
 |---------------- \  .-\__   `-'   ___/-. / --------------|
 |--------------___ `. . '  /--.--\  '. . __---------------|
 |-----------.""  '<  `.___ \_<|>_/___.'  >'"". -----------|
 |----------| | :   `- \`.;` \ _ /`;.`/ - ` : | |----------|
 |----------\  \ `-.    \_  __\ /__ _/   .-` /  /----------|
 |===========`-.____`-.___ \______/___.-`____.-'===========|
 |--------------------------`=---='------------------------|
 |^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^|
 |------佛祖保佑 --------------永无BUG-----------永不修改------|
 */

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
    
 
    self.state = [[UIButton alloc] init];
    self.state.layer.borderColor = [UIColor blueColor].CGColor;
    self.state.layer.cornerRadius = 3;
    self.state.layer.borderWidth = 1;
    [self.state setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.state.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.state];
    
    
    __weak __typeof(&*self)weakSelf = self;
    
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(10);
        make.left.equalTo(weakSelf.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 80));
    }];
    
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(8);
        make.left.equalTo(self.icon.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    
    [self.context mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).offset(5);
        make.left.equalTo(self.icon.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH - 130, 40));
    }];
    
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.context.mas_bottom).offset(5);
        make.left.equalTo(self.icon.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(60, 10));
    }];
    
    
    [self.state mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.context.mas_bottom).offset(5);
        make.right.equalTo(weakSelf.mas_right).offset(-10);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];

    
}


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


- (void)setActivityModel:(ActivityModel *)activityModel {
    _activityModel = activityModel;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:Main_URL,_activityModel.icon]]];
    
    self.title.text = _activityModel.title;
    
    self.context.text = _activityModel.content;
    
    
    self.time.text = [self compareCurrentTime:_activityModel.time];
    
    if ([[NSString stringWithFormat:@"%@",_activityModel.state] isEqualToString:@"1"]) {
        [self.state setTitle:@"报名" forState:UIControlStateNormal];
    } else if ([[NSString stringWithFormat:@"%@",_activityModel.state] isEqualToString:@"2"]) {
        [self.state setTitle:@"活动调查" forState:UIControlStateNormal];
    } else if ([[NSString stringWithFormat:@"%@",_activityModel.state] isEqualToString:@"3"]) {
        [self.state setTitle:@"已过期" forState:UIControlStateNormal];
    }
    
   
    
}


@end
