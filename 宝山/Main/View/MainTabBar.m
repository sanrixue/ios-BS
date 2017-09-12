//
//  MainTabBar.m
//  宝山
//
//  Created by 尤超 on 17/4/12.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "MainTabBar.h"
#import "MainTabBarButton.h"
#import "YCHead.h"
#import "TypeModel.h"

@interface MainTabBar ()
@property(nonatomic, strong)NSMutableArray *tabbarBtnArray;
@property(nonatomic, weak)UIButton *writeButton;
@property(nonatomic, weak)MainTabBarButton *selectedButton;
@end

@implementation MainTabBar
- (NSMutableArray *)tabbarBtnArray{
    if (!_tabbarBtnArray) {
        _tabbarBtnArray = [NSMutableArray array];
    }
    return  _tabbarBtnArray;
}

//设置tabbar颜色
- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self SetupWriteButton];
    }
    
    return self;
}

- (void)SetupWriteButton{
    UIButton *writeButton = [UIButton new];
    writeButton.adjustsImageWhenHighlighted = NO;
    [writeButton setBackgroundImage:[UIImage imageNamed:@"一键"] forState:UIControlStateNormal];
    [writeButton addTarget:self action:@selector(ClickWriteButton) forControlEvents:UIControlEventTouchUpInside];
  //writeButton.bounds = CGRectMake(0, 0, writeButton.currentBackgroundImage.size.width, writeButton.currentBackgroundImage.size.height);
    writeButton.bounds = CGRectMake(0, 0, 50, 50);
    [self addSubview:writeButton];
    _writeButton = writeButton;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.writeButton.center = CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5-12);
    
    CGFloat btnY = 0;
    CGFloat btnW = self.frame.size.width/(self.subviews.count);
    CGFloat btnH = self.frame.size.height;
    
    for (int nIndex = 0; nIndex < self.tabbarBtnArray.count; nIndex++) {
        CGFloat btnX = btnW * nIndex;
        MainTabBarButton *tabBarBtn = self.tabbarBtnArray[nIndex];
        if (nIndex > 1) {
            btnX += btnW;
        }
        tabBarBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        tabBarBtn.tag = nIndex;
    }
}

- (void)addTabBarButtonWithTabBarItem:(UITabBarItem *)tabBarItem{
    MainTabBarButton *tabBarBtn = [[MainTabBarButton alloc] init];
    tabBarBtn.tabBarItem = tabBarItem;
    [tabBarBtn addTarget:self action:@selector(ClickTabBarButton:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:tabBarBtn];
    [self.tabbarBtnArray addObject:tabBarBtn];
    
    
    //default selected first one
    
    TypeModel *model = [TypeModel shareModel];
    
    if ([model.type isEqualToString:@"4"]) {
        if (self.tabbarBtnArray.count == 4) {
            [self ClickTabBarButton:tabBarBtn];
        }
    } else {
    
        if (self.tabbarBtnArray.count == 1) {
            [self ClickTabBarButton:tabBarBtn];
        }
    }
}

- (void)ClickTabBarButton:(MainTabBarButton *)tabBarBtn{
    
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:self.selectedButton.tag to:tabBarBtn.tag];
    }
    
    self.selectedButton.selected = NO;
    tabBarBtn.selected = YES;
    self.selectedButton = tabBarBtn;
}

- (void)ClickWriteButton{
    if ([self.delegate respondsToSelector:@selector(tabBarClickWriteButton:)]) {
        [self.delegate tabBarClickWriteButton:self];
    }
}
@end
