//
//  SearchController.m
//  宝山
//
//  Created by 尤超 on 17/4/12.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "SearchController.h"
#import "YCHead.h"
#import "NewsCell.h"
#import "NewsModel.h"
#import "NewsInfoController.h"
#import "LSCell.h"
#import "LSModel.h"
#import "LSInfoController.h"
#import "PostCell.h"
#import "PostModel.h"
#import "PostInfoController.h"
#import "ActivityCell.h"
#import "ActivityModel.h"
#import "ActivityInfoController.h"
#import "AudioCell.h"
#import "AudioModel.h"
#import "AudioPlayerController.h"



@interface SearchController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UITextFieldDelegate>{
    
    int isPage;          //页数
    
    NSString *_types; //类型
    
    NSMutableArray * Post_ary;   //存放请求出来的参数
    
    UILabel *_label;
    
}

@property(nonatomic,strong)UITableView * article_tableview;

@property(nonatomic,strong)UIButton * Search_button;       //确认搜索按钮

@property (nonatomic,strong)UISearchBar * sear_bar;       //搜索框

@property (nonatomic, strong) NSMutableArray *songArray;

@end

@implementation SearchController


- (NSMutableArray *)songArray
{
    if (!_songArray) {
        _songArray = [NSMutableArray array];
    }
    return _songArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"搜索";
    
    Post_ary = [NSMutableArray array];
    
#pragma mark - tableview
    _article_tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 140, KSCREENWIDTH, KSCREENHEIGHT-140) style:UITableViewStylePlain];
    _article_tableview.delegate = self;
    _article_tableview.dataSource = self;
    _article_tableview.tableFooterView = [UIView new];
    _article_tableview.separatorStyle = NO;
    _article_tableview.backgroundColor = [UIColor clearColor];
    [_article_tableview setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    [_article_tableview setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    
    //注册表格单元
    [_article_tableview registerClass:[NewsCell class] forCellReuseIdentifier:newsIndentifier];
    
    [_article_tableview registerClass:[LSCell class] forCellReuseIdentifier:lsIndentifier];
    
    [_article_tableview registerClass:[PostCell class] forCellReuseIdentifier:postIndentifier];
    
    [_article_tableview registerClass:[ActivityCell class] forCellReuseIdentifier:activityIndentifier];
    
    [_article_tableview registerClass:[AudioCell class] forCellReuseIdentifier:audioIndentifier];
    
    [self.view addSubview:_article_tableview];

    
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 50, 30)];
    _label.text = @"新闻";
    _label.textColor = [UIColor grayColor];
    [self.view addSubview:_label];
    
    
    UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 130, KSCREENWIDTH, 60)];
    back.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:back];
    
    
    _types = [NSString string];
    
    [self addBtnName:@"新闻" Icon:@"Cicon5" Frame:CGRectMake(0, 130, KSCREENWIDTH/5, 60) Tag:1];
    [self addBtnName:@"帖子" Icon:@"Cicon1" Frame:CGRectMake(KSCREENWIDTH/5, 130, KSCREENWIDTH/5, 60) Tag:2];
    [self addBtnName:@"展厅" Icon:@"Cicon2" Frame:CGRectMake(2*KSCREENWIDTH/5, 130, KSCREENWIDTH/5, 60) Tag:3];
    [self addBtnName:@"活动" Icon:@"Cicon3" Frame:CGRectMake(3*KSCREENWIDTH/5, 130, KSCREENWIDTH/5, 60) Tag:4];
    [self addBtnName:@"导览" Icon:@"Cicon4" Frame:CGRectMake(4*KSCREENWIDTH/5, 130, KSCREENWIDTH/5, 60) Tag:5];
    
    [self search_Bar];

}

- (void)addBtnName:(NSString *)name Icon:(NSString *)icon Frame:(CGRect)frame Tag:(NSInteger)tag {
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    [btn setTitle:name forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"S%@",icon]] forState:UIControlStateHighlighted];
    [btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:0];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = tag;
    [self.view addSubview:btn];
}

- (void)btnClick:(UIButton *)btn {
    if (btn.tag == 1) {
        _label.text = @"新闻";
    } else if (btn.tag == 2) {
        _label.text = @"帖子";
    } else if (btn.tag == 3) {
        _label.text = @"展厅";
    } else if (btn.tag == 4) {
        _label.text = @"活动";
    } else if (btn.tag == 5) {
        _label.text = @"导览";
    }
}


