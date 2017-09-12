//
//  MessageCell.h
//  宝山
//
//  Created by 尤超 on 2017/5/2.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MessageModel;

static NSString *messageIndentifier = @"messageCell";

@interface MessageCell : UITableViewCell

@property (nonatomic, strong) MessageModel *MessageModel;

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *context;
@property (nonatomic, strong) UILabel *time;

@end
