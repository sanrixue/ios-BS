//
//  NewsController.m
//  宝山
//
//  Created by 尤超 on 2017/5/4.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "NewsController.h"
#import "YCHead.h"
#import "NewsModel.h"
#import "NewsCell.h"
#import "NewsInfoController.h"

@interface NewsController ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSMutableArray * _array;
    
    int isPage;          //页数
    
}
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation NewsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"新闻资讯";
    
    _array = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    //注册表格单元
    [self.tableView registerClass:[NewsCell class] forCellReuseIdentifier:newsIndentifier];
    
    self.tableView.mj_footer =  [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(UpTableView)];
    
    self.tableView.mj_header =  [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    [self downTableView];
}

#pragma mark - ----------------------------------TableView上拉刷新下拉加载更多方法
- (void)downTableView
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJChiBaoZiHeader *header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
//    // 隐藏状态
//    header.stateLabel.hidden = YES;
    
    // 设置文字
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"准备刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"加载 . . . " forState:MJRefreshStateRefreshing];

    
    // 马上进入刷新状态
    [header beginRefreshing];
    
    // 设置header
    self.tableView.mj_header = header;
    
}

-(void)loadNewData
{
    //如果是下拉刷新，page为1
    isPage = 1;
        
    NSString * url = [NSString stringWithFormat:Main_URL,News_URL];
    
    NSDictionary *dic = @{@"page":[NSString stringWithFormat:@"%d",isPage]};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject[@"data"][@"result"]);
        
        _array = [responseObject[@"data"][@"result"] mutableCopy];
        
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer resetNoMoreData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败: %@",error);
        [self.tableView.mj_header endRefreshing];
    }];
    
}

//上拉加载更多
- (void)UpTableView
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    self.tableView.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
   
    // 马上进入刷新状态
    [self.tableView.mj_footer beginRefreshing];
    

}

-(void)loadMoreData
{
    isPage++;
 
    NSString * url = [NSString stringWithFormat:Main_URL,News_URL];
    
    NSDictionary *dic = @{@"page":[NSString stringWithFormat:@"%d",isPage]};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray * ary = responseObject[@"data"][@"result"];
        
        NSLog(@"!!!!!!%@",responseObject[@"data"][@"result"]);
        
        if (ary.count == 0)
        {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
           
        }
        else
        {
            [_array addObjectsFromArray:responseObject[@"data"][@"result"]];
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败: %@",error);
        [self.tableView.mj_footer endRefreshing];
    }];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = _array[indexPath.row];
    
    
    NewsModel *model = [NewsModel newsWithDict:dic];
    
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:newsIndentifier];
    
    //传递模型给cell
    cell.newsModel = model;
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = [[UIView alloc] init];
    cell.selectedBackgroundView.frame = cell.frame;
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    return cell;
    
}

//Cell点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsInfoController *VC = [[NewsInfoController alloc] init];
    VC.ID = _array[indexPath.row][@"id"];
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

