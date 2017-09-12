//
//  NewsCell.h
//  宝山
//
//  Created by 尤超 on 2017/5/4.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsModel;

static NSString *newsIndentifier = @"newsCell";

@interface NewsCell : UITableViewCell

@property (nonatomic, strong) NewsModel *newsModel;

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *context;
@property (nonatomic, strong) UILabel *time;
@end
