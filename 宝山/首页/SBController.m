//
//  SBController.m
//  宝山
//
//  Created by 尤超 on 2017/5/15.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "SBController.h"
#import "SB2Cell.h"
#import "SB2Model.h"
#import "YCHead.h"
#import "SBinfoController.h"

@interface SBController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    
    NSMutableArray * _array;
    
}

@property (nonatomic, strong) UICollectionView *collectionView;


@end

@implementation SBController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"设备";
    
    _array = [NSMutableArray array];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 设置collectionView的滚动方向，需要注意的是如果使用了collectionview的headerview或者footerview的话， 如果设置了水平滚动方向的话，那么就只有宽度起作用了了
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    // layout.minimumInteritemSpacing = 10;// 垂直方向的间距
    // layout.minimumLineSpacing = 10; // 水平方向的间距
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:self.collectionView];
    
    // 注册collectionViewcell:WWCollectionViewCell是我自定义的cell的类型
    [self.collectionView registerClass:[SB2Cell class] forCellWithReuseIdentifier:sb2Indentifier];
    
    NSString * url = [NSString stringWithFormat:Main_URL,SB2List_URL];
    
    NSDictionary *dic = @{@"id":self.ID};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject[@"data"]);
        
        _array = [responseObject[@"data"] mutableCopy];
        
        [self.collectionView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败: %@",error);
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UICollectionViewDataSource
/** 每组cell的个数*/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _array.count;
}

/** cell的内容*/
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = _array[indexPath.row];
    
    SB2Model *model = [SB2Model sb2WithDict:dic];
    
    SB2Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:sb2Indentifier forIndexPath:indexPath];
    
    cell.sb2Model = model;
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
    
}

#pragma mark -- UICollectionViewDelegateFlowLayout
/** 每个cell的尺寸*/
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(KSCREENWIDTH/2-10, 160);
}

/** section的margin*/
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 5, 5, 5);
}

#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SBinfoController *VC = [[SBinfoController alloc] init];
    VC.ID = _array[indexPath.row][@"id"];
    [self.navigationController pushViewController:VC animated:YES];
}



@end
