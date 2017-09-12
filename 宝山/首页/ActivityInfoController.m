
//
//  ActivityInfoController.m
//  宝山
//
//  Created by 尤超 on 2017/5/22.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "ActivityInfoController.h"
#import "YCHead.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "ApplyController.h"


@interface ActivityInfoController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *web;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, weak) JSContext *context;

@end

@implementation ActivityInfoController


- (void)rightItemClick {
    DBManager *model = [[DBManager sharedManager] selectOneModel];
    NSMutableArray *mutArray = [NSMutableArray array];
    [mutArray addObject:model];
    UserModel *userModel = mutArray[0];
    
    
    NSString *url = [NSString stringWithFormat:Main_URL,AddCollection_URL];
    
    NSDictionary *dic = @{@"fkId":self.ID,
                          @"type":@"2",
                          @"uid":userModel.user_id};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
        [self showMessegeForResult:responseObject[@"msg"]];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
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



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"活动详情";
    
    
    
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
    
    


    if ([self.state isEqualToString:@"1"]) {
        
        if ([self.type isEqualToString:@"1"]) {
            self.url = [NSURL URLWithString:[NSString stringWithFormat:Main_URL,[NSString stringWithFormat:Hactivity_URL,self.ID]]];
        
        } else if ([self.type isEqualToString:@"2"]) {
            self.url = [NSURL URLWithString:[NSString stringWithFormat:Main_URL,[NSString stringWithFormat:HactivityB_URL,self.ID]]];
        }else if ([self.type isEqualToString:@"3"]) {
            self.url = [NSURL URLWithString:[NSString stringWithFormat:Main_URL,[NSString stringWithFormat:Hevent_URL,self.ID]]];
        }else if ([self.type isEqualToString:@"4"]) {
            self.url = [NSURL URLWithString:[NSString stringWithFormat:Main_URL,[NSString stringWithFormat:Hselection_URL,self.ID]]];
        }

        
    } else if ([self.state isEqualToString:@"2"]) {
        self.url = [NSURL URLWithString:[NSString stringWithFormat:Main_URL,[NSString stringWithFormat:Hactivity_URL,self.ID]]];
        
    } else if ([self.state isEqualToString:@"3"]) {
        self.url = [NSURL URLWithString:[NSString stringWithFormat:Main_URL,[NSString stringWithFormat:Hactivity_URL,self.ID]]];
    }
    
    [self.web loadRequest:[NSURLRequest requestWithURL:self.url]];
    
}


//报名
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.context = [self.web valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    //定义好JS要调用的方法
    self.context[@"addSign"] = ^() {
        NSLog(@"%@",self.ID);
      
        ApplyController *vc = [[ApplyController alloc] init];
        vc.ID = self.ID;
        
        NSLog(@"%@",vc.ID);
        [self.navigationController pushViewController:vc animated:YES];
        

    };
    
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
