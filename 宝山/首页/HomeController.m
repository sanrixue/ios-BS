//
//  HomeController.m
//  宝山
//
//  Created by 尤超 on 17/4/12.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "HomeController.h"
#import "YCHead.h"
#import "AdScrollView.h"
#import "HomeModel.h"
#import "HomeCell.h"
#import "NewsController.h"
#import "ActivityController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "PostController.h"
#import "TuController.h"
#import "JJController.h"
#import "CSController.h"
#import "LSController.h"
#import "DataController.h"
#import "SearchController.h"
#import "UIButton+ImageTitleSpacing.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

@interface HomeController ()<UIActionSheetDelegate,UIAlertViewDelegate,CLLocationManagerDelegate>{
    
    NSMutableArray *_imageArray;
    
    NSMutableArray * _array;
    
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CLLocationManager *manager;
@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, strong) UIImage *activityImage;
@property (weak, nonatomic) IBOutlet UIButton *topButton;

@end

@implementation HomeController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];


    NSString *url = [NSString stringWithFormat:Main_URL,[NSString stringWithFormat:HOME_URL,1]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        _array = [responseObject[@"imagdata"] mutableCopy];
        
        [self setupUI:_array];
//        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)rightItemClick {
    SearchController *vc = [[SearchController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.navigationItem.title = @"首页";
    
//    UIView *rightButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
//    UIButton *mainAndSearchBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
//    [rightButtonView addSubview:mainAndSearchBtn];
//    [mainAndSearchBtn setImage:[UIImage imageNamed:@"rightItem"] forState:UIControlStateNormal];
//    [mainAndSearchBtn addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightCunstomButtonView = [[UIBarButtonItem alloc] initWithCustomView:rightButtonView];
//    self.navigationItem.rightBarButtonItem = rightCunstomButtonView;
    
  
    _imageArray = [NSMutableArray array];
   
    
    NSString *url = [NSString stringWithFormat:Main_URL,[NSString stringWithFormat:HOME_URL,0]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        _imageArray = [responseObject[@"imagdata"] mutableCopy];
        
        [self createScrollView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
//权限登陆
    DBManager *model = [[DBManager sharedManager] selectOneModel];
    NSMutableArray *mutArray = [NSMutableArray array];
    [mutArray addObject:model];
    UserModel *userModel = mutArray[0];
    
    if ([userModel.user_type isEqualToString:@"5"]) {
    
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(KSCREENWIDTH/8-40, 64+190*KSCREENWIDTH/375, 80*KSCREENWIDTH/375, 60*KSCREENWIDTH/375)];
        [btn setTitle:@"展馆简介" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"未标题-5-1"] forState:UIControlStateNormal];
        [btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:7];
        [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        
        UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(3*KSCREENWIDTH/8-40, 64+190*KSCREENWIDTH/375, 80*KSCREENWIDTH/375, 60*KSCREENWIDTH/375)];
        [btn2 setTitle:@"常设展厅" forState:UIControlStateNormal];
        btn2.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn2 setImage:[UIImage imageNamed:@"未标题-5-2"] forState:UIControlStateNormal];
        [btn2 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:7];
        [btn2 addTarget:self action:@selector(btn2Click) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn2];
        
        
        UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(5*KSCREENWIDTH/8-40, 64+190*KSCREENWIDTH/375, 80*KSCREENWIDTH/375, 60*KSCREENWIDTH/375)];
        [btn3 setTitle:@"临时展厅" forState:UIControlStateNormal];
        btn3.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn3 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn3 setImage:[UIImage imageNamed:@"未标题-5-3"] forState:UIControlStateNormal];
        [btn3 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:7];
        [btn3 addTarget:self action:@selector(btn3Click) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn3];
        
        
        UIButton *btn4 = [[UIButton alloc] initWithFrame:CGRectMake(7*KSCREENWIDTH/8-40, 64+190*KSCREENWIDTH/375, 80*KSCREENWIDTH/375, 60*KSCREENWIDTH/375)];
        [btn4 setTitle:@"交通路线" forState:UIControlStateNormal];
        btn4.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn4 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn4 setImage:[UIImage imageNamed:@"未标题-5-4"] forState:UIControlStateNormal];
        [btn4 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:7];

        
        [btn4 addTarget:self action:@selector(btn4Click) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn4];
        
    } else if ([userModel.user_type isEqualToString:@"7"]) {
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 64+190*KSCREENWIDTH/375, KSCREENWIDTH/5, 60*KSCREENWIDTH/375)];
        [btn setTitle:@"展馆介绍" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTintColor:[UIColor blackColor]];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"首页 1-2"] forState:UIControlStateNormal];
        [btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:7];
        [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        
        UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(KSCREENWIDTH/5, 64+190*KSCREENWIDTH/375, KSCREENWIDTH/5, 60*KSCREENWIDTH/375)];
        [btn2 setTitle:@"常设展厅" forState:UIControlStateNormal];
        btn2.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn2 setTintColor:[UIColor blackColor]];
        [btn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn2 setImage:[UIImage imageNamed:@"首页 1-3"] forState:UIControlStateNormal];
        [btn2 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:7];
        [btn2 addTarget:self action:@selector(btn2Click) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn2];
        
        
        UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(2*KSCREENWIDTH/5, 64+190*KSCREENWIDTH/375, KSCREENWIDTH/5, 60*KSCREENWIDTH/375)];
        [btn3 setTitle:@"临时展厅" forState:UIControlStateNormal];
        btn3.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn3 setTintColor:[UIColor blackColor]];
        [btn3 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn3 setImage:[UIImage imageNamed:@"首页 1-4"] forState:UIControlStateNormal];
        [btn3 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:7];
        [btn3 addTarget:self action:@selector(btn3Click) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn3];
        
        
        UIButton *btn4 = [[UIButton alloc] initWithFrame:CGRectMake(3*KSCREENWIDTH/5, 64+190*KSCREENWIDTH/375, KSCREENWIDTH/5, 60*KSCREENWIDTH/375)];
        [btn4 setTitle:@"交通路线" forState:UIControlStateNormal];
        [btn4 setTintColor:[UIColor blackColor]];
        btn4.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn4 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn4 setImage:[UIImage imageNamed:@"首页 1-5"] forState:UIControlStateNormal];
        [btn4 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:7];
        [btn4 addTarget:self action:@selector(btn4Click) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn4];
        
        UIButton *btn5 = [[UIButton alloc] initWithFrame:CGRectMake(4*KSCREENWIDTH/5, 64+190*KSCREENWIDTH/375, KSCREENWIDTH/5, 60*KSCREENWIDTH/375)];
        [btn5 setTitle:@"数据分析" forState:UIControlStateNormal];
        [btn5 setTintColor:[UIColor blackColor]];
        btn5.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn5 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn5 setImage:[UIImage imageNamed:@"首页 1-6"] forState:UIControlStateNormal];
        [btn5 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:7];
        [btn5 addTarget:self action:@selector(btn5Click) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn5];
        
    }
    
    
    // 旧布局
