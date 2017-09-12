//
//  ForgetPasswordController.h
//  宝山城市规划馆
//
//  Created by YC on 16/11/15.
//
//

#import "ForgetPasswordController.h"
#import "YCHead.h"


@interface ForgetPasswordController ()<UIAlertViewDelegate>{
    UITextField *_phone;
    UITextField *_test;
    UITextField *_password;
    
    BOOL isPhone;
}


@end

@implementation ForgetPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"忘记密码";
    
    [self setUpUI];
}

- (void)setUpUI {
    
    CreatControls *creatControls = [[CreatControls alloc] init];

    _phone = [[UITextField alloc] init];
    [creatControls text:_phone Title:@"输入手机号" Frame:CGRectMake(KSCREENWIDTH * 0.1,  KSCREENHEIGHT* 0.2, KSCREENWIDTH * 0.8, 40) Image:[UIImage imageNamed:@"phone"]];
    [self.view addSubview:_phone];
    _phone.textColor = COLOR(186, 190, 209, 1.0);
    _phone.keyboardType = UIKeyboardTypeNumberPad;
    [_phone setValue:COLOR(186, 190, 209, 1.0) forKeyPath:@"_placeholderLabel.textColor"];
  
    
    _test = [[UITextField alloc] init];
    [creatControls text:_test Title:@"输入验证码" Frame:CGRectMake(KSCREENWIDTH * 0.1,  KSCREENHEIGHT* 0.2 + 50, KSCREENWIDTH * 0.8, 40) Image:[UIImage imageNamed:@"yzm"]];
    [self.view addSubview:_test];
    _test.textColor = COLOR(186, 190, 209, 1.0);
    [_test setValue:COLOR(186, 190, 209, 1.0) forKeyPath:@"_placeholderLabel.textColor"];
    
    
    
    _password = [[UITextField alloc] init];
    [creatControls text:_password Title:@"输入新密码" Frame:CGRectMake(KSCREENWIDTH * 0.1,  KSCREENHEIGHT* 0.2 + 100, KSCREENWIDTH * 0.8, 40) Image:[UIImage imageNamed:@"pwd"]];
    [self.view addSubview:_password];
    _password.textColor = COLOR(186, 190, 209, 1.0);
    [_password setValue:COLOR(186, 190, 209, 1.0) forKeyPath:@"_placeholderLabel.textColor"];
    _password.secureTextEntry = YES;
    
    
    UIButton *PUTBtn = [[UIButton alloc] init];
    PUTBtn.frame = CGRectMake(KSCREENWIDTH * 0.1,  KSCREENHEIGHT* 0.2 + 170, KSCREENWIDTH * 0.8, 35);
    [PUTBtn setTitle:@"完成" forState:UIControlStateNormal];
    PUTBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [PUTBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [PUTBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [PUTBtn addTarget:self action:@selector(PUTBtnClick) forControlEvents:UIControlEventTouchUpInside];
    PUTBtn.backgroundColor = COLOR(231, 196, 128, 1);
    PUTBtn.layer.cornerRadius = 5;
    [self.view addSubview:PUTBtn];
    
    
    
    UIButton *testBtn = [[UIButton alloc] init];
    testBtn.frame = CGRectMake(KSCREENWIDTH * 0.85-100,  KSCREENHEIGHT* 0.2 + 50, 100, 35);
    [testBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    testBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [testBtn setTitleColor:COLOR(231, 196, 128, 1) forState:UIControlStateNormal];
    [testBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [testBtn addTarget:self action:@selector(testBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    testBtn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:testBtn];

 
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(KSCREENWIDTH * 0.1,  KSCREENHEIGHT* 0.2 + 45, KSCREENWIDTH * 0.8, 1)];
    line.backgroundColor = COLOR(186, 190, 209, 1.0);
    [self.view addSubview:line];
    
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(KSCREENWIDTH * 0.1,  KSCREENHEIGHT* 0.2 + 95, KSCREENWIDTH * 0.8, 1)];
    line2.backgroundColor = COLOR(186, 190, 209, 1.0);
    [self.view addSubview:line2];
    
    UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake(KSCREENWIDTH * 0.1,  KSCREENHEIGHT* 0.2 + 145, KSCREENWIDTH * 0.8, 1)];
    line3.backgroundColor = COLOR(186, 190, 209, 1.0);
    [self.view addSubview:line3];
    
    UILabel *line4 = [[UILabel alloc] initWithFrame:CGRectMake(KSCREENWIDTH * 0.85-90,  KSCREENHEIGHT* 0.2 + 58, 1, 20)];
    line4.backgroundColor = COLOR(186, 190, 209, 1.0);
    [self.view addSubview:line4];
 
}

- (void)testBtnClick:(UIButton *)sender {
    isPhone = [self valuatePhone];
    
    
    NSLog(@"~~~~~~~~~%d",isPhone);
    
    if (isPhone==YES)
    {
        NSString * urlStr = [NSString stringWithFormat:Verification_URL,_phone.text];
        NSString * url = [NSString stringWithFormat:Main_URL,urlStr];
        
        NSLog(@"验证码%@",url);
        
//        [AFNetwork POST:url parameters:nil success:^(id  _Nonnull json) {
//            NSLog(@"请求成功----->>>>%@",json);
//            
//            [self showMessegeForResult:json[@"msg"]];
//            __block int timeout=60;//倒计时时间
//            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//            dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
//            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
//            dispatch_source_set_event_handler(_timer, ^
//                                              {
//                                                  if(timeout<=0)
//                                                  { //倒计时结束，关闭
//                                                      dispatch_source_cancel(_timer);
//                                                      dispatch_async(dispatch_get_main_queue(), ^
//                                                                     {
//                                                                         //设置界面的按钮显示 根据自己需求设置
//                                                                         [sender setTitle:@"重新发送" forState:UIControlStateNormal];
//                                                                         sender.userInteractionEnabled = YES;
//                                                                         [sender setBackgroundColor:COLOR(143, 212, 226, 1)];
//                                                                     });
//                                                  }
//                                                  else
//                                                  {
//                                                      int seconds = timeout % 130;
//                                                      NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
//                                                      dispatch_async(dispatch_get_main_queue(), ^
//                                                                     {
//                                                                         //设置界面的按钮显示 根据自己需求设置
//                                                                         //NSLog(@"____%@",strTime);
//                                                                         [UIView beginAnimations:nil context:nil];
//                                                                         [UIView setAnimationDuration:0.5];
//                                                                         [sender setTitle:[NSString stringWithFormat:@"%@秒重新发送",strTime] forState:UIControlStateNormal];
//                                                                         [sender setBackgroundColor:COLOR(143, 212, 226, 1)];
//                                                                         [UIView commitAnimations];
//                                                                         sender.userInteractionEnabled = NO;
//                                                                     });
//                                                      timeout--;
//                                                  }
//                                                  
//                                              });
//            dispatch_resume(_timer);
//            
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSLog(@"请求失败------>>>%@",error);
//        }];
        
    } else {
        
        [self showMessegeForResult:@"请输入正确的手机号"];
    }

}

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
//                    NSDictionary * PostDic = @{@"phone":_phone.text,@"yzm":_test.text,@"login_pwd":_password.text};
//                    
//                    NSString * url = [NSString stringWithFormat:Main_URL,Forget_URL];
//                
//                NSLog(@"修改密码%@",url);
//                
//                    [AFNetwork POST:url parameters:PostDic success:^(id  _Nonnull json) {
//                        NSLog(@"请求成功---->>>%@",json);
//                        if ([json[@"code"] isEqualToString:@"200"])
//                        {
//                            
//                            
//                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"修改成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//                            [alert show];
//                            
//                            
//                        }
//                        else
//                        {
//                            [self showMessegeForResult:json[@"msg"]];
//                        }
//                        
//                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                        NSLog(@"请求失败---->>>%@",error);
//                    }];
//                    
                
                }
            }
        }

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.navigationController popViewControllerAnimated:YES];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