- (UISearchBar *)search_Bar{
    if (_sear_bar == nil){
        _sear_bar = [[UISearchBar alloc]initWithFrame:CGRectMake(60, 70, KSCREENWIDTH-60, 50)];
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
    
    
    if ([_label.text isEqualToString:@"新闻"]) {
        _types = @"2";
    } else if ([_label.text isEqualToString:@"帖子"]) {
        _types = @"3";
    } else if ([_label.text isEqualToString:@"展厅"]) {
        _types = @"1";
    } else if ([_label.text isEqualToString:@"活动"]) {
        _types = @"4";
    } else if ([_label.text isEqualToString:@"导览"]) {
        _types = @"5";
    }
    
    
    NSDictionary * post_dic = @{@"page":page,@"types":_types,@"keyWord":_sear_bar.text};  //参数
    
    NSString * url = [NSString stringWithFormat:Main_URL,SearchList_URL]; //接口
    
    NSLog(@"~~~~~%@",post_dic);
    
    [AFNetwork POST:url parameters:post_dic success:^(id  _Nonnull json) {
        Post_ary = [json[@"data"] mutableCopy];  //拿到请求数据
        
        NSLog(@"~~~~~~~~~~~~~~~~~%@",json[@"data"]);
        
        if (Post_ary.count > 0) {
            [_article_tableview reloadData];
            
            if ([_types isEqualToString:@"5"]) {
                for (NSDictionary *dic in Post_ary) {
                    MusicModel *model = [[MusicModel alloc] init];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.songArray addObject:model];
                    
                }
            }
    
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"不存在，请重新查询" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
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
    
    if ([_label.text isEqualToString:@"新闻"]) {
        _types = @"2";
    } else if ([_label.text isEqualToString:@"帖子"]) {
        _types = @"3";
    } else if ([_label.text isEqualToString:@"展厅"]) {
        _types = @"1";
    } else if ([_label.text isEqualToString:@"活动"]) {
        _types = @"4";
    } else if ([_label.text isEqualToString:@"导览"]) {
        _types = @"5";
    }
    
    
    NSDictionary * post_dic = @{@"page":page,@"types":_types,@"keyWord":_sear_bar.text};  //参数
    NSString * url = [NSString stringWithFormat:Main_URL,SearchList_URL]; //接口
    
    
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return Post_ary.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_label.text isEqualToString:@"新闻"]) {
        return 100;
        
    } else if ([_label.text isEqualToString:@"帖子"]) {
        NSDictionary *dic = Post_ary[indexPath.row];
        
        PostModel *model = [PostModel postWithDict:dic];
        
        if ([[NSString stringWithFormat:@"%@",model.image] isEqualToString:@"<null>"]) {
            
            
            return 418-180;
        } else {
            
            
            return 418;
        }

    } else if ([_label.text isEqualToString:@"展厅"]) {
        return 220;
        
    } else if ([_label.text isEqualToString:@"活动"]) {
        return 100;
        
    } else if ([_label.text isEqualToString:@"导览"]) {
        return 250;
        
    } else {
        return 420;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    NSDictionary * dic = Post_ary[indexPath.row];
    
    
    if ([_label.text isEqualToString:@"新闻"]) {
        NewsModel *model = [NewsModel newsWithDict:dic];
        
        
        
        NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:newsIndentifier];
        
        //传递模型给cell
        cell.newsModel = model;
        
        cell.backgroundColor = [UIColor clearColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
        cell.selectedBackgroundView.frame = cell.frame;
        cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        
        return cell;

    } else if ([_label.text isEqualToString:@"帖子"]) {
        PostModel *model = [PostModel postWithDict:dic];
        
        
        
        PostCell *cell = [tableView dequeueReusableCellWithIdentifier:postIndentifier];
        
        //传递模型给cell
        cell.postModel = model;
        
        cell.backgroundColor = [UIColor clearColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
        cell.selectedBackgroundView.frame = cell.frame;
        cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        
        return cell;

    } else if ([_label.text isEqualToString:@"展厅"]) {
        LSModel *model = [LSModel lsWithDict:dic];
        
        LSCell *cell = [tableView dequeueReusableCellWithIdentifier:lsIndentifier];
        
        //传递模型给cell
        cell.lsModel = model;
        
        cell.backgroundColor = [UIColor clearColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
        cell.selectedBackgroundView.frame = cell.frame;
        cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        
        return cell;

    } else if ([_label.text isEqualToString:@"活动"]) {
        ActivityModel *model = [ActivityModel activityWithDict:dic];
        
        
        
        ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:activityIndentifier];
        
        //传递模型给cell
        cell.activityModel = model;
        
        cell.backgroundColor = [UIColor clearColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
        cell.selectedBackgroundView.frame = cell.frame;
        cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        
        return cell;

    } else if ([_label.text isEqualToString:@"导览"]) {
        AudioModel *model = [AudioModel audioWithDict:dic];
        
        
        
        AudioCell *cell = [tableView dequeueReusableCellWithIdentifier:audioIndentifier];
        
        //传递模型给cell
        cell.audioModel = model;
        
        cell.backgroundColor = [UIColor clearColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
        cell.selectedBackgroundView.frame = cell.frame;
        cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        
        return cell;

    } else {
        return nil;
    }
    
}

//TouchTableview点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    
    if ([_label.text isEqualToString:@"新闻"]) {
        NewsInfoController *VC = [[NewsInfoController alloc] init];
        VC.ID = Post_ary[indexPath.row][@"id"];
        [self.navigationController pushViewController:VC animated:YES];
        
    } else if ([_label.text isEqualToString:@"帖子"]) {
        PostInfoController *VC = [[PostInfoController alloc] init];
        VC.ID = Post_ary[indexPath.row][@"id"];
        [self.navigationController pushViewController:VC animated:YES];
        
    } else if ([_label.text isEqualToString:@"展厅"]) {
        LSInfoController *vc = [[LSInfoController alloc] init];
        vc.ID = Post_ary[indexPath.row][@"id"];
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if ([_label.text isEqualToString:@"活动"]) {
        ActivityInfoController *VC = [[ActivityInfoController alloc] init];
        VC.ID = Post_ary[indexPath.row][@"id"];
        VC.state = [NSString stringWithFormat:@"%@",Post_ary[indexPath.row][@"state"]];
        VC.type = [NSString stringWithFormat:@"%@",Post_ary[indexPath.row][@"type"]];
        [self.navigationController pushViewController:VC animated:YES];
        
    } else if ([_label.text isEqualToString:@"导览"]) {
        AudioPlayerController *audio = [AudioPlayerController audioPlayerController];
        [audio initWithArray:self.songArray index:indexPath.row];
        [self.navigationController pushViewController:audio animated:YES];
    }
    
    
    
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
