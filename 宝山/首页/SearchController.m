

//
//  SearchController.m
//  掌上植物
//
//  Created by 尤超 on 16/9/22.
//  Copyright © 2016年 尤超. All rights reserved.
//

#import "SearchController.h"
#import "YCHead.h"
#import "HomeCell.h"
#import "HomeModel.h"
#import "HomeInfoController.h"

@interface SearchController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UITextFieldDelegate>{
    
    int isPage;          //页数
    NSMutableArray * Post_ary;   //存放请求出来的参数
    
}

@property(nonatomic,strong)UITableView * article_tableview;

@property(nonatomic,strong)UIButton * Search_button;       //确认搜索按钮

@property (nonatomic,strong)UISearchBar * sear_bar;       //搜索框

@end

@implementation SearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"搜索";
    
    Post_ary = [NSMutableArray array];
    
#pragma mark - tableview
    _article_tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, KSCREENWIDTH, KSCREENHEIGHT-KNagHEIGHT) style:UITableViewStylePlain];
    _article_tableview.delegate = self;
    _article_tableview.dataSource = self;
    _article_tableview.tableFooterView = [UIView new];
    _article_tableview.separatorStyle = NO;
    _article_tableview.backgroundColor = [UIColor clearColor];
    [_article_tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    //注册表格单元
    [_article_tableview registerClass:[HomeCell class] forCellReuseIdentifier:homeIndentifier];
    
    [self.view addSubview:_article_tableview];

    
    
    [self search_Bar];

}

- (UISearchBar *)search_Bar{
    if (_sear_bar == nil){
        _sear_bar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 70, KSCREENWIDTH, 50)];
        _sear_bar.showsCancelButton = YES;
        _sear_bar.delegate = self;
        for (id obj in [_sear_bar subviews]) {
            if ([obj isKindOfClass:[UIView class]]) {
                for (id obj2 in [obj subviews]) {
                    if ([obj2 isKindOfClass:[UIButton class]]) {
                        UIButton *btn = (UIButton *)obj2;
                        [btn setTitle:@"取消" forState:UIControlStateNormal];
                        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
                        
                    }
                    if ([obj2 isKindOfClass:NSClassFromString(@"UISearchBarBackground")])
                    {
                        [obj2 removeFromSuperview];
                        
                    }
                    if ([obj2 isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
                        UITextField *text = (UITextField *)obj2;
                        text.layer.borderColor = [UIColor lightGrayColor].CGColor;
                        text.layer.borderWidth = 1;
                        text.layer.masksToBounds = YES;
                        text.layer.cornerRadius = 10;
                    }
                    if([obj2 conformsToProtocol:@protocol(UITextInputTraits)]) {
                        //改变搜索按钮名称
                        [(UITextField *)obj2 setReturnKeyType: UIReturnKeyDone];
                    } else {
                        for(UIView *subSubView in [obj2 subviews]) {
                            if([subSubView conformsToProtocol:@protocol(UITextInputTraits)]) {
                                [(UITextField *)subSubView setReturnKeyType: UIReturnKeyDone];
                            }
                        }
                    }
                    
                }
            }
        }
        
        [self.view addSubview:_sear_bar];
    }
    return _sear_bar;
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    searchBar.text = @"";
}

#pragma mark - 点击键盘Search按钮调用
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    isPage = 1;  //页数
    NSString * page = [NSString stringWithFormat:@"%d",isPage];  //页数转字符串
    NSDictionary * post_dic = @{@"page":page,@"type":@"2",@"name":_sear_bar.text};  //参数
    NSString * url = [NSString stringWithFormat:Main_URL,Search_Url]; //接口
    
    [AFNetwork POST:url parameters:post_dic success:^(id  _Nonnull json) {
        Post_ary = [json[@"data"] mutableCopy];  //拿到请求数据
        
        NSLog(@"~~~~~~~~~~~~~~~~~%@",Post_ary);
        
        if (Post_ary.count > 0) {
            [_article_tableview reloadData];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"文章不存在，请重新查询" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
            
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败---->>>%@",error);

    }];
    
    [searchBar resignFirstResponder];
}

#pragma mark - ------------TableView上拉加载更多的方法
- (void)UpTableView
{
    
    // 添加默认的上拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    //    // 设置文字
    //    [footer setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
    //    [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    //    [footer setTitle:@"已经全部加载" forState:MJRefreshStateNoMoreData];
    //
    //    // 设置字体
    //    footer.stateLabel.font = [UIFont systemFontOfSize:17];
    //
    //    // 设置颜色
    //    footer.stateLabel.textColor = [UIColor grayColor];
    
    [footer beginRefreshing];
    // 设置footer
    _article_tableview.mj_footer = footer;
    
    
    
    
}
-(void)loadMoreData
{
    isPage++;  //页数++
    NSString * page = [NSString stringWithFormat:@"%d",isPage];  //页数转字符串
    NSDictionary * post_dic = @{@"page":page,@"type":@"2",@"name":_sear_bar.text};  //参数
    NSString * url = [NSString stringWithFormat:Main_URL,Search_Url];
    
    
    [AFNetwork POST:url parameters:post_dic success:^(id  _Nonnull json) {
        
        NSArray * ary = json[@"data"];
        if (ary.count<20)
        {
            [_article_tableview.mj_footer endRefreshingWithNoMoreData];
        }
        else
        {
            [Post_ary addObjectsFromArray:json[@"data"]];   //把上拉的图片添加到数组中
            [_article_tableview reloadData];
            [_article_tableview.mj_footer endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败---->>>%@",error);
        [_article_tableview.mj_footer endRefreshing];
        
    }];

}


#pragma mark -  ------------Tableview数据源方法-------------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return Post_ary.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 226;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    NSDictionary * dic = Post_ary[indexPath.row];
    
    HomeModel *homeModel = [HomeModel homeWithDict:dic];
    
    
    
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:homeIndentifier];
    
    //传递模型给cell
    cell.homeModel = homeModel;
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = [[UIView alloc] init];
    cell.selectedBackgroundView.frame = cell.frame;
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    return cell;

    
}

//TouchTableview点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeInfoController *homeinfo = [[HomeInfoController alloc] init];
    
    [self.navigationController pushViewController:homeinfo animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
