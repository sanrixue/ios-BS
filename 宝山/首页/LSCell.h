//
//  LSCell.h
//  宝山
//
//  Created by 尤超 on 2017/5/12.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSModel;

static NSString *lsIndentifier = @"lsCell";

@interface LSCell : UITableViewCell

@property (nonatomic, strong) LSModel *lsModel;

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *time;

@end

