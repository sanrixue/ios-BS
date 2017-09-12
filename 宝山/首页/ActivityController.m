//
//  ActivityController.m
//  宝山
//
//  Created by 尤超 on 17/4/20.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "ActivityController.h"
#import "YCHead.h"  
#import "ActivityModel.h"
#import "ActivityCell.h"
#import "ActivityInfoController.h"

@interface ActivityController ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSMutableArray * _array;
    
}
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UIButton *btn2;
@property (nonatomic, strong) UIButton *btn3;

@end



@implementation ActivityController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"活动信息";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _array = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, KSCREENWIDTH, KSCREENHEIGHT-40) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    //注册表格单元
    [self.tableView registerClass:[ActivityCell class] forCellReuseIdentifier:activityIndentifier];
    
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, KSCREENWIDTH, 40)];
    icon.image = [UIImage imageNamed:@"Hicon"];
    [self.view addSubview:icon];
    
    self.btn1 = [[UIButton alloc] init];
    [self addButton:self.btn1 Title:@"活动预告" Frame:CGRectMake(0, 64, KSCREENWIDTH/3, 40) Selector:@selector(btn1Click)];
  
    self.btn2 = [[UIButton alloc] init];
    [self addButton:self.btn2 Title:@"活动中" Frame:CGRectMake(KSCREENWIDTH/3, 64, KSCREENWIDTH/3, 40) Selector:@selector(btn2Click)];
    
    self.btn3 = [[UIButton alloc] init];
    [self addButton:self.btn3 Title:@"活动回顾" Frame:CGRectMake(2*KSCREENWIDTH/3, 64, KSCREENWIDTH/3, 40) Selector:@selector(btn3Click)];
    
    
    self.btn1.selected = YES;
    
    
    NSString *url = [NSString stringWithFormat:Main_URL,[NSString stringWithFormat:ActiveList_URL,1,1]];
    
    NSLog(@"%@",url);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        _array = [responseObject[@"data"][@"result"] mutableCopy];
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    

}

- (void)btn1Click {
    self.btn1.selected = YES;
    self.btn2.selected = NO;
    self.btn3.selected = NO;
    
    
    NSString *url = [NSString stringWithFormat:Main_URL,[NSString stringWithFormat:ActiveList_URL,1,1]];
    
    NSLog(@"%@",url);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        _array = [responseObject[@"data"][@"result"] mutableCopy];
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}

- (void)btn2Click {
    self.btn1.selected = NO;
    self.btn2.selected = YES;
    self.btn3.selected = NO;
    
    
    NSString *url = [NSString stringWithFormat:Main_URL,[NSString stringWithFormat:ActiveList_URL,2,1]];
    
    NSLog(@"%@",url);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        _array = [responseObject[@"data"][@"result"] mutableCopy];
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)btn3Click {
    self.btn1.selected = NO;
    self.btn2.selected = NO;
    self.btn3.selected = YES;
    
    
    NSString *url = [NSString stringWithFormat:Main_URL,[NSString stringWithFormat:ActiveList_URL,3,1]];
    
    NSLog(@"%@",url);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        _array = [responseObject[@"data"][@"result"] mutableCopy];
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = _array[indexPath.row];
    
    ActivityModel *activityModel = [ActivityModel activityWithDict:dic];
    
    
    
    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:activityIndentifier];
    
    //传递模型给cell
    cell.activityModel = activityModel;
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = [[UIView alloc] init];
    cell.selectedBackgroundView.frame = cell.frame;
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    return cell;
    
}

//Cell点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ActivityInfoController *VC = [[ActivityInfoController alloc] init];
    VC.ID = _array[indexPath.row][@"id"];
    VC.state = _array[indexPath.row][@"state"];
    VC.type = [NSString stringWithFormat:@"%@",_array[indexPath.row][@"type"] ];
    [self.navigationController pushViewController:VC animated:YES];

   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
