//
//  TicketSucceedController.m
//  宝山
//
//  Created by 尤超 on 2017/5/12.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "TicketSucceedController.h"
#import "YCHead.h"  

@interface TicketSucceedController ()

@end

@implementation TicketSucceedController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"票务";
    
    [self addLab:@"预约成功" Frame:CGRectMake(30, 80, 300, 30)];
    
    [self addLab:@"宝山城市规划馆" Frame:CGRectMake(30, 120, 300, 30)];
    
    [self addLab:[NSString stringWithFormat:@"预约时间:%@",self.data[@"create_time"]] Frame:CGRectMake(30, 150, 300, 30)];
    
    [self addLab:[NSString stringWithFormat:@"游玩时间:%@",self.data[@"visit_time"]] Frame:CGRectMake(30, 180, 300, 30)];
    
    [self addLab:[NSString stringWithFormat:@"客户姓名:%@",self.data[@"user_name"]] Frame:CGRectMake(30, 210, 300, 30)];
    
    [self addLab:[NSString stringWithFormat:@"联系方式:%@",self.data[@"phone"]] Frame:CGRectMake(30, 240, 300, 30)];
    
    
    UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(30, 110, KSCREENWIDTH-60, 1)];
    lineLab.backgroundColor = [UIColor grayColor];
    lineLab.alpha = 0.3;
    [self.view addSubview:lineLab];
    
    UIImageView *xuxian = [[UIImageView alloc] initWithFrame:CGRectMake(30, 280, KSCREENWIDTH-60, 5)];
    xuxian.image = [UIImage imageNamed:@"xuxian"];
    [self.view addSubview:xuxian];
    
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(60, 300, KSCREENWIDTH-120, KSCREENWIDTH-120)];
    [icon  sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:Main_URL,[NSString stringWithFormat:@"res/ticket/%@",self.data[@"eqimg"]]]]];
    [self.view addSubview:icon];
    
}

- (void)addLab:(NSString *)name Frame:(CGRect)frame {
    UILabel *lab = [[UILabel alloc] init];
    lab.font = [UIFont systemFontOfSize:16];
    lab.text = name;
    lab.frame = frame;
    lab.textAlignment = NSTextAlignmentLeft;
    lab.textColor = [UIColor darkGrayColor];
    [self.view addSubview:lab];
    
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
