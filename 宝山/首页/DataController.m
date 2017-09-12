//
//  DataController.m
//  宝山
//
//  Created by 尤超 on 2017/5/12.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "DataController.h"
#import "YCHead.h"
#import "SBCell.h"
#import "SBModel.h"
#import "SBController.h"
#import "PNChartDelegate.h"
#import "PNChart.h"
#import "ZXcountCell.h"
#import "ZXcountModel.h"


@interface DataController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,PNChartDelegate>{
    
    NSMutableArray * _array;
    
    NSMutableArray * _array2;
    
    
    UIView *_backView;
    
    NSInteger _btnTag;
    
    NSMutableDictionary *_ticketDic;
    
    UILabel *_lab1;
    UILabel *_lab2;
    UILabel *_lab3;
    UILabel *_lab4;
    
    
    NSMutableDictionary *_pnumberDic;
    
    UILabel *_lab5;
    UILabel *_lab6;
    UILabel *_lab7;
    UILabel *_lab8;
    UILabel *_lab9;
    UILabel *_lab10;
   
    
    
    
    //头试图
    UIView *_headerView;

    NSMutableArray *selectedArr;//控制列表是否被打开
}

@property (nonatomic, strong) UIView *back1;
@property (nonatomic, strong) UIView *back2;
@property (nonatomic, strong) UIView *back3;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UIButton *btn2;
@property (nonatomic, strong) UIButton *btn3;
@property (nonatomic, strong) UIButton *btn4;

@property (nonatomic, strong) UIButton *btn5;
@property (nonatomic, strong) UIButton *btn6;

@property (nonatomic, strong) UIButton *btn7;
@property (nonatomic, strong) UIButton *btn8;

@property (nonatomic, strong) DAYCalendarView *calendarView;

@property (nonatomic,strong) PNBarChart * barChart;
@property (nonatomic) PNPieChart *pieChart;
@property (nonatomic) PNLineChart * lineChart;

@end

