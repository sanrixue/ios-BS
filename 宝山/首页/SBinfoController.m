//
//  SBinfoController.m
//  宝山
//
//  Created by 尤超 on 2017/5/17.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "SBinfoController.h"
#import "YCHead.h"

@interface SBinfoController () {
    UILabel *_lab1;
    UILabel *_lab2;
    UILabel *_lab3;
    UILabel *_lab4;
    UILabel *_lab5;
    UILabel *_lab6;
    UILabel *_lab7;
}

@end

@implementation SBinfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"设备详情";
    
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(KSCREENWIDTH/2-100, 100, 200, 160)];
    icon.image = [UIImage imageNamed:@"Sicon3"];
    [self.view addSubview:icon];
    
    _lab1 = [[UILabel alloc] init];
    _lab2 = [[UILabel alloc] init];
    _lab3 = [[UILabel alloc] init];
    _lab4 = [[UILabel alloc] init];
    _lab5 = [[UILabel alloc] init];
    _lab6 = [[UILabel alloc] init];
    _lab7 = [[UILabel alloc] init];

    
    
    [self addLab:_lab1 Name:@"设备" Frame:CGRectMake(KSCREENWIDTH/2-100, 280, 200, 20) Font:[UIFont systemFontOfSize:16]];
    _lab1.textAlignment = NSTextAlignmentCenter;
    
    [self addLab:_lab7 Name:@"详细信息" Frame:CGRectMake(KSCREENWIDTH/2-100, 350, 200, 20) Font:[UIFont systemFontOfSize:18]];
    _lab7.textAlignment = NSTextAlignmentCenter;
    
    [self addLab:_lab2 Name:@"产品品牌:" Frame:CGRectMake(KSCREENWIDTH/2-100, 380, 200, 20) Font:[UIFont systemFontOfSize:16]];
    [self addLab:_lab3 Name:@"产品型号:" Frame:CGRectMake(KSCREENWIDTH/2-100, 410, 200, 20) Font:[UIFont systemFontOfSize:16]];
    [self addLab:_lab4 Name:@"维系电话:" Frame:CGRectMake(KSCREENWIDTH/2-100, 440, 200, 20) Font:[UIFont systemFontOfSize:16]];
    [self addLab:_lab5 Name:@"累计使用时间:" Frame:CGRectMake(KSCREENWIDTH/2-100, 470, 200, 20) Font:[UIFont systemFontOfSize:16]];
    [self addLab:_lab6 Name:@"虚拟倒计时:" Frame:CGRectMake(KSCREENWIDTH/2-100, 500, 200, 20) Font:[UIFont systemFontOfSize:16]];
    
    
    
    
    NSString *url = [NSString stringWithFormat:Main_URL,SBinfo_URL];
    
    NSDictionary *dic = @{@"id":self.ID};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] isEqualToString:@"200"]) {
            _lab1.text = responseObject[@"data"][@"name"];
            _lab2.text = [NSString stringWithFormat:@"产品品牌:%@",responseObject[@"data"][@"brand"]];
            _lab3.text = [NSString stringWithFormat:@"产品型号:%@",responseObject[@"data"][@"model"]];
            _lab4.text = [NSString stringWithFormat:@"维系电话:%@",responseObject[@"data"][@"contactNumber"]];
            _lab5.text = [NSString stringWithFormat:@"累计使用时间:%@H",responseObject[@"data"][@"useTime"]];
            _lab6.text = [NSString stringWithFormat:@"虚拟倒计时:%@H",responseObject[@"data"][@"countDown"]];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    

    
    
}

- (void)addLab:(UILabel *)label Name:(NSString *)name Frame:(CGRect)frame Font:(UIFont *)font {
    label.frame = frame;
    label.text = name;
    label.font = font;
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:label];
    
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
