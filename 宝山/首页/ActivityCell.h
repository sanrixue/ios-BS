//
//  ActivityCell.h
//  宝山
//
//  Created by 尤超 on 17/4/20.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ActivityModel;

static NSString *activityIndentifier = @"activityCell";

@interface ActivityCell : UITableViewCell

@property (nonatomic, strong) ActivityModel *activityModel;

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *context;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UIButton *type;

@end
