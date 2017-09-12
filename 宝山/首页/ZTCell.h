//
//  ZTCell.h
//  宝山
//
//  Created by 尤超 on 2017/5/9.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZTModel;

static NSString *ztIndentifier = @"ztCell";

@interface ZTCell : UICollectionViewCell

@property (nonatomic, strong) ZTModel *ztModel;

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *title;

@end

