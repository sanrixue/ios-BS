//
//  PersonInfoViewController.h
//  宝山
//
//  Created by 尤超 on 17/4/20.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MyBlock)(NSString *nameText,UIImage *iconImage);

@interface PersonInfoViewController : UIViewController

@property (nonatomic, copy) MyBlock myBlock;

- (void)returnBlock:(MyBlock)block;

@end
