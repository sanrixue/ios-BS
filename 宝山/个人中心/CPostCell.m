//
//  CPostCell.m
//  宝山
//
//  Created by 尤超 on 2017/5/25.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "CPostCell.h"
#import "PostModel.h"
#import "YCHead.h"


@implementation CPostCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    
    self.backView = [[UIView alloc] init];
    self.backView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.backView];
    
    CreatControls *creatControls = [[CreatControls alloc] init];
    
    //图片
    self.icon = [[UIImageView alloc] init];
    self.icon.layer.cornerRadius = 25;
    self.icon.layer.masksToBounds = YES;
    [self.contentView addSubview:self.icon];
    
    self.image = [[UIImageView alloc] init];
    [self.contentView addSubview:self.image];
    
    UIImageView *icon1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Ylike"]];
    [self.contentView addSubview:icon1];
    
    UIImageView *icon2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Ycomment"]];
    [self.backView addSubview:icon2];
    
    UIImageView *icon3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"look"]];
    [self.backView addSubview:icon3];
    
    UIImageView *icon4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Ytag"]];
    [self.backView addSubview:icon4];
    
    //添加label
    self.title = [[UILabel alloc] init];
    [creatControls historyLab:self.title andNumber:16];
    [self.contentView addSubview:self.title];
    self.title.textColor = [UIColor blackColor];
    self.title.textAlignment = NSTextAlignmentLeft;
    
    
    self.context = [[UILabel alloc] init];
    [creatControls historyLab:self.context andNumber:14];
    [self.contentView addSubview:self.context];
    self.context.textColor = [UIColor darkGrayColor];
    self.context.textAlignment = NSTextAlignmentLeft;
    self.context.numberOfLines = 0;
    
    self.name = [[UILabel alloc] init];
    [creatControls historyLab:self.name andNumber:13];
    [self.contentView addSubview:self.name];
    self.name.textColor = [UIColor grayColor];
    self.name.textAlignment = NSTextAlignmentLeft;
    
    self.time = [[UILabel alloc] init];
    [creatControls historyLab:self.time andNumber:13];
    [self.contentView addSubview:self.time];
    self.time.textColor = [UIColor grayColor];
    self.time.textAlignment = NSTextAlignmentLeft;
    
    
    self.like = [[UILabel alloc] init];
    [creatControls historyLab:self.like andNumber:14];
    [self.contentView addSubview:self.like];
    self.like.textColor = [UIColor grayColor];
    self.like.textAlignment = NSTextAlignmentLeft;
    
    self.comment = [[UILabel alloc] init];
    [creatControls historyLab:self.comment andNumber:14];
    [self.backView addSubview:self.comment];
    self.comment.textColor = [UIColor grayColor];
    self.comment.textAlignment = NSTextAlignmentLeft;
    
    
    self.look = [[UILabel alloc] init];
    [creatControls historyLab:self.look andNumber:14];
    [self.backView addSubview:self.look];
    self.look.textColor = [UIColor grayColor];
    self.look.textAlignment = NSTextAlignmentLeft;
    
    
    UILabel *lineLab = [[UILabel alloc] init];
    lineLab.backgroundColor = [UIColor grayColor];
    lineLab.alpha=0.3;
    [self.backView addSubview:lineLab];
    
    
    __weak __typeof(&*self)weakSelf = self;
    
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(10);
        make.left.equalTo(weakSelf.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).offset(8);
        make.left.equalTo(weakSelf.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).offset(10);
        make.left.equalTo(self.icon.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.name.mas_bottom).offset(5);
        make.left.equalTo(self.icon.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    
    [icon1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).offset(10);
        make.right.equalTo(weakSelf.mas_right).offset(-40);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    
    [self.like mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).offset(15);
        make.left.equalTo(icon1.mas_right).offset(0);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    
    
    [self.context mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.icon.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH-20, 50));
    }];
    
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.context.mas_bottom).offset(5);
        make.left.equalTo(weakSelf.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH-20, 180));
    }];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(333);
        make.left.equalTo(weakSelf.mas_left).offset(0);
        make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH, 80));
    }];
    
    
    [icon2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView.mas_top).offset(5);
        make.left.equalTo(weakSelf.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    
    [icon3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icon2.mas_bottom).offset(5);
        make.left.equalTo(weakSelf.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [icon4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icon3.mas_bottom).offset(5);
        make.left.equalTo(weakSelf.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    
    [self.comment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icon2.mas_top).offset(0);
        make.left.equalTo(icon2.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(150, 20));
    }];
    
    [self.look mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icon3.mas_top).offset(0);
        make.left.equalTo(icon3.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(150, 20));
    }];
    
    [lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icon4.mas_bottom).offset(5);
        make.left.equalTo(weakSelf.mas_left).offset(0);
        make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH, 5));
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

