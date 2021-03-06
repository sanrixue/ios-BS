
//
//  MyPostCell.m
//  WX
//
//  Created by 尤超 on 2017/5/2.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "MyPostCell.h"
#import "YCHead.h"
#import "MyPostModel.h"
#import "YMTapGestureRecongnizer.h"

#define kImageTag 9999

@implementation MyPostCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    _imageArray = [[NSMutableArray alloc] init];
    
    CreatControls *creatControls = [[CreatControls alloc] init];
    
    self.icon = [[UIImageView alloc] init];
    self.icon.layer.masksToBounds = YES;
    self.icon.layer.cornerRadius = 25;
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
    self.context.textColor = [UIColor blackColor];
    self.context.textAlignment = NSTextAlignmentLeft;
    self.context.numberOfLines = 0;
    
    self.time = [[UILabel alloc] init];
    [creatControls historyLab:self.time andNumber:12];
    [self.contentView addSubview:self.time];
    self.time.textColor = [UIColor grayColor];
    self.time.textAlignment = NSTextAlignmentLeft;
    
    
    
    __weak __typeof(&*self)weakSelf = self;
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(5);
        make.left.equalTo(weakSelf.mas_left).offset(30);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(10);
        make.left.equalTo(self.icon.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(300, 20));
    }];
    
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).offset(5);
        make.left.equalTo(self.icon.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(150, 20));
    }];
    
   
    
    
    
}

- (void)setMyPostModel:(MyPostModel *)myPostModel {
    _myPostModel = myPostModel;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:Main_URL,_myPostModel.icon]]];

    self.title.text = _myPostModel.title;
    self.time.text = [_myPostModel.time substringToIndex:10];
    self.context.text = [NSString stringWithFormat:@"       %@",_myPostModel.context];
    
    self.context.lineBreakMode = NSLineBreakByTruncatingTail;
    
    CGSize maximumLabelSize = CGSizeMake(KSCREENWIDTH-60, 9999);//labelsize的最大值
    
    //关键语句
    CGSize textSize = [self.context sizeThatFits:maximumLabelSize];
    
    [self.context mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.icon.mas_bottom).offset(5);
        make.left.equalTo(self.icon.mas_left).offset(0);
        make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH-60, textSize.height));
    }];
    
    
#pragma mark - /////// //图片部分
    for (int i = 0; i < [_imageArray count]; i++) {
        
        UIImageView * imageV = (UIImageView *)[_imageArray objectAtIndex:i];
        if (imageV.superview) {
            [imageV removeFromSuperview];
            
        }
        
    }
    
    [_imageArray removeAllObjects];
    
    self.array = nil;
    
    if ([[NSString stringWithFormat:@"%@",_myPostModel.images] isEqualToString:@"<null>"]) {
        self.array = nil;
    } else {
        self.array = [_myPostModel.images componentsSeparatedByString:@","]; //从字符,中分隔成N个元素的数组
    }

    for (int  i = 0; i < [self.array count]; i++) {
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(40+(80+10)*(i%3), 55 + textSize.height + 10 * ((i/3) + 1) + (i/3) * 80, 80, 80)];
        image.userInteractionEnabled = YES;
        
        YMTapGestureRecongnizer *tap = [[YMTapGestureRecongnizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [image addGestureRecognizer:tap];
        tap.appendArray = self.array;
        image.backgroundColor = [UIColor clearColor];
        image.tag = kImageTag + i;
        image.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[self.array objectAtIndex:i]]];
        
        [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:Main_URL,[NSString stringWithFormat:@"%@",[self.array objectAtIndex:i]]]]];

        [self.contentView addSubview:image];
        [_imageArray addObject:image];
        
    }
    
}

#pragma mark - 点击action
- (void)tapImageView:(YMTapGestureRecongnizer *)tapGes{
    
    [_delegate showImageViewWithImageViews:tapGes.appendArray byClickWhich:tapGes.view.tag];
    
    
}


@end
