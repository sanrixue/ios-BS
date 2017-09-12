//
//  MainTabBarController.m
//  宝山
//
//  Created by 尤超 on 17/4/12.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "MainTabBarController.h"
#import "MainNavigationController.h"
#import "MainTabBar.h"
#import "HomeController.h"
#import "TicketController.h"
#import "AudioGuideController.h"
#import "PersonalController.h"

#import "YCHead.h"
#import "InMapController.h"


@interface MainTabBarController ()<MainTabBarDelegate>

@property(nonatomic, weak)MainTabBar *mainTabBar;
@property(nonatomic, strong)HomeController *homeVc;
@property(nonatomic, strong)TicketController *tickerVc;
@property(nonatomic, strong)AudioGuideController *audioGuideVc;
@property(nonatomic, strong)PersonalController *personalVc;

@end

@implementation MainTabBarController
- (void)viewDidLoad{
    [super viewDidLoad];
    
  
    
    [self SetupMainTabBar];
    [self SetupAllControllers];
   
#warning eeeee
//    self.selectedIndex = 1;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

- (void)SetupMainTabBar{
    MainTabBar *mainTabBar = [[MainTabBar alloc] init];
    mainTabBar.frame = self.tabBar.bounds;
    mainTabBar.delegate = self;
    [self.tabBar addSubview:mainTabBar];
    _mainTabBar = mainTabBar;
}

- (void)SetupAllControllers{
    NSArray *titles = @[@"首页", @"票务预约", @"语音导览", @"个人中心"];
    NSArray *images = @[@"home1", @"home2", @"home3", @"home4"];
    NSArray *selectedImages = @[@"home1S", @"home2S", @"home3S", @"home4S"];
    
    HomeController * homeVc = [[HomeController alloc] init];
    self.homeVc = homeVc;
    
    TicketController * tickerVc = [[TicketController alloc] init];
    self.tickerVc = tickerVc;
    
    AudioGuideController * audioGuideVc = [[AudioGuideController alloc] init];
    self.audioGuideVc = audioGuideVc;
    
    PersonalController * personalVc = [[PersonalController alloc] init];
    self.personalVc = personalVc;
    
    NSArray *viewControllers = @[homeVc, tickerVc, audioGuideVc, personalVc];
    
    for (int i = 0; i < viewControllers.count; i++) {
        UIViewController *childVc = viewControllers[i];
        [self SetupChildVc:childVc title:titles[i] image:images[i] selectedImage:selectedImages[i]];
    }
}

- (void)SetupChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)imageName selectedImage:(NSString *)selectedImageName{
    MainNavigationController *nav = [[MainNavigationController alloc] initWithRootViewController:childVc];
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    childVc.tabBarItem.title = title;
    [self.mainTabBar addTabBarButtonWithTabBarItem:childVc.tabBarItem];
    [self addChildViewController:nav];
}



#pragma mark --------------------mainTabBar delegate
- (void)tabBar:(MainTabBar *)tabBar didSelectedButtonFrom:(long)fromBtnTag to:(long)toBtnTag{
    self.selectedIndex = toBtnTag;
}

#warning 中间
- (void)tabBarClickWriteButton:(MainTabBar *)tabBar{
   
    InMapController *VC = [[InMapController alloc] init];
    
    MainNavigationController *nav = [[MainNavigationController alloc] initWithRootViewController:VC];
    
    [self presentViewController:nav animated:YES completion:nil];
    
}

@end
