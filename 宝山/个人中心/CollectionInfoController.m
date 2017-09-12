//
//  CollectionInfoController.m
//  宝山
//
//  Created by 尤超 on 2017/5/25.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "CollectionInfoController.h"
#import "YCHead.h"
#import "NewsCell.h"
#import "NewsModel.h"
#import "NewsInfoController.h"
#import "CExhibitionModel.h"
#import "CExhibitionCell.h"
#import "LSInfoController.h"
#import "CPostCell.h"
#import "PostModel.h"
#import "PostInfoController.h"
#import "CActivityModel.h"
#import "CActivityCell.h"
#import "ActivityInfoController.h"
#import "AudioCell.h"
#import "AudioModel.h"
#import "AudioPlayerController.h"



@interface CollectionInfoController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>{
    
    int isPage;     //页数
    
    NSMutableArray * Post_ary;   //存放请求出来的参数
    
    
}

@property(nonatomic,strong)UITableView * article_tableview;

@property (nonatomic, strong) NSMutableArray *songArray;

@end

@implementation CollectionInfoController


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
    self.navigationItem.title = @"收藏列表";
    
    Post_ary = [NSMutableArray array];
    
#pragma mark - tableview
    _article_tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT) style:UITableViewStylePlain];
    _article_tableview.delegate = self;
    _article_tableview.dataSource = self;
    _article_tableview.tableFooterView = [UIView new];
    _article_tableview.separatorStyle = NO;
    _article_tableview.backgroundColor = [UIColor clearColor];
    [_article_tableview setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    [_article_tableview setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    
    //注册表格单元
    [_article_tableview registerClass:[NewsCell class] forCellReuseIdentifier:newsIndentifier];
    
    [_article_tableview registerClass:[CExhibitionCell class] forCellReuseIdentifier:CExhibitionIndentifier];
    
    [_article_tableview registerClass:[CPostCell class] forCellReuseIdentifier:cpostIndentifier];
    
    [_article_tableview registerClass:[CActivityCell class] forCellReuseIdentifier:CActivityIndentifier];
    
    [_article_tableview registerClass:[AudioCell class] forCellReuseIdentifier:audioIndentifier];
    
    [self.view addSubview:_article_tableview];
    

    
    DBManager *model = [[DBManager sharedManager] selectOneModel];
    NSMutableArray *mutArray = [NSMutableArray array];
    [mutArray addObject:model];
    UserModel *userModel = mutArray[0];
    
    
    isPage = 1;  //页数

    NSString *url = [NSString stringWithFormat:Main_URL,[NSString stringWithFormat:CollectionList_URL,userModel.user_id,self.type,isPage]];
    
    NSLog(@"~~~~~%@",url);
    
    [AFNetwork POST:url parameters:nil success:^(id  _Nonnull json) {
        Post_ary = [json[@"data"] mutableCopy];  //拿到请求数据
        
        NSLog(@"~~~~~~~~~~~~~~~~~%@",json);
        
        if (Post_ary.count > 0) {
            [_article_tableview reloadData];
            
            if ([self.type isEqualToString:@"5"]) {
                for (NSDictionary *dic in Post_ary) {
                    MusicModel *model = [[MusicModel alloc] init];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.songArray addObject:model];
                    
                }
            }
            
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"暂无收藏" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败---->>>%@",error);
        
    }];

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
    DBManager *model = [[DBManager sharedManager] selectOneModel];
    NSMutableArray *mutArray = [NSMutableArray array];
    [mutArray addObject:model];
    UserModel *userModel = mutArray[0];
    
    isPage++;  //页数++
    
    NSString *url = [NSString stringWithFormat:Main_URL,[NSString stringWithFormat:CollectionList_URL,userModel.user_id,self.type,isPage]];
    
    NSLog(@"~~~~~%@",url);
    
    
    [AFNetwork POST:url parameters:nil success:^(id  _Nonnull json) {
        
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
    if ([self.type isEqualToString:@"4"]) {
        return 100;
        
    } else if ([self.type isEqualToString:@"3"]) {
        NSDictionary *dic = Post_ary[indexPath.row];
        
        PostModel *model = [PostModel postWithDict:dic];
        
        UILabel *lab = [[UILabel alloc] init];
        lab.text = model.content;
        lab.numberOfLines = 0;
        lab.font = [UIFont systemFontOfSize:14];
        lab.lineBreakMode = NSLineBreakByTruncatingTail;
        
        CGSize maximumLabelSize = CGSizeMake(KSCREENWIDTH-60, 9999);//labelsize的最大值
        
        //关键语句
        CGSize textSize = [lab sizeThatFits:maximumLabelSize];
        
        if ([[NSString stringWithFormat:@"%@",model.image] isEqualToString:@"<null>"]) {
            
            
            return 370+textSize.height-180-2;
        } else {
            
            
            return 370+textSize.height-2;
        }
        
    } else if ([self.type isEqualToString:@"1"]) {
        return 125;
        
    } else if ([self.type isEqualToString:@"2"]) {
        return 105;
        
    } else if ([self.type isEqualToString:@"5"]) {
        return 250;
        
    } else {
        return 0;
    }
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary * dic = Post_ary[indexPath.row];
    
    
    if ([self.type isEqualToString:@"4"]) {
        NewsModel *model = [NewsModel newsWithDict:dic];
        
        
        
        NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:newsIndentifier];
        
        //传递模型给cell
        cell.newsModel = model;
        
        cell.backgroundColor = [UIColor clearColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
        cell.selectedBackgroundView.frame = cell.frame;
        cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        
        return cell;
        
    } else if ([self.type isEqualToString:@"3"]) {
        PostModel *model = [PostModel postWithDict:dic];
        
        
        
        CPostCell *cell = [tableView dequeueReusableCellWithIdentifier:cpostIndentifier];
        
        //传递模型给cell
        cell.postModel = model;
        
        cell.backgroundColor = [UIColor clearColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
        cell.selectedBackgroundView.frame = cell.frame;
        cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        
        return cell;
        
    } else if ([self.type isEqualToString:@"1"]) {
        CExhibitionModel *model = [CExhibitionModel CExhibitionWithDict:dic];
        
        CExhibitionCell *cell = [tableView dequeueReusableCellWithIdentifier:CExhibitionIndentifier];
        
        //传递模型给cell
        cell.CExhibitionModel = model;

        
        cell.backgroundColor = [UIColor clearColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
        cell.selectedBackgroundView.frame = cell.frame;
        cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        
        return cell;
        
    } else if ([self.type isEqualToString:@"2"]) {
        CActivityModel *model = [CActivityModel CActivityWithDict:dic];
        
        CActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:CActivityIndentifier];
        
        //传递模型给cell
        cell.CActivityModel = model;
        
        cell.backgroundColor = [UIColor clearColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
        cell.selectedBackgroundView.frame = cell.frame;
        cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        
        return cell;
        
    } else if ([self.type isEqualToString:@"5"]) {
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
    
    
    
    if ([self.type isEqualToString:@"4"]) {
        NewsInfoController *VC = [[NewsInfoController alloc] init];
        VC.ID = Post_ary[indexPath.row][@"fk_id"];
        [self.navigationController pushViewController:VC animated:YES];
        
    } else if ([self.type isEqualToString:@"3"]) {
        PostInfoController *VC = [[PostInfoController alloc] init];
        VC.ID = Post_ary[indexPath.row][@"id"];
        [self.navigationController pushViewController:VC animated:YES];
        
    } else if ([self.type isEqualToString:@"1"]) {
        LSInfoController *vc = [[LSInfoController alloc] init];
        vc.ID = Post_ary[indexPath.row][@"fk_id"];
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if ([self.type isEqualToString:@"2"]) {
        ActivityInfoController *VC = [[ActivityInfoController alloc] init];
        VC.ID = Post_ary[indexPath.row][@"fk_id"];
        VC.state = [NSString stringWithFormat:@"%@",Post_ary[indexPath.row][@"astate"]];
        VC.type = [NSString stringWithFormat:@"%@",Post_ary[indexPath.row][@"atype"]];
        [self.navigationController pushViewController:VC animated:YES];
        
    } else if ([self.type isEqualToString:@"5"]) {
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

@end
