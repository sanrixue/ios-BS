//
//  PostInfoController.m
//  宝山
//
//  Created by 尤超 on 2017/5/22.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "PostInfoController.h"
#import "YCHead.h"

@interface PostInfoController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *web;

@end

@implementation PostInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"研讨交流";
    
    self.web = [[UIWebView alloc] init];
    self.web.frame = self.view.frame;
    self.web.delegate = self;
    [self.view addSubview:self.web];
    
    
    DBManager *model = [[DBManager sharedManager] selectOneModel];
    NSMutableArray *mutArray = [NSMutableArray array];
    [mutArray addObject:model];
    UserModel *userModel = mutArray[0];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:Main_URL,[NSString stringWithFormat:Hcommunication_URL,self.ID,userModel.user_id]]];
    [self.web loadRequest:[NSURLRequest requestWithURL:url]];
    
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
