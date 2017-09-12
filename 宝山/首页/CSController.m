//
//  CSController.m
//  宝山
//
//  Created by 尤超 on 2017/5/9.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "CSController.h"
#import "YCHead.h"
#import "CSModel.h"
#import "CSCell.h"
#import "ZTController.h"

@interface CSController ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSMutableArray * _array;
    
}
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CSController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"常设展厅";
    
    _array = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    //注册表格单元
    [self.tableView registerClass:[CSCell class] forCellReuseIdentifier:csIndentifier];
    
    
    
    [self loadNewData];
}


-(void)loadNewData
{

    NSString * url = [NSString stringWithFormat:Main_URL,ZXList_URL];
    
    NSDictionary *dic = @{@"zl_type":@"1"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject[@"list"][@"result"]);
        
        _array = [responseObject[@"list"][@"result"] mutableCopy];
        
        [self.tableView reloadData];
     
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败: %@",error);
       
    }];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = _array[indexPath.row];
    
    
    CSModel *model = [CSModel csWithDict:dic];
    
  
    
    CSCell *cell = [tableView dequeueReusableCellWithIdentifier:csIndentifier];
    
    //传递模型给cell
    cell.csModel = model;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = [[UIView alloc] init];
    cell.selectedBackgroundView.frame = cell.frame;
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    return cell;
    
}

//Cell点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZTController *VC = [[ZTController alloc] init];
    VC.ID = _array[indexPath.row][@"id"];
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 225;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