//    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+190*KSCREENWIDTH/375+60*KSCREENWIDTH/375, KSCREENWIDTH, KSCREENHEIGHT-64-190*KSCREENWIDTH/375-60*KSCREENWIDTH/375-49) style:UITableViewStylePlain];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
//    [self.view addSubview:self.tableView];
//    self.tableView.backgroundColor = [UIColor clearColor];
//    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    
//    
//    //注册表格单元
//    [self.tableView registerClass:[HomeCell class] forCellReuseIdentifier:homeIndentifier];

    
#pragma mark 地图
    // 实例化对象
    _manager = [[CLLocationManager alloc] init];
    
    _manager.delegate = self;
    
    // 请求授权，记得修改的infoplist，NSLocationAlwaysUsageDescription（描述）
    [_manager requestAlwaysAuthorization];
    
    [_manager location];
}

-(void)setupUI:(NSArray *)array
{
    for (int i=0; i<array.count; i++) {
        
        UIView *acticityView=[[UIView alloc] init];
        
        [self.view addSubview:acticityView];

        [acticityView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(187, 142));
            if (i==0 || i==1) {
                make.top.mas_equalTo(self.view).offset(325);
            }
            else
            {
                make.top.mas_equalTo(self.view).offset(467);
                 [acticityView setBackgroundColor:[UIColor whiteColor]];
            }
            
            if (i==1 || i==3) {
                make.left.mas_equalTo(self.view).offset(187);
            }
            else
            {
                make.left.mas_equalTo(self.view).offset(0);
            }
        }];
    
        NSDictionary *dic = array[i];
        
        HomeModel *homeModel = [HomeModel homeWithDict:dic];
        
        UIButton *activity=[[UIButton alloc] init];
        
        activity.tag=100+i;
        
        [activity addTarget:self action:@selector(BtnJump:) forControlEvents:UIControlEventTouchUpInside];
        
        [activity setTitle:homeModel.name forState:UIControlStateNormal];
        activity.titleLabel.font = [UIFont systemFontOfSize:13];
        [activity setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager downloadImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:Main_URL,homeModel.image]] options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            [activity setImage:image forState:UIControlStateNormal];
        }];
        
        
        UILabel *activityLabel=[[UILabel alloc] init];
        
        activityLabel.text=homeModel.name;
    
        activityLabel.textAlignment=NSTextAlignmentCenter;
        
        activityLabel.textColor=[UIColor whiteColor];
        
        activityLabel.backgroundColor=[UIColor colorWithRed:0.25 green:0.24 blue:0.24 alpha:1];
        
        [acticityView addSubview:activity];
    
        [acticityView addSubview:activityLabel];
        
        [activity mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(187,114));
            make.top.mas_equalTo(acticityView);
            if (i==1 || i==3) {
                make.left.mas_equalTo(self.view).offset(187);
            }
            else
            {
                make.left.mas_equalTo(self.view).offset(0);
            }
            
        }];
        [activityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(activity.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(187, 28));
            if (i==1 || i==3) {
                make.left.mas_equalTo(self.view).offset(187);
            }
            else
            {
                make.left.mas_equalTo(self.view).offset(0);
            }
        }];

    }
    

}

