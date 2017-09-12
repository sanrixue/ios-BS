//
//  LSController.m
//  宝山
//
//  Created by 尤超 on 2017/5/9.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "LSController.h"
#import "YCHead.h"
#import "LSModel.h"
#import "LSCell.h"
#import "LSInfoController.h"

@interface LSController ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSMutableArray * _array;
    
}
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UIButton *btn2;
@property (nonatomic, strong) UIButton *btn3;

@end



@implementation LSController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    NSString *url = [NSString stringWithFormat:Main_URL,LSList_URL];
    
    NSLog(@"%@",url);
    
    NSDictionary *dic = @{@"zl_type":@"2",
                          @"ls_status":@"1",
                          @"page":@"1"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        _array = [responseObject[@"list"][@"result"] mutableCopy];
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"临时展厅";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _array = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, KSCREENWIDTH, KSCREENHEIGHT-104) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    //注册表格单元
    [self.tableView registerClass:[LSCell class] forCellReuseIdentifier:lsIndentifier];
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, KSCREENWIDTH, 40)];
    icon.image = [UIImage imageNamed:@"Hicon"];
    [self.view addSubview:icon];

    
    
    self.btn1 = [[UIButton alloc] init];
    [self addButton:self.btn1 Title:@"临展预告" Frame:CGRectMake(0, 64, KSCREENWIDTH/3, 40) Selector:@selector(btn1Click)];
    
    self.btn2 = [[UIButton alloc] init];
    [self addButton:self.btn2 Title:@"正在展览" Frame:CGRectMake(KSCREENWIDTH/3, 64, KSCREENWIDTH/3, 40) Selector:@selector(btn2Click)];
    
    self.btn3 = [[UIButton alloc] init];
    [self addButton:self.btn3 Title:@"展览回顾" Frame:CGRectMake(2*KSCREENWIDTH/3, 64, KSCREENWIDTH/3, 40) Selector:@selector(btn3Click)];
    
    
    self.btn1.selected = YES;
}

- (void)btn1Click {
    self.btn1.selected = YES;
    self.btn2.selected = NO;
    self.btn3.selected = NO;
    
    
    NSString *url = [NSString stringWithFormat:Main_URL,LSList_URL];
    
    NSLog(@"%@",url);
    
    NSDictionary *dic = @{@"zl_type":@"2",
                          @"ls_status":@"1",
                          @"page":@"1"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        _array = [responseObject[@"list"][@"result"] mutableCopy];
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)btn2Click {
    self.btn1.selected = NO;
    self.btn2.selected = YES;
    self.btn3.selected = NO;
    
    
    NSString *url = [NSString stringWithFormat:Main_URL,LSList_URL];
    
    NSLog(@"%@",url);
    
    NSDictionary *dic = @{@"zl_type":@"2",
                          @"ls_status":@"2",
                          @"page":@"1"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        _array = [responseObject[@"list"][@"result"] mutableCopy];
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)btn3Click {
    self.btn1.selected = NO;
    self.btn2.selected = NO;
    self.btn3.selected = YES;
    
    
    NSString *url = [NSString stringWithFormat:Main_URL,LSList_URL];
    
    NSLog(@"%@",url);
    
    NSDictionary *dic = @{@"zl_type":@"2",
                          @"ls_status":@"3",
                          @"page":@"1"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        _array = [responseObject[@"list"][@"result"] mutableCopy];
        
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
    
    LSModel *lsModel = [LSModel lsWithDict:dic];
    
    
    
    LSCell *cell = [tableView dequeueReusableCellWithIdentifier:lsIndentifier];
    
    //传递模型给cell
    cell.lsModel = lsModel;
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = [[UIView alloc] init];
    cell.selectedBackgroundView.frame = cell.frame;
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    return cell;
    
}

//Cell点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LSInfoController *vc = [[LSInfoController alloc] init];
    vc.ID = _array[indexPath.row][@"id"];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 220;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
