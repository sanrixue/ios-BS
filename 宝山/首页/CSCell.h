//
//  CSCell.h
//  宝山
//
//  Created by 尤超 on 2017/5/9.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CSModel;

static NSString *csIndentifier = @"csCell";

@interface CSCell : UITableViewCell

@property (nonatomic, strong) CSModel *csModel;

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *title;

@end

