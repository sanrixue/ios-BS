//
//  TicketCell.h
//  宝山
//
//  Created by 尤超 on 2017/5/15.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TicketModel;

static NSString *ticketIndentifier = @"ticketCell";

@interface TicketCell : UITableViewCell

@property (nonatomic, strong) TicketModel *ticketModel;

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UILabel *content;

@end
