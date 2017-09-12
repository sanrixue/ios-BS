//
//  SB2Cell.h
//  宝山
//
//  Created by 尤超 on 2017/5/15.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SB2Model;

static NSString *sb2Indentifier = @"sb2Cell";

@interface SB2Cell : UICollectionViewCell

@property (nonatomic, strong) SB2Model *sb2Model;

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *title;

@end
