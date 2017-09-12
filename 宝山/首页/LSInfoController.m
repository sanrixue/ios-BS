//
//  LSInfoController.m
//  宝山
//
//  Created by 尤超 on 2017/5/22.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "LSInfoController.h"
#import "YCHead.h"

@interface LSInfoController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *web;

@end

@implementation LSInfoController

- (void)rightItemClick {
    DBManager *model = [[DBManager sharedManager] selectOneModel];
    NSMutableArray *mutArray = [NSMutableArray array];
    [mutArray addObject:model];
    UserModel *userModel = mutArray[0];
    
    
    NSString *url = [NSString stringWithFormat:Main_URL,AddCollection_URL];
    
    NSDictionary *dic = @{@"fkId":self.ID,
                          @"type":@"1",
                          @"uid":userModel.user_id};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
       
       
        [self showMessegeForResult:responseObject[@"msg"]];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"展厅详情";
    
    UIView *rightButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    UIButton *mainAndSearchBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [rightButtonView addSubview:mainAndSearchBtn];
    [mainAndSearchBtn setImage:[UIImage imageNamed:@"xin1"] forState:UIControlStateNormal];
    [mainAndSearchBtn addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightCunstomButtonView = [[UIBarButtonItem alloc] initWithCustomView:rightButtonView];
    self.navigationItem.rightBarButtonItem = rightCunstomButtonView;

    
    
    
    
    self.web = [[UIWebView alloc] init];
    self.web.frame = self.view.frame;
    self.web.delegate = self;
    [self.view addSubview:self.web];
    
    
 
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:Main_URL,[NSString stringWithFormat:Hdisplayed_URL,self.ID]]];
    [self.web loadRequest:[NSURLRequest requestWithURL:url]];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 输入提示错误提示
- (void)showMessegeForResult:(NSString *)messege
{
    if([[[UIDevice currentDevice] systemVersion] floatValue]>7.0)
    {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:messege preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:^
         {
             [self performSelector:@selector(dismissAlertViewEvent:) withObject:alert afterDelay:1];
         }];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:messege delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        [alert show];
    }
}

- (void)dismissAlertViewEvent:(id)alert
{
    if([alert isKindOfClass:[UIAlertController class]])
    {
        [alert dismissViewControllerAnimated:YES completion:^
         {
         }];
    }
    else
    {
        [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}



@end
