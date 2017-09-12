//
//  YCHead.h
//  宝山
//
//  Created by 尤超 on 17/4/12.
//  Copyright © 2017年 尤超. All rights reserved.
//

#ifndef YCHead_h
#define YCHead_h


#import "SVProgressHUD.h"
#import "UINavigationBar+Awesome.h"
#import <MJRefresh.h>
#import <Masonry.h>
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"
#import "CreatControls.h"
#import <AFNetworking.h>
#import "DBManager.h"
#import "AFNetwork.h"
#import <MBProgressHUD.h>

// 自定义
#import "MJChiBaoZiHeader.h"
#import "MJChiBaoZiFooter.h"
#import "MJChiBaoZiFooter2.h"
#import "MJDIYHeader.h"
#import "MJDIYAutoFooter.h"
#import "MJDIYBackFooter.h"
#import "UIButton+ImageTitleSpacing.h"
#import "DAYCalendarView.h"


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
#define Main_URL @"http://123.206.206.45:8082/baoShan/%@"

// ** 登录接口
#define Login_URL @"app/Login"

// ** 验证码接口
#define Verification_URL @"app/obtainyzm?mobile=%@"

// ** 注册接口
#define Registered_URL @"app/registered"

// ** 忘记密码接口
#define Forget_URL @"app/forgotPassword"

// ** 首页
#define HOME_URL @"app_ImageLoder?type=1&istype=%d"

// ** 活动列表
#define ActiveList_URL @"AppActiveList?state=%d&page=%d"

// ** 修改个人信息
#define Modify_URL @"upDataMyInformation"

// ** 消息
#define Message_URL @"myMessage?uid=%@&page=%d"

// ** 删除消息
#define delMessage_URL @"delMessage?uid=%@&id=%@"

// ** 我的发布列表
#define PostList_URL @"mypostlist"

// ** 热门标签
#define Tag_URL @"post_tag"

// ** 添加发布
#define AddPost_URL @"addpost"

// ** 我的展项列表
#define EXList_URL @"myExhibition"

// ** 新闻列表
#define News_URL @"AppNewsList"

// ** 研讨交流列表
#define PostAll_URL @"postPageList"

// ** 语言导览列表
#define VoiceList_URL @"voice/list"

// ** 展厅分布图
#define Tu_URL @"myscattergram"

// ** 一键导航
#define Point_URL @"queryTitle"
#define DH_URL @"queryTourImg"

// ** 常设展厅
#define ZXList_URL @"exhibition/list"
#define ZTList_URL @"exhibition/list/office"
#define ZTInfo_URL @"exhibition/office/introduce?id=%@"

// ** 临时展厅
#define LSList_URL @"exhibition/list"

// ** 票务预约
#define Ticket_URL @"Addtickets"
#define TicketInfo_URL @"ticketReservation_info"

// ** 票列表
#define TicketList_URL @"ticketReservation"
#define delTicket_URL @"delticketReservation?id=%@"

// ** 活动预约列表
#define activitList_URL @"ActivitiesappointmentList"
#define delActivit_URL @"delActivitiesappointment?id=%@"

// ** 设备统计
#define SBList_URL @"exhibition_Statistics"
#define SB2List_URL @"exhibition_detailed"
#define SBinfo_URL @"app_equipment_info"

// ** 票务统计
#define Tcount_URL @"myticketCount"

// ** 展项统计
#define ZXcount_URL @"app_equipment_data"

// ** 人数统计
#define Pcount_URL @"app_number_data"

// ** 简介详情(开馆时间)
#define Htime1_URL @"view/ios/time1.html"

// ** 新闻资讯
#define Hnews_URL @"view/ios/news.html?id=%@&uid=%@"

// ** 研讨交流
#define Hcommunication_URL @"view/ios/communication.html?id=%@&uid=%@"

// ** 活动回顾详情
#define Hactivity_URL @"view/ios/activity.html?id=%@"

// ** 活动报名详情
#define HactivityB_URL @"view/ios/activity_name.html?id=%@"

// ** 活动预告_调查详情
#define Hevent_URL @"view/ios/event.html?id=%@"

// ** 评选（4-22）方法2
#define Hselection_URL @"view/ios/selection.html?id=%@"

// ** 展厅信息正在展览详情
#define Hdisplayed_URL @"view/ios/displayed.html?id=%@"

// ** 收藏列表
#define CollectionList_URL @"CollectionList?uid=%@&type=%@&page=%d"

// ** 搜索
#define SearchList_URL @"search/list"

// ** 收藏
#define AddCollection_URL @"AddCollection"

// ** 报名
#define AppActiveBm_URL @"AppActiveBm"

// ** 语音浏览量
#define Addread_URL @"voice/addreadnumber_voice?id=%@"


#endif /* YCHead_h */