-(void)BtnJump:(UIButton *)btn
{
    if ([btn.titleLabel.text isEqualToString:@"新闻资讯"]) {
        NewsController *VC = [[NewsController alloc] init];
        
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if ([btn.titleLabel.text isEqualToString:@"展厅分布"]){
        TuController *VC = [[TuController alloc] init];
        
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if ([btn.titleLabel.text isEqualToString:@"研讨交流"]){
        
        PostController *VC = [[PostController alloc] init];
        
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if ([btn.titleLabel.text isEqualToString:@"活动信息"]){
        ActivityController *VC = [[ActivityController alloc] init];
        
        [self.navigationController pushViewController:VC animated:YES];
        
    }
}

#pragma mark - 代理方法，当授权改变时调用
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    
    // 获取授权后，通过
    if (status == kCLAuthorizationStatusAuthorizedAlways) {
        
        //开始定位(具体位置要通过代理获得)
        [_manager startUpdatingLocation];
        
        //设置精确度
        _manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        
        //设置过滤距离
        _manager.distanceFilter = 1000;
        
        //开始定位方向
        [_manager startUpdatingHeading];
    }

}

#pragma mark - 方向
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    
    //输出方向
    
    //地理方向
    NSLog(@"true = %f ",newHeading.trueHeading);
    
    // 磁极方向
    NSLog(@"mag = %f",newHeading.magneticHeading);
    
    
    
}

#pragma mark - 定位代理
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    //    NSLog(@"%@",locations);
    
    //获取当前位置
    self.location = manager.location;
    //获取坐标
    CLLocationCoordinate2D corrdinate = self.location.coordinate;
    
    //打印地址
    NSLog(@"latitude = %f longtude = %f",corrdinate.latitude,corrdinate.longitude);
    
    // 地址的编码通过经纬度得到具体的地址
    CLGeocoder *gecoder = [[CLGeocoder alloc] init];
    
    [gecoder reverseGeocodeLocation:self.location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        CLPlacemark *placemark = [placemarks firstObject];
        
        //打印地址
        NSLog(@"%@",placemark.name);
    }];
    
    // 通过具体地址去获得经纬度
    CLGeocoder *coder = [[CLGeocoder alloc] init];
    
    [coder geocodeAddressString:@"天河城" completionHandler:^(NSArray *placemarks, NSError *error) {
        
        NSLog(@"_________________________反编码");
        
        CLPlacemark *placeMark = [placemarks firstObject];
        
        NSLog(@"%@ lati = %f long = %f",placeMark.name,placeMark.location.coordinate.latitude,placeMark.location.coordinate.longitude);
        
    }];

    //停止定位
    [_manager stopUpdatingLocation];
    
}


