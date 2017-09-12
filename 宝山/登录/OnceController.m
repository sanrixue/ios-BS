//
//  OnceController.m
//  宝山
//
//  Created by 尤超 on 17/4/17.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "OnceController.h"
#import "YCHead.h"
#import "MainTabBarController.h"
#import "TypeModel.h"

@interface OnceController ()

@end

@implementation OnceController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *back = [[UIImageView alloc] init];
    back.frame = self.view.frame;
    back.image = [UIImage imageNamed:@"跳转"];
    [self.view addSubview:back];
    
    
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 220, KSCREENWIDTH*0.5-10, 30)];
    [lab setTextColor:[UIColor whiteColor]];
    lab.font = [UIFont fontWithName:@"FZJingLeiS-R-GB" size:24];
    lab.text = [NSString stringWithFormat:@"您是第%@个人",self.uid];
    lab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab];
    
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 260, KSCREENWIDTH*0.5-10, 30)];
    [lab2 setTextColor:[UIColor whiteColor]];
    lab2.font = [UIFont fontWithName:@"FZJingLeiS-R-GB" size:24];
    lab2.text = @"注册次人数";
    lab2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab2];
    
    
    UIButton *btn = [[UIButton alloc] init];
    btn.backgroundColor = [UIColor clearColor];
    btn.frame = self.view.frame;
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)btnClick {
    TypeModel *model = [TypeModel shareModel];
    model.type = @"4";
    
    NSLog(@"~~~~~~~~~~%@",model.type);
    
    MainTabBarController *mainVC = [[MainTabBarController alloc]init];
    mainVC.selectedIndex = 3;
    [self presentViewController:mainVC animated:YES completion:nil];
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
