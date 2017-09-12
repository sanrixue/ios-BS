//
//  MyEXCell.h
//  宝山
//
//  Created by 尤超 on 2017/5/2.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyEXModel;

static NSString *myEXIndentifier = @"myEXCell";

@interface MyEXCell : UITableViewCell

@property (nonatomic, strong) MyEXModel *myEXModel;

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *time;


@end
