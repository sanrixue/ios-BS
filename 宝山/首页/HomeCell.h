//
//  HomeCell.h
//  宝山
//
//  Created by 尤超 on 17/4/18.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeModel;

static NSString *homeIndentifier = @"homeCell";

@interface HomeCell : UITableViewCell

@property (nonatomic, strong) HomeModel *homeModel;

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UIImageView *image;


@end
