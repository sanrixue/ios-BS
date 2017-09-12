//
//  PaCell.m
//  
//
//  Created by 尤超 on 2017/5/15.
//
//

#import "PaCell.h"
#import "YCHead.h"
#import "PaModel.h"

@implementation PaCell

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
    
    UIImageView *icon1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeIcon"]];
    [self.contentView addSubview:icon1];
   
    UIImageView *icon2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeIcon"]];
    [self.contentView addSubview:icon2];
    
    self.startTime = [[UILabel alloc] init];
    [creatControls historyLab:self.startTime andNumber:12];
    [self.contentView addSubview:self.startTime];
    self.startTime.textColor = [UIColor grayColor];
    self.startTime.textAlignment = NSTextAlignmentLeft;
    
    self.title = [[UILabel alloc] init];
    [creatControls historyLab:self.title andNumber:18];
    [self.contentView addSubview:self.title];
    self.title.textColor = [UIColor blackColor];
    self.title.textAlignment = NSTextAlignmentLeft;
    
    self.endTime = [[UILabel alloc] init];
    [creatControls historyLab:self.endTime andNumber:12];
    [self.contentView addSubview:self.endTime];
    self.endTime.textColor = [UIColor grayColor];
    self.endTime.textAlignment = NSTextAlignmentLeft;
    
    __weak __typeof(&*self)weakSelf = self;
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(10);
        make.left.equalTo(weakSelf.mas_left).offset(20);
        make.size.mas_equalTo(CGSizeMake(150, 100));
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(10);
        make.left.equalTo(self.icon.mas_right).offset(20);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    
    [icon1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).offset(30);
        make.left.equalTo(self.icon.mas_right).offset(20);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [icon2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.startTime.mas_bottom).offset(10);
        make.left.equalTo(self.icon.mas_right).offset(20);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];

    
    [self.startTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).offset(30);
        make.left.equalTo(icon1.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    
    [self.endTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.startTime.mas_bottom).offset(10);
        make.left.equalTo(icon2.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
}

- (void)setPaModel:(PaModel *)paModel {
    _paModel = paModel;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:Main_URL,[NSString stringWithFormat:@"%@",_paModel.icon]]]];
    
    self.title.text = _paModel.title;
    
    self.startTime.text = [NSString stringWithFormat:@"报名时间:%@",[_paModel.startTime substringToIndex:10]];
    
    self.endTime.text = [NSString stringWithFormat:@"开始时间:%@",[_paModel.endTime substringToIndex:10]];
}

@end