- (void)setPostModel:(PostModel *)postModel {
    _postModel = postModel;
    
    self.title.text = _postModel.title;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:Main_URL,_postModel.icon]]];
    
    
    self.name.text = _postModel.name;
    
    NSString *time = [_postModel.start_time substringToIndex:10];
    
    self.time.text = [NSString stringWithFormat:@"收藏时间:%@",time];
    
    self.context.text = [NSString stringWithFormat:@"       %@",_postModel.content];
    
    
    self.context.lineBreakMode = NSLineBreakByTruncatingTail;
    
    CGSize maximumLabelSize = CGSizeMake(KSCREENWIDTH-60, 9999);//labelsize的最大值
    
    //关键语句
    CGSize textSize = [self.context sizeThatFits:maximumLabelSize];
    
    [self.context mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.icon.mas_bottom).offset(10);
        make.left.equalTo(self.icon.mas_left).offset(0);
        make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH-20, textSize.height));
    }];
    

    
    self.like.text = [NSString stringWithFormat:@"%@",_postModel.like];
    
    self.comment.text = [NSString stringWithFormat:@"%@人评论",_postModel.comment];
    
    self.look.text = [NSString stringWithFormat:@"%@人浏览",_postModel.look];
    
    
    
    
    
    
    self.array = nil;
    
    self.image.image = nil;
    
    if ([[NSString stringWithFormat:@"%@",_postModel.image] isEqualToString:@"<null>"]) {
        self.array = nil;
        
        __weak __typeof(&*self)weakSelf = self;
        
        [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.mas_top).offset(333-180-50+textSize.height);
            make.left.equalTo(weakSelf.mas_left).offset(0);
            make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH, 80));
        }];
        
    } else {
        
        self.array = [_postModel.image componentsSeparatedByString:@","]; //从字符,中分隔成N个元素的数组
        
        [self.image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:Main_URL,self.array[0]]]];
        
        
        __weak __typeof(&*self)weakSelf = self;
        
        [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.mas_top).offset(333-50+textSize.height);
            make.left.equalTo(weakSelf.mas_left).offset(0);
            make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH, 80));
        }];
    }
    
    self.strArray = nil;
    
    if ([[NSString stringWithFormat:@"%@",_postModel.tag] isEqualToString:@"<null>"]) {
        self.strArray= @[@"热门"];
    } else {
        
        self.strArray= [_postModel.tag componentsSeparatedByString:@","];
    }
    
    GBTagListView *tagList=[[GBTagListView alloc]initWithFrame:CGRectMake(30, 50,KSCREENWIDTH-30, 20)];
    
    //注意如果要自定义tag的颜色和整体的背景色定义方法一定要写在setTagWithTagArray方法之前
    tagList.canTouch=NO;
    tagList.signalTagColor=COLOR(165, 214, 176, 1);
    [tagList setTagWithTagArray:(NSMutableArray*)self.strArray];
    
    [self.backView addSubview:tagList];
    
}

@end
