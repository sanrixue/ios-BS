//
//  AudioCell.h
//  宝山
//
//  Created by 尤超 on 2017/5/5.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AudioModel;

static NSString *audioIndentifier = @"audioCell";

@interface AudioCell : UITableViewCell

@property (nonatomic, strong) AudioModel *audioModel;

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *look;
@property (nonatomic, strong) UILabel *like;

@end