@implementation DataController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"数据分析";
    
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, KSCREENWIDTH, 40)];
    icon.image = [UIImage imageNamed:@"Sicon"];
    [self.view addSubview:icon];
    
    
    self.btn1 = [[UIButton alloc] init];
    [self addButton:self.btn1 Title:@"票务统计" Frame:CGRectMake(0, 64, KSCREENWIDTH/4, 40) Selector:@selector(btn1Click)];
    
    self.btn2 = [[UIButton alloc] init];
    [self addButton:self.btn2 Title:@"人数统计" Frame:CGRectMake(KSCREENWIDTH/4, 64, KSCREENWIDTH/4, 40) Selector:@selector(btn2Click)];
    
    self.btn3 = [[UIButton alloc] init];
    [self addButton:self.btn3 Title:@"展项统计" Frame:CGRectMake(2*KSCREENWIDTH/4, 64, KSCREENWIDTH/4, 40) Selector:@selector(btn3Click)];
    
    self.btn4 = [[UIButton alloc] init];
    [self addButton:self.btn4 Title:@"设备统计" Frame:CGRectMake(3*KSCREENWIDTH/4, 64, KSCREENWIDTH/4, 40) Selector:@selector(btn4Click)];
    
    self.btn1.selected = YES;
    
 
    self.back1 = [[UIView alloc] initWithFrame:CGRectMake(0, 110, KSCREENWIDTH, KSCREENHEIGHT-110)];
    self.back1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.back1];
    
    [self addBack1UI];
    
    self.back2 = [[UIView alloc] initWithFrame:CGRectMake(0, 110, KSCREENWIDTH, KSCREENHEIGHT-110)];
    self.back2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.back2];
    self.back2.hidden = YES;
    
    [self addBack2UI];
    
    self.back3 = [[UIView alloc] initWithFrame:CGRectMake(0, 110, KSCREENWIDTH, KSCREENHEIGHT-110)];
    self.back3.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.back3];
    self.back3.hidden = YES;
    

    
    //饼状图
    if (_headerView == nil) {

        _headerView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 260*KSCREENWIDTH/375)];

        _headerView.backgroundColor = [UIColor clearColor];
        
        [self.back3 addSubview:_headerView];
        
        [self addLab:_headerView Name:@"开馆至今展项统计" Frame:CGRectMake(20, 20, 300, 30) Color:COLOR(0, 125, 23, 1) Font:[UIFont systemFontOfSize:20]];

        UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 225, KSCREENWIDTH, 10)];
        lineLab.backgroundColor = COLOR(223, 224, 225, 0.5);
        [_headerView addSubview:lineLab];

        [self addLab:_headerView Name:@"统计明细" Frame:CGRectMake(20, 240, 150, 20) Color:[UIColor blackColor] Font:[UIFont systemFontOfSize:16]];
        
    }
    
    

    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT)];
    _backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_backView];
    _backView.hidden = YES;
    
    self.calendarView =[[DAYCalendarView alloc] initWithFrame:CGRectMake(0, 80, KSCREENWIDTH, 300)];
    [self.calendarView addTarget:self action:@selector(calendarViewDidChange:) forControlEvents:UIControlEventValueChanged];
    [_backView addSubview:self.calendarView];
    
    
    UIButton *confirmBtn = [[UIButton alloc] init];
    confirmBtn.frame = CGRectMake(KSCREENWIDTH * 0.15, KSCREENHEIGHT-44-35-30, KSCREENWIDTH * 0.7, 35);
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    confirmBtn.backgroundColor = COLOR(65, 214, 99, 1);
    confirmBtn.layer.cornerRadius = 17;
    [_backView addSubview:confirmBtn];
    
    
    
    
    _array = [NSMutableArray array];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 260, KSCREENWIDTH, KSCREENHEIGHT-260-110) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.back3 addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    //注册表格单元
    [self.tableView registerClass:[ZXcountCell class] forCellReuseIdentifier:zxcountIndentifier];
    
    self.tableView.scrollEnabled = YES;
   
    
    NSString * url = [NSString stringWithFormat:Main_URL,ZXcount_URL];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        _array = [responseObject[@"data"] mutableCopy];
        
        [self.tableView reloadData];
        
        
        NSArray *items = @[[PNPieChartDataItem dataItemWithValue:[_array[0][@"percent"] intValue] color:COLOR(255, 186, 16, 1) description:_array[0][@"title"]],
                           [PNPieChartDataItem dataItemWithValue:[_array[1][@"percent"] intValue] color:COLOR(229, 94, 18, 1) description:_array[1][@"title"]],
                           [PNPieChartDataItem dataItemWithValue:[_array[2][@"percent"] intValue] color:COLOR(83, 120, 28, 1) description:_array[2][@"title"]],
                           [PNPieChartDataItem dataItemWithValue:[_array[3][@"percent"] intValue] color:COLOR(238, 238, 103, 1) description:_array[3][@"title"]],
                           [PNPieChartDataItem dataItemWithValue:[_array[4][@"percent"] intValue] color:COLOR(30, 123, 147, 1) description:_array[4][@"title"]]
                           ];
        
        self.pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(50, 60, 150, 150) items:items];
        self.pieChart.descriptionTextColor = [UIColor whiteColor];
        self.pieChart.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:11.0];
        self.pieChart.descriptionTextShadowColor = [UIColor clearColor];
        self.pieChart.showAbsoluteValues = NO;
        self.pieChart.showOnlyValues = NO;
        [self.pieChart strokeChart];
        
        //只显示百分百
        self.pieChart.showOnlyValues = YES;
        
        
        self.pieChart.legendStyle = PNLegendItemStyleStacked;
        self.pieChart.legendFont = [UIFont boldSystemFontOfSize:12.0f];
        
        UIView *legend = [self.pieChart getLegendWithMaxWidth:100];
        [legend setFrame:CGRectMake(220, 100, legend.frame.size.width, legend.frame.size.height)];
        [_headerView addSubview:legend];
        
        [_headerView addSubview:self.pieChart];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败: %@",error);
        
    }];
    
    
    
    _array2 = [NSMutableArray array];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 设置collectionView的滚动方向，需要注意的是如果使用了collectionview的headerview或者footerview的话， 如果设置了水平滚动方向的话，那么就只有宽度起作用了了
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    // layout.minimumInteritemSpacing = 10;// 垂直方向的间距
    // layout.minimumLineSpacing = 10; // 水平方向的间距
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 110, KSCREENWIDTH, KSCREENHEIGHT-110) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:self.collectionView];
    
    self.collectionView.hidden = YES;
    
    // 注册collectionViewcell:WWCollectionViewCell是我自定义的cell的类型
    [self.collectionView registerClass:[SBCell class] forCellWithReuseIdentifier:sbIndentifier];
    
    NSString * url2 = [NSString stringWithFormat:Main_URL,SBList_URL];
    
    AFHTTPSessionManager *manager2 = [AFHTTPSessionManager manager];
    
    [manager2 POST:url2 parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        _array2 = [responseObject[@"data"] mutableCopy];
        
        [self.collectionView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败: %@",error);
        
    }];
    
    
    
    selectedArr=[[NSMutableArray alloc]init];
    
}

- (void)addButton:(UIButton *)button Title:(NSString *)title Frame:(CGRect)frame Selector:(SEL)selector {
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleColor:COLOR(35, 130, 47, 1) forState:UIControlStateSelected];
    button.frame = frame;
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)btn1Click {
    self.btn1.selected = YES;
    self.btn2.selected = NO;
    self.btn3.selected = NO;
    self.btn4.selected = NO;
    
    self.back1.hidden = NO;
    self.back2.hidden = YES;
    self.back3.hidden = YES;
    self.collectionView.hidden = YES;
    
}

- (void)btn2Click {
    self.btn1.selected = NO;
    self.btn2.selected = YES;
    self.btn3.selected = NO;
    self.btn4.selected = NO;
    
    self.back1.hidden = YES;
    self.back2.hidden = NO;
    self.back3.hidden = YES;
    self.collectionView.hidden = YES;
    
    
}

- (void)btn3Click {
    self.btn1.selected = NO;
    self.btn2.selected = NO;
    self.btn3.selected = YES;
    self.btn4.selected = NO;
    
    self.back1.hidden = YES;
    self.back2.hidden = YES;
    self.back3.hidden = NO;
    self.collectionView.hidden = YES;
 
}

