//
//  YCHead.h
//  掌声植物
//
//  Created by 尤超 on 16/9/14.
//  Copyright © 2016年 尤超. All rights reserved.
//

#ifndef YCHead_h
#define YCHead_h


#import "SVProgressHUD.h"
#import "UINavigationBar+Awesome.h"
#import "NewViewController.h"
#import <MJRefresh.h>
#import "AFNetwork.h"
#import <Masonry.h>
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"
#import "CreatControls.h"
#import "DBManager.h"


#define NOTIFICATION_NAME  @"selectimage"     //选取图片发送通知使用

#define kTelRegex @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$"

#define backBarButton [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil]

//系统通用宏
#define BFLocalizedString(key, comment) \
[[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:@"Gfeng"]

#define DEVICE_WIDTH [[UIScreen mainScreen] bounds].size.width
#define DEVICE_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define ScreenMiddle (DEVICE_HEIGHT-64-self.tabBarController.tabBar.frame.size.height)
#define ScreenSubViewHight (DEVICE_HEIGHT-64)
#define ScreenMiddle_iPhone5 455  //iphone5 除去navi 和 tabBar的高度
#define DeviceIsIphone5 ([UIScreen mainScreen].bounds.size.height == 568?YES:NO)
#define DeviceIsIOS7 ([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0? YES:NO)
#define SystemAppDelegate  (AppDelegate *)[UIApplication sharedApplication].delegate
#define safeSet(d,k,v) if (v) d[k] = v;

#define Back_W  11
#define Back_H  30
/**
 *  Get App name
 */
#define APP_NAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

/**
 *  Get App build
 */
#define APP_BUILD [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

/**
 *  Get App version
 */
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

/**
 *  Get AppDelegate
 */
#define APP_DELEGATE ((AppDelegate *)[[UIApplication sharedApplication] delegate])

//  主要单例
#define UserDefaults                        [NSUserDefaults standardUserDefaults]
#define NotificationCenter                  [NSNotificationCenter defaultCenter]
#define SharedApplication                   [UIApplication sharedApplication]



//设置加载图片 颜色
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define loadImage(Name)  [UIImage   imageNamed:Name]

#define LineColor COLOR(223, 223, 223, 1)  //常用灰色线条的颜色
#define CommonBlueColor COLOR(0, 155, 200, 1) //整体蓝


//屏幕高度
#define   KNagHEIGHT  self.navigationController.navigationBar.bounds.size.height-20
#define   KSCREENWIDTH  [UIScreen mainScreen].bounds.size.width
#define   KSCREENHEIGHT  [UIScreen mainScreen].bounds.size.height



//颜色设置
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFormRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

#define backBarButton [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil]






/****************************请求地址*******************************/

//根URL
#define Main_URL @"http://mcc.shlantian.cn:8080/botany/%@"

// ** 登录接口
#define Login_URL @"app_login"

// ** 验证码接口
#define Verification_URL @"hq_yzm?mobile=%@"

// ** 注册接口
#define Registered_URL @"app_reg"

// ** 忘记密码接口
#define Forget_URL @"app_zhaohui_pwd"

// ** 首页文章刷新
#define HOME_URL @"app_article_admin?page=%d&type=2"

// ** 首页搜索文章
#define Search_Url @"app_article_admin"



//// ** 帮助与反馈
////帮助接口
//#define help_URL @"app_help_feedback"

//反馈接口
#define feedback_URL @"app_feedback"


//客户协议
#define del_URL @"app_content_select?type=1"

// ** 修改个人信息接口
#define Modify_URL @"app_update_userinfo"


// ** 植物圈子的文章，所有的文章接口
#define All_circle_URL @"app_article_admin?page=%d&type=1"

// ** 我的收藏接口
#define Collection_URL @"my_shoucang"

// ** 我的发布接口
#define Releas_URL @"my_fabu"




// ** 发布圈子
#define AddArticle_URL @"app_addArticle"


// ** 文章详情页看的H5接口      传入文章的唯一ID  和自己的USER id
#define HTML_HOME_INFO @"http://mcc.shlantian.cn:8080/botany/view/webxv/articleios.html?fk_id=%@"


// ** 布水圈子详情页面的H5接口   传入文章的唯一ID  和自己的USER id
#define HTML5_INFO @"http://mcc.shlantian.cn:8080/botany/view/webxv/cricle_detailsmyios.html?fk_id=%@&fk_uid=%@"

// ** 收藏文章接口
#define Collection_the_url @"app_addData"


// ** 系统通知
#define NOTICE @"app_tz_xitong"


// ** 硬件开关控制系统
#define OPEN_URL @"view_kaiguan"

// ** 实时数据接口
#define now_data_URL @"app_queryshishi?uid=%@"

// ** 添加布水设备接口
#define AddNO_URL @"view_add"








#endif /* YCHead_h */
