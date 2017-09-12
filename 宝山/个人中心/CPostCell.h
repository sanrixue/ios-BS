//
//  CPostCell.h
//  宝山
//
//  Created by 尤超 on 2017/5/25.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GBTagListView.h"

@class PostModel;

static NSString *cpostIndentifier = @"cpostCell";

@interface CPostCell : UITableViewCell

@property (nonatomic, strong) PostModel *postModel;

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UILabel *like;
@property (nonatomic, strong) UILabel *context;
@property (nonatomic, strong) UILabel *comment;
@property (nonatomic, strong) UILabel *look;


@property (nonatomic, strong) NSArray *array;   //图片数组

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) NSArray *strArray;//保存标签数据的数组

@end
