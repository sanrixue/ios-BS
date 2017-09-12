//
//  TicketController.m
//  宝山
//
//  Created by 尤超 on 17/4/12.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "TicketController.h"
#import "YCHead.h"
#import "TicketSucceedController.h"

@interface TicketController (){
    UILabel *_timeLab;
    
    UIButton *_todayBtn;
    UIButton *_tommorrowBtn;
    UIButton *_moreBtn;

    
    NSString *_year;
    
    UIView *_backView;
}
@property (nonatomic, strong) DAYCalendarView *calendarView;

@end

@implementation TicketController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = COLOR(234, 235, 236, 1);
    
    self.navigationItem.title = @"票务预约";
    
    UIImageView *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, KSCREENWIDTH, KSCREENHEIGHT-64-44)];
    backImg.image = [UIImage imageNamed:@"售票back.png"];
    [self.view addSubview:backImg];
    
    
    [self setUpUI];
    
}

//获取当地时间
- (NSString *)getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}
//将字符串转成NSDate类型
- (NSDate *)dateFromString:(NSString *)dateString {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}
//传入今天的时间，返回明天的时间
- (NSString *)GetTomorrowDay:(NSDate *)aDate {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:aDate];
    [components setDay:([components day]+1)];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"yyyy-MM-dd"];
    return [dateday stringFromDate:beginningOfWeek];
}

- (void)setUpUI {
    
    CreatControls *creatControls = [[CreatControls alloc] init];
    
    NSString *todayTime = [self getCurrentTime];
    NSString *today = [todayTime substringFromIndex:5];
    
    _year = [todayTime substringToIndex:4];
    
    
    NSDate *tommorrowDate = [self dateFromString:todayTime];
    NSString *tommorrowTime = [self GetTomorrowDay:tommorrowDate];
    NSString *tommorrow = [tommorrowTime substringFromIndex:5];
    
    _todayBtn = [[UIButton alloc] init];
    [creatControls button:_todayBtn Title:[NSString stringWithFormat:@"今天%@",today] Frame:CGRectMake(180*KSCREENHEIGHT/667, 235*KSCREENHEIGHT/667, 55, 25) TitleColor:COLOR(1, 125, 23, 1) Selector:@selector(btnClick) BackgroundColor:[UIColor whiteColor] Image:nil SelectImage:nil BorderColor:COLOR(1, 125, 23, 1)];
    [self.view addSubview:_todayBtn];
    _todayBtn.backgroundColor = COLOR(225, 247, 231, 1);
    
    
    _tommorrowBtn = [[UIButton alloc] init];
    [creatControls button:_tommorrowBtn Title:[NSString stringWithFormat:@"明天%@",tommorrow] Frame:CGRectMake(240*KSCREENHEIGHT/667, 235*KSCREENHEIGHT/667, 55, 25) TitleColor:COLOR(1, 125, 23, 1) Selector:@selector(btn2Click) BackgroundColor:[UIColor whiteColor] Image:nil SelectImage:nil BorderColor:COLOR(1, 125, 23, 1)];
    [self.view addSubview:_tommorrowBtn];
    
    
    _moreBtn = [[UIButton alloc] init];
    [creatControls button:_moreBtn Title:@"更多日期" Frame:CGRectMake(300*KSCREENHEIGHT/667, 235*KSCREENHEIGHT/667, 55, 25) TitleColor:COLOR(1, 125, 23, 1) Selector:@selector(btn3Click) BackgroundColor:[UIColor whiteColor] Image:nil SelectImage:nil BorderColor:COLOR(1, 125, 23, 1)];
    [self.view addSubview:_moreBtn];
    
    
    _timeLab = [[UILabel alloc]init];
    [creatControls label:_timeLab Font:[UIFont systemFontOfSize:10] Name:[NSString stringWithFormat:@"%@当日使用有效",[_todayBtn.titleLabel.text substringFromIndex:2]] andFrame:CGRectMake(95*KSCREENHEIGHT/667, 285*KSCREENHEIGHT/667, 120, 20)];
    [self.view addSubview:_timeLab];
    
    
    UIButton *PUTBtn = [[UIButton alloc] init];
    PUTBtn.frame = CGRectMake(KSCREENWIDTH * 0.15,  KSCREENHEIGHT-44-35-30, KSCREENWIDTH * 0.7, 35);
    [PUTBtn setTitle:@"免费预约" forState:UIControlStateNormal];
    PUTBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [PUTBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [PUTBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [PUTBtn addTarget:self action:@selector(PUTBtnClick) forControlEvents:UIControlEventTouchUpInside];
    PUTBtn.backgroundColor = COLOR(65, 214, 99, 1);
    PUTBtn.layer.cornerRadius = 17;
    [self.view addSubview:PUTBtn];

    
    
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT)];
    _backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_backView];
    _backView.hidden = YES;
    
    self.calendarView =[[DAYCalendarView alloc] initWithFrame:CGRectMake(0, 80, KSCREENWIDTH, 300)];
    [self.calendarView addTarget:self action:@selector(calendarViewDidChange:) forControlEvents:UIControlEventValueChanged];
    [_backView addSubview:self.calendarView];

    
    UIButton *confirmBtn = [[UIButton alloc] init];
    confirmBtn.frame = CGRectMake(KSCREENWIDTH * 0.15, KSCREENHEIGHT-44-35-30, KSCREENWIDTH * 0.7, 35);
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    confirmBtn.backgroundColor = COLOR(65, 214, 99, 1);
    confirmBtn.layer.cornerRadius = 17;
    [_backView addSubview:confirmBtn];
    
}

