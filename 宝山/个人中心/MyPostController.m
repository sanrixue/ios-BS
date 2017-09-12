//
//  MyPostController.m
//  WX
//
//  Created by 尤超 on 2017/5/2.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "MyPostController.h"
#import "YCHead.h"
#import "MyPostModel.h"
#import "MyPostCell.h"
#import "YMShowImageView.h"

@interface MyPostController ()<UITableViewDelegate,UITableViewDataSource,cellDelegate>{
    
    NSMutableArray * _array;
    
}
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MyPostController

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
    
    //注册表格单元
    [self.tableView registerClass:[MyPostCell class] forCellReuseIdentifier:postIndentifier];
    
    
    //    DBManager *model = [[DBManager sharedManager] selectOneModel];
    //    NSMutableArray *mutArray = [NSMutableArray array];
    //    [mutArray addObject:model];
    //    UserModel *userModel = mutArray[0];
    //
    //    NSString *url = [NSString stringWithFormat:Main_URL,[NSString stringWithFormat:Message_URL,userModel.user_id,1]];
    //
    //    NSLog(@"%@",url);
    //
    //    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //
    //    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    //
    //    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    //
    //
    //        _array = [responseObject[@"data"] mutableCopy];
    //
    //        [self.tableView reloadData];
    //
    //    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    //
    //    }];
    
    
    
    NSDictionary *dic = @{@"icon":@"1.png",
                          @"title":@"城市客厅",
                          @"context":@"城市客厅已有2000人参与城市客厅已有2000人参与城市客厅已有2000人参与城市客厅已有2000人参与城市客厅已有2000人参与城市客厅已有2000人参与城市客厅已有2000人参与城市客厅已有2000人参与城市客厅已有2000人参与城市客厅已有2000人参与城市客厅已有2000人参与",
                          @"time":@"2017-10-5",
                          @"images":@"1.png,2.png,3.png,4.png"
                          };
    
    NSDictionary *dic2 = @{@"icon":@"1.png",
                          @"title":@"城市客厅",
                          @"context":@"城市客厅已有2000人参与城市客厅已有2000人参与城市客厅已有2000人参与城市客厅已有2000人参与城市客厅已有2000人参与城市客厅已有2000人参与城市客厅已有2000人参与城市客厅已有2000人参与城市客厅已有2000人参与城市客厅已有2000人参与城市客厅已有2000人参与",
                          @"time":@"2017-10-5",
                          @"images":@"1.png,2.png"
                          };
    
   
    [_array addObject:dic];
  
    [_array addObject:dic2];
    
    [_array addObject:dic];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = _array[indexPath.row];
    
    
    MyPostModel *model = [MyPostModel postWithDict:dic];
    
    MyPostCell *cell = [tableView dequeueReusableCellWithIdentifier:postIndentifier];
    
    //传递模型给cell
    cell.myPostModel = model;
    cell.delegate = self;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = [[UIView alloc] init];
    cell.selectedBackgroundView.frame = cell.frame;
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    return cell;
    
}

//Cell点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = _array[indexPath.row];
    
    MyPostModel *model = [MyPostModel postWithDict:dic];

    MyPostCell *cell = [tableView dequeueReusableCellWithIdentifier:postIndentifier];
    
    //传递模型给cell
    cell.myPostModel = model;
    
    return cell.high;
    
}

#pragma mark - 图片点击事件回调
- (void)showImageViewWithImageViews:(NSArray *)imageViews byClickWhich:(NSInteger)clickTag{
    
    UIView *maskview = [[UIView alloc] initWithFrame:self.view.bounds];
    maskview.backgroundColor = [UIColor blackColor];
    [self.view addSubview:maskview];
    
    YMShowImageView *ymImageV = [[YMShowImageView alloc] initWithFrame:self.view.bounds byClick:clickTag appendArray:imageViews];
    [ymImageV show:maskview didFinish:^(){
        
        [UIView animateWithDuration:0.5f animations:^{
            
            ymImageV.alpha = 0.0f;
            maskview.alpha = 0.0f;
            
        } completion:^(BOOL finished) {
            
            [ymImageV removeFromSuperview];
            [maskview removeFromSuperview];
        }];
        
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
