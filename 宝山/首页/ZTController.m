//
//  ZTController.m
//  宝山
//
//  Created by 尤超 on 2017/5/9.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "ZTController.h"
#import "ZTCell.h"
#import "ZTModel.h"
#import "YCHead.h"
#import "ZTLayout.h"
#import "ZTInfoController.h"

@interface ZTController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    
    NSMutableArray *_array;
}

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ZTController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"展厅信息";
    
    UIImageView *back = [[UIImageView alloc] init];
    back.frame = self.view.frame;
    back.image = [UIImage imageNamed:@"ZTback.png"];
    [self.view addSubview:back];
    
    
    
    ZTLayout *layout = [[ZTLayout alloc]init];
    
    layout.itemSize = CGSizeMake(230, 350);
    
    // 创建collection 设置尺寸
    CGFloat collectionW = self.view.frame.size.width;
    CGFloat collectionH = self.view.frame.size.height;
    CGFloat collectionX = 0;
    CGFloat collectionY = 25;
    
    CGRect frame = CGRectMake(collectionX, collectionY, collectionW, collectionH);
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self.view addSubview:collectionView];
    
    // 注册cell
    [collectionView registerClass:[ZTCell class] forCellWithReuseIdentifier:ztIndentifier];
    
    self.collectionView = collectionView;
    
    _array = [NSMutableArray array];
    
    
    NSString * url = [NSString stringWithFormat:Main_URL,ZTList_URL];
    
    NSDictionary *dic = @{@"id":self.ID};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject[@"list"]);
        
        _array = [responseObject[@"list"] mutableCopy];
        
        [self.collectionView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败: %@",error);
        
    }];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = _array[indexPath.row];
    
    ZTModel *model = [ZTModel ztWithDict:dic];
    
    
    ZTCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ztIndentifier forIndexPath:indexPath];
    
    cell.ztModel = model;
    cell.backgroundColor = [UIColor whiteColor];
   
    
    return cell;
}

-( void )collectionView:( UICollectionView *)collectionView didSelectItemAtIndexPath:( NSIndexPath *)indexPath{
    
    ZTInfoController *VC = [[ZTInfoController alloc] init];
    VC.ID = _array[indexPath.row][@"id"];
    [self.navigationController pushViewController:VC animated:YES];
    
}

@end