- (void)btn4Click {
    self.btn1.selected = NO;
    self.btn2.selected = NO;
    self.btn3.selected = NO;
    self.btn4.selected = YES;
    
    self.back1.hidden = YES;
    self.back2.hidden = YES;
    self.back3.hidden = YES;
    self.collectionView.hidden = NO;
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addLab:(UIView *)view Name:(NSString *)name Frame:(CGRect)frame Color:(UIColor *)color Font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = name;
    label.font = font;
    label.textColor = color;
    label.textAlignment = NSTextAlignmentLeft;
    [view addSubview:label];
   
}


- (void)addLab:(UIView *)view Frame:(CGRect)frame Color:(UIColor *)color {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textColor = color;
    label.textAlignment = NSTextAlignmentLeft;
    [view addSubview:label];
    
}

- (void)addLab2:(UILabel *)label View:(UIView *)view Frame:(CGRect)frame Color:(UIColor *)color {
    label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = color;
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = label.size.height/2;
    [view addSubview:label];
    
}

- (void)addLab3:(UILabel *)label View:(UIView *)view Frame:(CGRect)frame Color:(UIColor *)color {
    label.frame= frame;
    label.backgroundColor = color;
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = label.size.height/2;
    [view addSubview:label];
    
}

#pragma mark 票务统计
- (void)addBack1UI {
    [self addLab:self.back1 Name:@"起始日期" Frame:CGRectMake(20, 20, 60, 20) Color:COLOR(35, 130, 47, 1) Font:[UIFont systemFontOfSize:12]];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(70, 20, 110, 20)];
    [btn setTitle:dateTime forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"Sicon2"] forState:UIControlStateNormal];
    [btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:2];
    [btn addTarget:self action:@selector(btn5Click) forControlEvents:UIControlEventTouchUpInside];
    [self.back1 addSubview:btn];
    self.btn5 = btn;
    
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(KSCREENWIDTH/2-10, 25, 20, 10)];
    icon.image = [UIImage imageNamed:@"Sicon1"];
    [self.back1 addSubview:icon];
    
    
    [self addLab:self.back1 Name:@"终止日期" Frame:CGRectMake(KSCREENWIDTH-160, 20, 60, 20) Color:COLOR(35, 130, 47, 1) Font:[UIFont systemFontOfSize:12]];
    
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(KSCREENWIDTH-110, 20, 110, 20)];
    [btn2 setTitle:dateTime forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"Sicon2"] forState:UIControlStateNormal];
    [btn2 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
    [btn2 addTarget:self action:@selector(btn6Click) forControlEvents:UIControlEventTouchUpInside];
    [self.back1 addSubview:btn2];
    self.btn6 = btn2;
    
    
    UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 300, KSCREENWIDTH, 10)];
    lineLab.backgroundColor = COLOR(223, 224, 225, 0.5);
    [self.back1 addSubview:lineLab];
    
    
    [self addLab:self.back1 Name:@"统计明细" Frame:CGRectMake(20, 330, 150, 20) Color:[UIColor blackColor] Font:[UIFont systemFontOfSize:16]];
    
    [self addLab:self.back1 Name:@"网上预约" Frame:CGRectMake(20, 380, 150, 20) Color:[UIColor grayColor] Font:[UIFont systemFontOfSize:14]];

    [self addLab:self.back1 Name:@"现场领卷" Frame:CGRectMake(20, 430, 150, 20) Color:[UIColor grayColor] Font:[UIFont systemFontOfSize:14]];
    
    
    _lab3 = [[UILabel alloc] initWithFrame:CGRectMake(KSCREENWIDTH-100, 380, 80, 20)];
    _lab3.text = [NSString stringWithFormat:@"0张"];
    _lab3.font = [UIFont systemFontOfSize:14];
    _lab3.textColor = [UIColor grayColor];
    _lab3.textAlignment = NSTextAlignmentRight;
    [self.back1 addSubview:_lab3];
    
    
    _lab4 = [[UILabel alloc] initWithFrame:CGRectMake(KSCREENWIDTH-100, 430, 80, 20)];
    _lab4.text = [NSString stringWithFormat:@"0张"];
    _lab4.font = [UIFont systemFontOfSize:14];
    _lab4.textColor = [UIColor grayColor];
    _lab4.textAlignment = NSTextAlignmentRight;
    [self.back1 addSubview:_lab4];
    
    
    _lab1 = [[UILabel alloc] init];
    _lab2 = [[UILabel alloc] init];
    [self addLab3:_lab1 View:self.back1 Frame:CGRectMake(20, 400, 0, 20) Color:COLOR(30, 123, 147, 1)];
    [self addLab3:_lab2 View:self.back1 Frame:CGRectMake(20, 450, 0, 20) Color:COLOR(255, 185, 16, 1)];
    
    [self addLab2:nil View:self.back1 Frame:CGRectMake(20, 400, KSCREENWIDTH-40, 20) Color:COLOR(223, 224, 225, 0.5)];
    
    [self addLab2:nil View:self.back1 Frame:CGRectMake(20, 450, KSCREENWIDTH-40, 20) Color:COLOR(223, 224, 225, 0.5)];
    
  

    
    UIButton *searchbtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 60, 30, 20)];
    [searchbtn setTitle:@"查询" forState:UIControlStateNormal];
    searchbtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [searchbtn setTitleColor:COLOR(35, 130, 47, 1) forState:UIControlStateNormal];
    [searchbtn addTarget:self action:@selector(searchbtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.back1 addSubview:searchbtn];
    
    
    
    //柱状图
    static NSNumberFormatter *barChartFormatter;
    if (!barChartFormatter){
        barChartFormatter = [[NSNumberFormatter alloc] init];
        barChartFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
        barChartFormatter.allowsFloats = NO;
        barChartFormatter.maximumFractionDigits = 0;
    }
    
    self.barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(20, 80, KSCREENWIDTH-40, 200)];
    
    //    //是否显示具体数值
    //    self.barChart.showLabel = NO;
    
    self.barChart.backgroundColor = [UIColor clearColor];
    
    
    self.barChart.labelMarginTop = 5.0;
    self.barChart.showChartBorder = YES;
    
    
    [self.barChart setXLabels:@[@"总票数",@"网上预约",@"现场领卷"]];
    [self.barChart setYValues:@[@0,@0,@0]];
    [self.barChart setStrokeColors:@[COLOR(226, 95, 22, 1),COLOR(30, 123, 147, 1),COLOR(255, 185, 16, 1)]];
    self.barChart.isGradientShow = NO;
    self.barChart.isShowNumbers = NO;
    
    
    [self.barChart strokeChart];
    
    self.barChart.delegate = self;
    
    [self.back1 addSubview:self.barChart];
    

    
    _ticketDic = [NSMutableDictionary dictionary];
    
    NSString *url = [NSString stringWithFormat:Main_URL,Tcount_URL];
    
    NSDictionary *dic = @{@"startime":self.btn5.titleLabel.text,
                          @"endtime":self.btn6.titleLabel.text};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        _ticketDic = responseObject[@"data"];
        
        [self.barChart updateChartData:@[_ticketDic[@"toalCounts"],_ticketDic[@"onlines"],_ticketDic[@"scene"]]];
        
        _lab3.text = [NSString stringWithFormat:@"%@张",_ticketDic[@"onlines"]];
        _lab4.text = [NSString stringWithFormat:@"%@张",_ticketDic[@"scene"]];
        
        
        if ([[NSString stringWithFormat:@"%@",_ticketDic[@"toalCounts"]] isEqualToString:@"0"]) {
            _lab1.hidden =  YES;
            _lab2.hidden =  YES;
            
        } else {
            float a = [_ticketDic[@"onlines"] floatValue]/[_ticketDic[@"toalCounts"] floatValue];
            float b = [_ticketDic[@"scene"] floatValue]/[_ticketDic[@"toalCounts"] floatValue];
            
            
            _lab1.size = CGSizeMake(a*(KSCREENWIDTH-40), 20);
            _lab2.size = CGSizeMake(b*(KSCREENWIDTH-40), 20);
            
            _lab1.hidden =  NO;
            _lab2.hidden =  NO;
        }
        
       

        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    
}

