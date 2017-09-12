//
//  SBCell.h
//  宝山
//
//  Created by 尤超 on 2017/5/15.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SBModel;

static NSString *sbIndentifier = @"sbCell";

@interface SBCell : UICollectionViewCell

@property (nonatomic, strong) SBModel *sbModel;

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *title;

@end
