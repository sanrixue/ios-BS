//
//  MyEXController.m
//  宝山
//
//  Created by 尤超 on 2017/5/2.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "MyEXController.h"
#import "YCHead.h"
#import "MyEXCell.h"
#import "MyEXModel.h"
#import "LSInfoController.h"

@interface MyEXController ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSMutableArray * _array;
    
}
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MyEXController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的展项";
    _array = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    //注册表格单元
    [self.tableView registerClass:[MyEXCell class] forCellReuseIdentifier:myEXIndentifier];
    
    
    DBManager *model = [[DBManager sharedManager] selectOneModel];
    NSMutableArray *mutArray = [NSMutableArray array];
    [mutArray addObject:model];
    UserModel *userModel = mutArray[0];
    
    NSString *url = [NSString stringWithFormat:Main_URL,EXList_URL];
    
    
    NSDictionary *dic = @{@"uid":userModel.user_id,
                          @"page":@"1"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
       
        
        _array = [responseObject[@"data"][@"result"] mutableCopy];
        
        
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = _array[indexPath.row];
    
    
    MyEXModel *model = [MyEXModel myEXWithDict:dic];
    
    MyEXCell *cell = [tableView dequeueReusableCellWithIdentifier:myEXIndentifier];
    
    //传递模型给cell
    cell.myEXModel = model;
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = [[UIView alloc] init];
    cell.selectedBackgroundView.frame = cell.frame;
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    return cell;
    
}

//Cell点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LSInfoController *vc = [[LSInfoController alloc] init];
    vc.ID = _array[indexPath.row][@"exhibitionId"];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
