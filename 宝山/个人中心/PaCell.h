//
//  PaCell.h
//  
//
//  Created by 尤超 on 2017/5/15.
//
//

#import <UIKit/UIKit.h>

@class PaModel;

static NSString *paIndentifier = @"paCell";

@interface PaCell : UITableViewCell

@property (nonatomic, strong) PaModel *paModel;

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *startTime;
@property (nonatomic, strong) UILabel *endTime;

@end