//票务统计查询
- (void)searchbtnClick {
    NSString *url = [NSString stringWithFormat:Main_URL,Tcount_URL];
    
    NSDictionary *dic = @{@"startime":self.btn5.titleLabel.text,
                          @"endtime":self.btn6.titleLabel.text};

    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        _ticketDic = responseObject[@"data"];
        
        NSLog(@"%@",_ticketDic);
        
        [self.barChart updateChartData:@[_ticketDic[@"toalCounts"],_ticketDic[@"onlines"],_ticketDic[@"scene"]]];
        
        _lab3.text = [NSString stringWithFormat:@"%@张",_ticketDic[@"onlines"]];
        _lab4.text = [NSString stringWithFormat:@"%@张",_ticketDic[@"scene"]];
        
        if ([[NSString stringWithFormat:@"%@",_ticketDic[@"toalCounts"]] isEqualToString:@"0"]) {
            _lab1.hidden =  YES;
            _lab2.hidden =  YES;
            
        } else {
            float a = [_ticketDic[@"onlines"] floatValue]/[_ticketDic[@"toalCounts"] floatValue];
            float b = [_ticketDic[@"scene"] floatValue]/[_ticketDic[@"toalCounts"] floatValue];
    
    
            _lab1.size = CGSizeMake(a*(KSCREENWIDTH-40), 20);
            _lab2.size = CGSizeMake(b*(KSCREENWIDTH-40), 20);
            
            _lab1.hidden =  NO;
            _lab2.hidden =  NO;
        }
        
       
    
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    

}

- (void)confirmBtnClick {
    _backView.hidden = YES;
}

- (void)calendarViewDidChange:(id)sender {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd";
    
    NSString *time = [NSString stringWithFormat:@"%@",[formatter stringFromDate:self.calendarView.selectedDate]];
    
   
    
    if (_btnTag == 5) {
        [self.btn5 setTitle:time forState:UIControlStateNormal];
    } else if (_btnTag == 6) {
        [self.btn6 setTitle:time forState:UIControlStateNormal];

    } else if (_btnTag == 7) {
        [self.btn7 setTitle:time forState:UIControlStateNormal];
        
    } else if (_btnTag == 8) {
        [self.btn8 setTitle:time forState:UIControlStateNormal];
        
    }
}


