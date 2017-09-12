//
//  MainTabBar.h
//  宝山
//
//  Created by 尤超 on 17/4/12.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainTabBar;

@protocol MainTabBarDelegate <NSObject>

@optional
- (void)tabBar:(MainTabBar *)tabBar didSelectedButtonFrom:(long)fromBtnTag to:(long)toBtnTag;
- (void)tabBarClickWriteButton:(MainTabBar *)tabBar;
@end

@interface MainTabBar : UIView

- (void)addTabBarButtonWithTabBarItem:(UITabBarItem *)tabBarItem;

@property(nonatomic, weak)id <MainTabBarDelegate>delegate;

@end
