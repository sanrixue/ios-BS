//
//  ZXcountCell.h
//  宝山
//
//  Created by 尤超 on 2017/5/17.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXcountModel;

static NSString *zxcountIndentifier = @"zxcountCell";

@interface ZXcountCell : UITableViewCell

@property (nonatomic, strong) ZXcountModel *zxcountModel;

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *count;
@property (nonatomic, strong) UILabel *time;

@end
