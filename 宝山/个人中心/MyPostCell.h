//
//  MyPostCell.h
//  WX
//
//  Created by 尤超 on 2017/5/2.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol cellDelegate <NSObject>
- (void)showImageViewWithImageViews:(NSArray *)imageViews byClickWhich:(NSInteger)clickTag;
@end

@class MyPostModel;

static NSString *postIndentifier = @"postCell";

@interface MyPostCell : UITableViewCell

@property (nonatomic, strong) MyPostModel *myPostModel;

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *context;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic,strong) NSMutableArray * imageArray;
@property (nonatomic,strong) NSArray * array;
@property (nonatomic,assign) id<cellDelegate> delegate;

@end
