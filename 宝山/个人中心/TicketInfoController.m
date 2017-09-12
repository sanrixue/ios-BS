//
//  TicketInfoController.m
//  宝山
//
//  Created by 尤超 on 2017/5/18.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "TicketInfoController.h"
#import "YCHead.h"

@interface TicketInfoController ()
@property (nonatomic, strong) NSDictionary *data;
@end

@implementation TicketInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"门票详情";
    
  
    
    [self addLab:@"宝山城市规划馆" Frame:CGRectMake(30, 120, 300, 30)];
    
    DBManager *model = [[DBManager sharedManager] selectOneModel];
    NSMutableArray *mutArray = [NSMutableArray array];
    [mutArray addObject:model];
    UserModel *userModel = mutArray[0];

    
    NSString *url = [NSString stringWithFormat:Main_URL,TicketInfo_URL];
    
    NSLog(@"%@",url);
    
    NSDictionary *dic = @{@"uid":userModel.user_id,
                          @"id":self.ID};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            
            self.data = responseObject[@"data"];
            
            [self addLab:[NSString stringWithFormat:@"预约时间:%@",self.data[@"create_time"]] Frame:CGRectMake(30, 150, 300, 30)];
            
            [self addLab:[NSString stringWithFormat:@"游玩时间:%@",self.data[@"visit_time"]] Frame:CGRectMake(30, 180, 300, 30)];
            
            [self addLab:[NSString stringWithFormat:@"客户姓名:%@",self.data[@"user_name"]] Frame:CGRectMake(30, 210, 300, 30)];
            
            [self addLab:[NSString stringWithFormat:@"联系方式:%@",self.data[@"phone"]] Frame:CGRectMake(30, 240, 300, 30)];

            UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(60, 300, KSCREENWIDTH-120, KSCREENWIDTH-120)];
            [icon  sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:Main_URL,[NSString stringWithFormat:@"res/ticket/%@",self.data[@"eqimg"]]]]];
            [self.view addSubview:icon];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

    
    
    UIImageView *xuxian = [[UIImageView alloc] initWithFrame:CGRectMake(30, 280, KSCREENWIDTH-60, 5)];
    xuxian.image = [UIImage imageNamed:@"xuxian"];
    [self.view addSubview:xuxian];
    
    
   
    
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