- (void)confirmBtnClick {
    _backView.hidden = YES;
}

- (void)calendarViewDidChange:(id)sender {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd";
    
    NSString *time = [NSString stringWithFormat:@"%@",[formatter stringFromDate:self.calendarView.selectedDate]];
    
    _timeLab.text = [NSString stringWithFormat:@"%@当日使用有效",[time substringFromIndex:5]];
    
}

- (void)btnClick {
    _timeLab.text = [NSString stringWithFormat:@"%@当日使用有效",[_todayBtn.titleLabel.text substringFromIndex:2]];
    
    _todayBtn.backgroundColor = COLOR(225, 247, 231, 1);
    _tommorrowBtn.backgroundColor = [UIColor clearColor];
    _moreBtn.backgroundColor = [UIColor clearColor];
}

- (void)btn2Click {
    _timeLab.text = [NSString stringWithFormat:@"%@当日使用有效",[_tommorrowBtn.titleLabel.text substringFromIndex:2]];
    
    _todayBtn.backgroundColor = [UIColor clearColor];
    _tommorrowBtn.backgroundColor = COLOR(225, 247, 231, 1);
    _moreBtn.backgroundColor = [UIColor clearColor];
}

- (void)btn3Click {
    _backView.hidden = NO;
    
    _todayBtn.backgroundColor = [UIColor clearColor];
    _tommorrowBtn.backgroundColor = [UIColor clearColor];
    _moreBtn.backgroundColor = COLOR(225, 247, 231, 1);
}


- (void)PUTBtnClick {
    NSString *url = [NSString stringWithFormat:Main_URL,Ticket_URL];
    
    NSLog(@"%@",url);
    
    DBManager *model = [[DBManager sharedManager] selectOneModel];
    NSMutableArray *mutArray = [NSMutableArray array];
    [mutArray addObject:model];
    UserModel *userModel = mutArray[0];

    NSString *time = [NSString stringWithFormat:@"%@-%@",_year,[_timeLab.text substringToIndex:5]];
    
    NSDictionary *dic = @{@"uid":userModel.user_id,
                          @"visitTime":time};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
       
        
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            TicketSucceedController *VC = [[TicketSucceedController alloc] init];
            VC.data = responseObject[@"data"];
            [self.navigationController pushViewController:VC animated:YES];
        } else {
            [self showMessegeForResult:responseObject[@"msg"]];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

  
    
}

#pragma mark - 输入提示错误提示
- (void)showMessegeForResult:(NSString *)messege
{
    if([[[UIDevice currentDevice] systemVersion] floatValue]>7.0)
    {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:messege preferredStyle:UIAlertControllerStyleAlert];
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
