//
//  CActivityCell.h
//  宝山
//
//  Created by 尤超 on 17/4/24.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CActivityModel;

static NSString *CActivityIndentifier = @"CActivityCell";

@interface CActivityCell : UITableViewCell

@property (nonatomic, strong) CActivityModel *CActivityModel;

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *context;
@property (nonatomic, strong) UILabel *time;

@end