- (void)btn5Click {
    _backView.hidden = NO;
    
    _btnTag = 5;
}

- (void)btn6Click {
    _backView.hidden = NO;
    
    _btnTag = 6;
}

- (void)btn7Click {
    _backView.hidden = NO;
    
    _btnTag = 7;
}

- (void)btn8Click {
    _backView.hidden = NO;
    
    _btnTag = 8;
}


#pragma mark 人数统计
- (void)addBack2UI {
    [self addLab:self.back2 Name:@"起始日期" Frame:CGRectMake(20, 20, 60, 20) Color:COLOR(35, 130, 47, 1) Font:[UIFont systemFontOfSize:12]];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(70, 20, 110, 20)];
    [btn setTitle:dateTime forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"Sicon2"] forState:UIControlStateNormal];
    [btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:2];
    [btn addTarget:self action:@selector(btn7Click) forControlEvents:UIControlEventTouchUpInside];
    [self.back2 addSubview:btn];
    self.btn7 = btn;
    
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(KSCREENWIDTH/2-10, 25, 20, 10)];
    icon.image = [UIImage imageNamed:@"Sicon1"];
    [self.back2 addSubview:icon];
    
    
    [self addLab:self.back2 Name:@"终止日期" Frame:CGRectMake(KSCREENWIDTH-160, 20, 60, 20) Color:COLOR(35, 130, 47, 1) Font:[UIFont systemFontOfSize:12]];
    
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(KSCREENWIDTH-110, 20, 110, 20)];
    [btn2 setTitle:dateTime forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"Sicon2"] forState:UIControlStateNormal];
    [btn2 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
    [btn2 addTarget:self action:@selector(btn8Click) forControlEvents:UIControlEventTouchUpInside];
    [self.back2 addSubview:btn2];
    self.btn8 = btn2;
    
    
    UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 300, KSCREENWIDTH, 10)];
    lineLab.backgroundColor = COLOR(223, 224, 225, 0.5);
    [self.back2 addSubview:lineLab];
    
    
    [self addLab:self.back2 Name:@"统计明细" Frame:CGRectMake(20, 330, 150, 20) Color:[UIColor blackColor] Font:[UIFont systemFontOfSize:16]];
    
    [self addLab:self.back2 Name:@"进馆人数" Frame:CGRectMake(20, 380, 150, 20) Color:[UIColor grayColor] Font:[UIFont systemFontOfSize:14]];
    
    [self addLab:self.back2 Name:@"展项人数" Frame:CGRectMake(20, 430, 150, 20) Color:[UIColor grayColor] Font:[UIFont systemFontOfSize:14]];
    
    [self addLab:self.back2 Name:@"节假日人数" Frame:CGRectMake(20, 480, 150, 20) Color:[UIColor grayColor] Font:[UIFont systemFontOfSize:14]];
    
    
    _lab5 = [[UILabel alloc] initWithFrame:CGRectMake(KSCREENWIDTH-100, 380, 80, 20)];
    _lab5.text = [NSString stringWithFormat:@"0人"];
    _lab5.font = [UIFont systemFontOfSize:14];
    _lab5.textColor = [UIColor grayColor];
    _lab5.textAlignment = NSTextAlignmentRight;
    [self.back2 addSubview:_lab5];
    
    
    _lab6 = [[UILabel alloc] initWithFrame:CGRectMake(KSCREENWIDTH-100, 430, 80, 20)];
    _lab6.text = [NSString stringWithFormat:@"0人"];
    _lab6.font = [UIFont systemFontOfSize:14];
    _lab6.textColor = [UIColor grayColor];
    _lab6.textAlignment = NSTextAlignmentRight;
    [self.back2 addSubview:_lab6];
    
    _lab7 = [[UILabel alloc] initWithFrame:CGRectMake(KSCREENWIDTH-100, 480, 80, 20)];
    _lab7.text = [NSString stringWithFormat:@"0人"];
    _lab7.font = [UIFont systemFontOfSize:14];
    _lab7.textColor = [UIColor grayColor];
    _lab7.textAlignment = NSTextAlignmentRight;
    [self.back2 addSubview:_lab7];
    
    _lab8 = [[UILabel alloc] init];
    _lab9 = [[UILabel alloc] init];
    _lab10 = [[UILabel alloc] init];
    [self addLab3:_lab8 View:self.back2 Frame:CGRectMake(20, 400, 0, 20) Color:COLOR(30, 123, 147, 1)];
    [self addLab3:_lab9 View:self.back2 Frame:CGRectMake(20, 450, 0, 20) Color:COLOR(255, 185, 16, 1)];
    [self addLab3:_lab10 View:self.back2 Frame:CGRectMake(20, 500, 0, 20) Color:COLOR(255, 185, 16, 1)];
    
    [self addLab2:nil View:self.back2 Frame:CGRectMake(20, 400, KSCREENWIDTH-40, 20) Color:COLOR(223, 224, 225, 0.5)];
    
    [self addLab2:nil View:self.back2 Frame:CGRectMake(20, 450, KSCREENWIDTH-40, 20) Color:COLOR(223, 224, 225, 0.5)];
    
    [self addLab2:nil View:self.back2 Frame:CGRectMake(20, 500, KSCREENWIDTH-40, 20) Color:COLOR(223, 224, 225, 0.5)];
    
    
    UIButton *searchbtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 60, 30, 20)];
    [searchbtn setTitle:@"查询" forState:UIControlStateNormal];
    searchbtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [searchbtn setTitleColor:COLOR(35, 130, 47, 1) forState:UIControlStateNormal];
    [searchbtn addTarget:self action:@selector(searchbtn2Click) forControlEvents:UIControlEventTouchUpInside];
    [self.back2 addSubview:searchbtn];
    

    
    
    
    self.lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(20, 80, KSCREENWIDTH-40, 200)];
    self.lineChart.yLabelFormat = @"%1.1f";
    self.lineChart.backgroundColor = [UIColor clearColor];
    [self.lineChart setXLabels:nil];
    self.lineChart.showCoordinateAxis = YES;
    
    // added an examle to show how yGridLines can be enabled
    // the color is set to clearColor so that the demo remains the same
    self.lineChart.yGridLinesColor = [UIColor clearColor];
    self.lineChart.showYGridLines = YES;
    
    //Use yFixedValueMax and yFixedValueMin to Fix the Max and Min Y Value
    //Only if you needed
    self.lineChart.yFixedValueMax = 1000.0;
    self.lineChart.yFixedValueMin = 0.0;
    
    [self.lineChart setYLabels:@[
                                 @"0",
                                 @"200",
                                 @"400",
                                 @"600",
                                 @"800",
                                 @"1000"
                                 ]
     ];
    
    // Line Chart #1
    NSArray * data01Array = nil;
    PNLineChartData *data01 = [PNLineChartData new];
    data01.dataTitle = @"进馆人数";
    data01.color = PNFreshGreen;
    data01.alpha = 0.3f;
    data01.itemCount = data01Array.count;
    data01.inflexionPointColor = PNRed;
    data01.inflexionPointStyle = PNLineChartPointStyleTriangle;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    // Line Chart #2
    NSArray * data02Array = nil;
    PNLineChartData *data02 = [PNLineChartData new];
    data02.dataTitle = @"展项人数";
    data02.color = PNTwitterColor;
    data02.alpha = 0.5f;
    data02.itemCount = data02Array.count;
    data02.inflexionPointStyle = PNLineChartPointStyleCircle;
    data02.getData = ^(NSUInteger index) {
        CGFloat yValue = [data02Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    self.lineChart.chartData = @[data01, data02];
    [self.lineChart strokeChart];
    self.lineChart.delegate = self;
    
    
    [self.back2 addSubview:self.lineChart];
    
    self.lineChart.legendStyle = PNLegendItemStyleStacked;
    self.lineChart.legendFont = [UIFont boldSystemFontOfSize:10.0f];
    self.lineChart.legendFontColor = [UIColor blackColor];
    
    UIView *legend = [self.lineChart getLegendWithMaxWidth:320];
    [legend setFrame:CGRectMake(60, 100, legend.frame.size.width, legend.frame.size.width)];
    [self.back2 addSubview:legend];

   

    
    
    _pnumberDic = [NSMutableDictionary dictionary];
    
    NSString *url = [NSString stringWithFormat:Main_URL,Pcount_URL];
    
    NSDictionary *dic = @{@"start":self.btn7.titleLabel.text,
                          @"end":self.btn8.titleLabel.text};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        _pnumberDic = responseObject;
        
        
        NSArray *array1 = _pnumberDic[@"jinguanlist"];
        NSMutableArray* result1 = [NSMutableArray array];
        NSMutableArray* day = [NSMutableArray array];
        
        for (int i = 0; i<array1.count ; i++) {
            NSDictionary *dic = array1[i][@"count"];
            [result1 addObject:dic];
            
            NSString *str = [array1[i][@"visittime"] substringFromIndex:5];
            [day addObject:str];
        }
        
        
        NSArray *array2 = _pnumberDic[@"zxlist"];
        NSMutableArray* result2 = [NSMutableArray array];
        
        for (int i = 0; i<array2.count ; i++) {
            NSDictionary *dic = array2[i][@"number"];
            [result2 addObject:dic];
        }
        
        
        
        // Line Chart #1
        NSArray * data01Array = result1;
        
        PNLineChartData *data01 = [PNLineChartData new];
        data01.color = PNFreshGreen;
        data01.itemCount = data01Array.count;
        data01.inflexionPointColor = PNRed;
        data01.inflexionPointStyle = PNLineChartPointStyleTriangle;
        data01.getData = ^(NSUInteger index) {
            CGFloat yValue = [data01Array[index] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue];
        };
        
        // Line Chart #2
        NSArray * data02Array = result2;
        PNLineChartData *data02 = [PNLineChartData new];
        data02.color = PNTwitterColor;
        data02.itemCount = data02Array.count;
        data02.inflexionPointStyle = PNLineChartPointStyleCircle;
        data02.getData = ^(NSUInteger index) {
            CGFloat yValue = [data02Array[index] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue];
        };
        
        [self.lineChart setXLabels:day];
        [self.lineChart updateChartData:@[data01, data02]];
        
        
        
        
        _lab5.text = [NSString stringWithFormat:@"%@人",_pnumberDic[@"jinguan"]];
        _lab6.text = [NSString stringWithFormat:@"%@人",_pnumberDic[@"zhanxiang"]];
        _lab7.text = [NSString stringWithFormat:@"%@人",_pnumberDic[@"holiday"]];
        
        float total = [_pnumberDic[@"jinguan"] floatValue]+[_pnumberDic[@"zhanxiang"] floatValue]+[_pnumberDic[@"holiday"] floatValue];
        
        if (total == 0.0) {
            _lab8.hidden = YES;
            _lab9.hidden = YES;
            _lab10.hidden = YES;
        } else {
            _lab8.hidden = NO;
            _lab9.hidden = NO;
            _lab10.hidden = NO;
            
            float a = [_pnumberDic[@"jinguan"] floatValue]/total;
            float b = [_pnumberDic[@"zhanxiang"] floatValue]/total;
            float c = [_pnumberDic[@"holiday"] floatValue]/total;
            
            _lab8.size = CGSizeMake(a*(KSCREENWIDTH-40), 20);
            _lab9.size = CGSizeMake(b*(KSCREENWIDTH-40), 20);
            _lab10.size = CGSizeMake(c*(KSCREENWIDTH-40), 20);
            
        }

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    

    
}

//人数统计查询
- (void)searchbtn2Click {
    _pnumberDic = [NSMutableDictionary dictionary];
    
    NSString *url = [NSString stringWithFormat:Main_URL,Pcount_URL];
    
    NSDictionary *dic = @{@"start":self.btn7.titleLabel.text,
                          @"end":self.btn8.titleLabel.text};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        _pnumberDic = responseObject;
        
        NSLog(@"%@",_pnumberDic[@"jinguanlist"]);
        
        NSArray *array1 = _pnumberDic[@"jinguanlist"];
        NSMutableArray* result1 = [NSMutableArray array];
        NSMutableArray* day = [NSMutableArray array];
        
        for (int i = 0; i<array1.count ; i++) {
            NSDictionary *dic = array1[i][@"count"];
            [result1 addObject:dic];
            
            NSString *str = [array1[i][@"visittime"] substringFromIndex:5];
            [day addObject:str];
        }
        
        
        NSArray *array2 = _pnumberDic[@"zxlist"];
        NSMutableArray* result2 = [NSMutableArray array];
        
        for (int i = 0; i<array2.count ; i++) {
            NSDictionary *dic = array2[i][@"number"];
            [result2 addObject:dic];
        }

        
        
        // Line Chart #1
        NSArray * data01Array = result1;
        
        NSLog(@"%@",data01Array);
        
        PNLineChartData *data01 = [PNLineChartData new];
        data01.color = PNFreshGreen;
        data01.itemCount = data01Array.count;
        data01.inflexionPointColor = PNRed;
        data01.inflexionPointStyle = PNLineChartPointStyleTriangle;
        data01.getData = ^(NSUInteger index) {
            CGFloat yValue = [data01Array[index] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue];
        };
        
        // Line Chart #2
        NSArray * data02Array = result2;
        PNLineChartData *data02 = [PNLineChartData new];
        data02.color = PNTwitterColor;
        data02.itemCount = data02Array.count;
        data02.inflexionPointStyle = PNLineChartPointStyleCircle;
        data02.getData = ^(NSUInteger index) {
            CGFloat yValue = [data02Array[index] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue];
        };
        
        [self.lineChart setXLabels:day];
        [self.lineChart updateChartData:@[data01, data02]];

    
        _lab5.text = [NSString stringWithFormat:@"%@人",_pnumberDic[@"jinguan"]];
        _lab6.text = [NSString stringWithFormat:@"%@人",_pnumberDic[@"zhanxiang"]];
        _lab7.text = [NSString stringWithFormat:@"%@人",_pnumberDic[@"holiday"]];
        
        
        float total = [_pnumberDic[@"jinguan"] floatValue]+[_pnumberDic[@"zhanxiang"] floatValue]+[_pnumberDic[@"holiday"] floatValue];
        
        if (total == 0.0) {
            _lab8.hidden = YES;
            _lab9.hidden = YES;
            _lab10.hidden = YES;
        } else {
            _lab8.hidden = NO;
            _lab9.hidden = NO;
            _lab10.hidden = NO;
        
            float a = [_pnumberDic[@"jinguan"] floatValue]/total;
            float b = [_pnumberDic[@"zhanxiang"] floatValue]/total;
            float c = [_pnumberDic[@"holiday"] floatValue]/total;
            
            _lab8.size = CGSizeMake(a*(KSCREENWIDTH-40), 20);
            _lab9.size = CGSizeMake(b*(KSCREENWIDTH-40), 20);
            _lab10.size = CGSizeMake(c*(KSCREENWIDTH-40), 20);
    
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}


#pragma mark 展项统计
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //返回列表的行数
    return _array.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *indexStr =   [NSString stringWithFormat: @"%zd",section];
    NSDictionary *dic=[_array objectAtIndex:section];
    NSArray *arr=[dic objectForKey:@"jqlist"];
    if ([selectedArr containsObject:indexStr]) {
        return arr.count;
    } else {
        return 0;
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 55;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 375, 50)];
    view.backgroundColor=[UIColor whiteColor];
    
    NSDictionary *dic=[_array objectAtIndex:section];
 
    CreatControls *creatControls = [[CreatControls alloc] init];
    
    //添加label
    UILabel *title = [[UILabel alloc] init];
    [creatControls historyLab:title andNumber:14];
    [view addSubview:title];
    title.textColor = [UIColor darkGrayColor];
    title.textAlignment = NSTextAlignmentLeft;
    title.text = dic[@"title"];
    
    UILabel *countNum = [[UILabel alloc] init];
    [creatControls historyLab:countNum andNumber:14];
    [view addSubview:countNum];
    countNum.textColor = [UIColor darkGrayColor];
    countNum.textAlignment = NSTextAlignmentRight;
    countNum.text = [NSString stringWithFormat:@"%@人",dic[@"countNum"]];
    
    UILabel *percent = [[UILabel alloc] init];
    percent.layer.masksToBounds = YES;
    percent.layer.cornerRadius = 10;
    [view addSubview:percent];
    
    
    UILabel *lab = [[UILabel alloc] init];
    lab.backgroundColor = COLOR(223, 224, 225, 0.5);
    lab.layer.masksToBounds = YES;
    lab.layer.cornerRadius = 10;
    [view addSubview:lab];
    

    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_top).offset(5);
        make.left.equalTo(view.mas_left).offset(20);
        make.size.mas_equalTo(CGSizeMake(150, 20));
    }];
    
    
    [countNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_top).offset(0);
        make.right.equalTo(view.mas_right).offset(-20);
        make.size.mas_equalTo(CGSizeMake(150, 20));
    }];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title.mas_bottom).offset(5);
        make.left.equalTo(view.mas_left).offset(20);
        make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH-40, 20));
    }];

    if ([dic[@"title"] isEqualToString:@"城市如画"]) {
        percent.backgroundColor = COLOR(30, 123, 147, 1);
    } else if ([dic[@"title"] isEqualToString:@"迁变万化"]) {
        percent.backgroundColor = COLOR(83, 120, 28, 1);
    } else if ([dic[@"title"] isEqualToString:@"城市客厅"]) {
        percent.backgroundColor = COLOR(255, 186, 16, 1);
    } else if ([dic[@"title"] isEqualToString:@"埠通天下"]) {
        percent.backgroundColor = COLOR(229, 94, 18, 1);
    } else if ([dic[@"title"] isEqualToString:@"蓝图擘划"]) {
        percent.backgroundColor = [UIColor yellowColor];
    }
    
    CGFloat width = (KSCREENWIDTH-40)*[dic[@"percent"] floatValue]/100;
    
    
    [percent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title.mas_bottom).offset(5);
        make.left.equalTo(title.mas_left).offset(0);
        make.size.mas_equalTo(CGSizeMake(width, 20));
    }];

    
    //添加一个button 用来监听点击分组，实现分组的展开关闭。
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 375, 50);
    btn.tag=10000+section;
    [btn addTarget:self action:@selector(btnOpenList:) forControlEvents:UIControlEventTouchDown];
    [view addSubview:btn];
    
    return view;
}

