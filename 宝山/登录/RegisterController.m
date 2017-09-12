//
//  RegisterController.h
//  宝山
//
//  Created by 尤超 on 17/4/12.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "RegisterController.h"
#import "YCHead.h"
#import "OnceController.h"

@interface RegisterController ()<UIAlertViewDelegate>{
    UITextField *_phone;
    UITextField *_test;
    UITextField *_password;
    BOOL isPhone;
    
    NSString *_uid;
}


@end


@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"注册";
    
    UIImageView *bkImage = [[UIImageView alloc] init];
    bkImage.frame = self.view.frame;
    [bkImage setImage:[UIImage imageNamed:@"loginback"]];
    [self.view addSubview:bkImage];
    
    _uid = [[NSString alloc] init];
    
    [self setUpUI];
}

- (void)setUpUI {
    
    
    CreatControls *creatControls = [[CreatControls alloc] init];
    

    _phone = [[UITextField alloc] init];
    [creatControls text:_phone Title:@"手机号" Frame:CGRectMake(KSCREENWIDTH * 0.15,  KSCREENHEIGHT* 0.45, KSCREENWIDTH * 0.7, 35)];
    [self.view addSubview:_phone];
    _phone.textColor = [UIColor darkGrayColor];
    _phone.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
    _phone.keyboardType = UIKeyboardTypeNumberPad;
    [_phone setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    _phone.layer.cornerRadius = 17;
    _phone.layer.masksToBounds = YES;
    
    _test = [[UITextField alloc] init];
    [creatControls text:_test Title:@"验证码" Frame:CGRectMake(KSCREENWIDTH * 0.15,  KSCREENHEIGHT* 0.45 + 50, KSCREENWIDTH * 0.7, 35)];
    [self.view addSubview:_test];
    _test.textColor = [UIColor darkGrayColor];
    _test.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
    [_test setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    _test.layer.cornerRadius = 17;
    _test.layer.masksToBounds = YES;
    
    
    
    _password = [[UITextField alloc] init];
    [creatControls text:_password Title:@"密码" Frame:CGRectMake(KSCREENWIDTH * 0.15,  KSCREENHEIGHT* 0.45 + 100, KSCREENWIDTH * 0.7, 35)];
    [self.view addSubview:_password];
    _password.textColor = [UIColor darkGrayColor];
    _password.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
    [_password setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    _password.layer.cornerRadius = 17;
    _password.layer.masksToBounds = YES;
    _password.secureTextEntry = YES;
    
    
    UIButton *PUTBtn = [[UIButton alloc] init];
    PUTBtn.frame = CGRectMake(KSCREENWIDTH * 0.15,  KSCREENHEIGHT* 0.45 + 150, KSCREENWIDTH * 0.7, 35);
    [PUTBtn setTitle:@"注册" forState:UIControlStateNormal];
    PUTBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [PUTBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [PUTBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [PUTBtn addTarget:self action:@selector(PUTBtnClick) forControlEvents:UIControlEventTouchUpInside];
    PUTBtn.backgroundColor = COLOR(0, 123, 23, 0.8);
    PUTBtn.layer.cornerRadius = 17;
    [self.view addSubview:PUTBtn];
    
    
    
    UIButton *testBtn = [[UIButton alloc] init];
    testBtn.frame = CGRectMake(KSCREENWIDTH * 0.85-100,  KSCREENHEIGHT* 0.45, 100, 35);
    [testBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    testBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [testBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [testBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [testBtn addTarget:self action:@selector(testBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    testBtn.backgroundColor = COLOR(205, 205, 205, 1);
    testBtn.layer.cornerRadius = 17;
    [self.view addSubview:testBtn];
    
    
    
}

- (void)testBtnClick:(UIButton *)sender {
    
   
    
    isPhone = [self valuatePhone];
    
    
    NSLog(@"~~~~~~~~~%d",isPhone);

    if (isPhone==YES)
    {
        NSString * urlStr = [NSString stringWithFormat:Verification_URL,_phone.text];
        NSString * url = [NSString stringWithFormat:Main_URL,urlStr];
        
        [AFNetwork POST:url parameters:nil success:^(id  _Nonnull json) {
            NSLog(@"请求成功----->>>>%@",json);
            
//            [self showMessegeForResult:json[@"msg"]];
            
            __block int timeout=60;//倒计时时间
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^
                                              {
                                                  if(timeout<=0)
                                                  { //倒计时结束，关闭
                                                      dispatch_source_cancel(_timer);
                                                      dispatch_async(dispatch_get_main_queue(), ^
                                                                     {
                                                                         //设置界面的按钮显示 根据自己需求设置
                                                                         [sender setTitle:@"重新发送" forState:UIControlStateNormal];
                                                                         sender.userInteractionEnabled = YES;
                                                                         [sender setBackgroundColor:COLOR(205, 205, 205, 1)];
                                                                     });
                                                  }
                                                  else
                                                  {
                                                      int seconds = timeout % 130;
                                                      NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                                                      dispatch_async(dispatch_get_main_queue(), ^
                                                                     {
                                                                         //设置界面的按钮显示 根据自己需求设置
                                                                         //NSLog(@"____%@",strTime);
                                                                         [UIView beginAnimations:nil context:nil];
                                                                         [UIView setAnimationDuration:0.5];
                                                                         [sender setTitle:[NSString stringWithFormat:@"%@秒重新发送",strTime] forState:UIControlStateNormal];
                                                                         [sender setBackgroundColor:COLOR(205, 205, 205, 1)];
                                                                         [UIView commitAnimations];
                                                                         sender.userInteractionEnabled = NO;
                                                                     });
                                                      timeout--;
                                                  }
                                                  
                                              });
            dispatch_resume(_timer);

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"请求失败------>>>%@",error);
        }];
        
    } else {
        
        [self showMessegeForResult:@"请输入正确的手机号"];
    }
}

//注册
- (void)PUTBtnClick {
    isPhone = [self valuatePhone];
    
    if (isPhone==NO)
    {
        [self showMessegeForResult:@"请输入正确的手机号"];
    }
    else
    {
        if ([_test.text isEqualToString:@""])
        {
            [self showMessegeForResult:@"验证码不能为空"];
        }
        else
        {
        
                if (_password.text.length<6)
                {
                    [self showMessegeForResult:@"密码长度不可少于6位"];
                }
                else
                {
                    
                    NSDictionary * PostDic = @{@"loginName":_phone.text,@"yzm":_test.text,@"loginPwd":_password.text};
                    
                    NSString * url = [NSString stringWithFormat:Main_URL,Registered_URL];

                    NSLog(@"!!!!!%@     %@",url,PostDic);
                    
                    
                    [AFNetwork POST:url parameters:PostDic success:^(id  _Nonnull json) {
                        NSLog(@"请求成功---->>>%@",json);
                        if ([json[@"code"] isEqualToString:@"200"])
                        {
                            _uid = json[@"data"][@"id"];
                            
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"注册成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                            [alert show];
                            
                            NSDictionary *dict = json[@"data"];
                            UserModel *userModel = [UserModel userWithDict:dict];
                            
                            [[DBManager sharedManager] insertUserModel:userModel];
                        }
                        else
                        {
                            [self showMessegeForResult:json[@"msg"]];
                        }

                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         NSLog(@"请求失败---->>>%@",error);
                    }];
                    
               
                    
                }
            }
        }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    OnceController *once = [[OnceController alloc] init];
    once.uid = _uid;
    [self presentViewController:once animated:YES completion:nil];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_phone resignFirstResponder];
    [_test resignFirstResponder];
    [_password resignFirstResponder];
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


//  验证手机号
-(BOOL)valuatePhone
{
    NSString *regex = kTelRegex;
    NSPredicate *predic = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return  [predic evaluateWithObject:_phone.text];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
