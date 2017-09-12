//
//  MyPostController.m
//  宝山
//
//  Created by 尤超 on 17/5/2.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "MyPostController.h"
#import "YCHead.h"
#import "MyPostModel.h"
#import "MyPostCell.h"
#import "YMShowImageView.h"
#import "AddPostController.h"
#import "PostInfoController.h"

@interface MyPostController ()<UITableViewDelegate,UITableViewDataSource,cellDelegate>{
    
    NSMutableArray * _array;
    
    NSArray *_high;
    
}
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MyPostController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的发布";
    
    
    UIView *rightButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    UIButton *mainAndSearchBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [rightButtonView addSubview:mainAndSearchBtn];
    [mainAndSearchBtn setImage:[UIImage imageNamed:@"post"] forState:UIControlStateNormal];
    [mainAndSearchBtn addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightCunstomButtonView = [[UIBarButtonItem alloc] initWithCustomView:rightButtonView];
    self.navigationItem.rightBarButtonItem = rightCunstomButtonView;
    
    
    _array = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    //注册表格单元
    [self.tableView registerClass:[MyPostCell class] forCellReuseIdentifier:postIndentifier];
    
    
    DBManager *model = [[DBManager sharedManager] selectOneModel];
    NSMutableArray *mutArray = [NSMutableArray array];
    [mutArray addObject:model];
    UserModel *userModel = mutArray[0];

    NSString *url = [NSString stringWithFormat:Main_URL,PostList_URL];

    NSLog(@"%@",url);

    NSDictionary *dic = @{@"uid":userModel.user_id,
                          @"page":@"1"};

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {


        _array = [responseObject[@"data"] mutableCopy];

        [self.tableView reloadData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
    
    
    _high = [NSArray array];
}

- (void)rightItemClick {
    AddPostController *VC = [[AddPostController alloc] init];
    
    [self.navigationController pushViewController:VC animated:YES];
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
    PostInfoController *vc = [[PostInfoController alloc] init];
    vc.ID = _array[indexPath.row][@"id"];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = _array[indexPath.row];
    
    MyPostModel *model = [MyPostModel postWithDict:dic];
    
    
    UILabel *lab = [[UILabel alloc] init];
    lab.text = model.context;
    lab.numberOfLines = 0;
    lab.font = [UIFont systemFontOfSize:13];
    lab.lineBreakMode = NSLineBreakByTruncatingTail;
    
    CGSize maximumLabelSize = CGSizeMake(KSCREENWIDTH-60, 9999);//labelsize的最大值
    
    //关键语句
    CGSize textSize = [lab sizeThatFits:maximumLabelSize];

    NSLog(@"%f",textSize.height);
    
    if ([[NSString stringWithFormat:@"%@",model.images] isEqualToString:@"<null>"]) {
        _high = nil;
        
        return textSize.height + 65;
    } else {
        _high = [model.images componentsSeparatedByString:@","]; //从字符,中分隔成N个元素的数组
        
        return 65 + textSize.height + (([_high count]/3) + 1) * (10+80) ;
    }
   
   
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