//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return _array.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    NSDictionary *dic = _array[indexPath.row];
//    
//    HomeModel *homeModel = [HomeModel homeWithDict:dic];
//    
//    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:homeIndentifier];
//    //传递模型给cell
//    cell.homeModel = homeModel;
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.backgroundColor = [UIColor clearColor];
//    cell.selectedBackgroundView = [[UIView alloc] init];
//    cell.selectedBackgroundView.frame = cell.frame;
//    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
//    return cell;
//    
//}



////Cell点击
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    HomeCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//    NSString *title = cell.name.text;
//    
//    if ([title isEqualToString:@"新闻资讯"]) {
//        NewsController *VC = [[NewsController alloc] init];
//        
//        [self.navigationController pushViewController:VC animated:YES];
//        
//    }else if ([title isEqualToString:@"展厅分布"]){
//        TuController *VC = [[TuController alloc] init];
//        
//        [self.navigationController pushViewController:VC animated:YES];
//        
//    }else if ([title isEqualToString:@"研讨交流"]){
//        
//        PostController *VC = [[PostController alloc] init];
//        
//        [self.navigationController pushViewController:VC animated:YES];
//        
//    }else if ([title isEqualToString:@"活动信息"]){
//        ActivityController *VC = [[ActivityController alloc] init];
//        
//        [self.navigationController pushViewController:VC animated:YES];
//    
//    }
//
//  
//}
//
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 220*KSCREENWIDTH/375;
//    
//}

- (void)btnClick {
    JJController *VC = [[JJController alloc] init];
    
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)btn2Click {
    CSController *VC = [[CSController alloc] init];
    
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)btn3Click {
    LSController *VC = [[LSController alloc] init];
    
    [self.navigationController pushViewController:VC animated:YES];
}

//地图
- (void)btn4Click {
    [self chooseMap];

}

//数据统计
- (void)btn5Click {
    DataController *VC = [[DataController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)chooseMap {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"苹果地图",@"百度地图", nil];
    [sheet showInView:self.view];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self iosMap];
    } else if (buttonIndex == 1) {
        [self baiduMap];
    }
}

- (void)iosMap {
    
    CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(31.389720, 121.442280);
    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:loc addressDictionary:nil]];
    [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                   launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,
                                   MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
    
}

- (void)baiduMap{
    
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"baidumap://map/"]]){
        
        CLLocationCoordinate2D corrdinate = self.location.coordinate;
        
        
        
        
        NSString *url = [[NSString stringWithFormat:@"baidumap://map/direction?origin=latlng:%f,%f|name:我的位置&destination=latlng:31.389720,121.442280|name:终点&mode=driving",corrdinate.latitude,corrdinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ;
        
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url]];
        
    } else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请安装百度地图" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        
        [alert show];
        
    }
    
    
    
}


#pragma mark - 构建广告滚动视图
- (void)createScrollView
{
    AdScrollView * scrollView = [[AdScrollView alloc]initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 231)];
    //如果滚动视图的父视图由导航控制器控制,必须要设置该属性(ps,猜测这是为了正常显示,导航控制器内部设置了UIEdgeInsetsMake(64, 0, 0, 0))
    //    scrollView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    
    scrollView.imageNameArray = _imageArray;
    
    scrollView.PageControlShowStyle = UIPageControlShowStyleRight;
    scrollView.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    scrollView.pageControl.currentPageIndicatorTintColor = [UIColor purpleColor];
    
    //禁止上下滑动
    scrollView.contentSize =  CGSizeMake(KSCREENWIDTH*3, 0);
    scrollView.alwaysBounceVertical = NO;
    [self.view addSubview:scrollView];
    
    
    UIButton *mainAndSearchBtn = [[UIButton alloc] init];
    [scrollView addSubview:mainAndSearchBtn];
    [mainAndSearchBtn setImage:[UIImage imageNamed:@"rightItem"] forState:UIControlStateNormal];
    [mainAndSearchBtn addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    
    [mainAndSearchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.top.mas_equalTo(self.view).offset(22);
        make.left.mas_equalTo(self.view.mas_right).offset(-45);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