-(void)btnOpenList:(UIButton *)sender
{
    NSString *string = [NSString stringWithFormat:@"%ld",sender.tag-10000];
    
    //数组selectedArr里面存的数据和表头想对应，方便以后做比较
    if ([selectedArr containsObject:string])
    {
        [selectedArr removeObject:string];
    }
    else
    {
        [selectedArr addObject:string];
    }
    
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSDictionary *dic=[_array objectAtIndex:indexPath.section];
    
    NSArray *arr=[dic objectForKey:@"jqlist"];
    
    ZXcountModel *zxcountModel = [ZXcountModel zxWithDict:arr[indexPath.row]];
    
    ZXcountCell *cell = [tableView dequeueReusableCellWithIdentifier:zxcountIndentifier];
    
    //传递模型给cell
    cell.zxcountModel = zxcountModel;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = [[UIView alloc] init];
    cell.selectedBackgroundView.frame = cell.frame;
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    return cell;
    

    
}

//Cell点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",indexPath.row);
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 20;
    
}

#pragma mark -- 设备统计
/** 每组cell的个数*/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _array2.count;
}

/** cell的内容*/
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = _array2[indexPath.row];
    
    SBModel *model = [SBModel sbWithDict:dic];
    
    SBCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:sbIndentifier forIndexPath:indexPath];
    
    cell.sbModel = model;
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
    
}

/** 每个cell的尺寸*/
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(KSCREENWIDTH/2-10, 160);
}

/** section的margin*/
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 5, 5, 5);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SBController *VC = [[SBController alloc] init];
    VC.ID = _array2[indexPath.row][@"id"];
    [self.navigationController pushViewController:VC animated:YES];
}

@end
