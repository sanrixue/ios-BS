//
//  LoginController.h
//  宝山城市规划馆
//
//  Created by YC on 16/11/15.
//
//

#import "LoginController.h"
#import "YCHead.h"
#import "RegisterController.h"
#import "ForgetPasswordController.h"
#import "MainController.h"

@interface LoginController ()<UIAlertViewDelegate>{
    UITextField *_phone;
    UITextField *_password;
    
    BOOL isPhone;
}

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    UIImageView *bkImage = [[UIImageView alloc] init];
    bkImage.frame = self.view.frame;
    [bkImage setImage:[UIImage imageNamed:@"loginback"]];
    [self.view addSubview:bkImage];
    
    
    [self setUpUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)setUpUI {
    
    CreatControls *creatControls = [[CreatControls alloc] init];
    
//    UIImageView *image = [[UIImageView alloc] init];
//    [creatControls image:image Name:@"LOGO" Frame:CGRectMake(KSCREENWIDTH * 0.35,  KSCREENHEIGHT* 0.2, KSCREENWIDTH * 0.3, KSCREENWIDTH * 0.3)];
//    [self.view addSubview:image];
    
    _phone = [[UITextField alloc] init];
    [creatControls text:_phone Title:@"手机号" Frame:CGRectMake(KSCREENWIDTH * 0.15,  KSCREENHEIGHT* 0.35, KSCREENWIDTH * 0.7, 35)];
    [self.view addSubview:_phone];
    _phone.textColor = [UIColor darkGrayColor];
    _phone.backgroundColor = [UIColor colorWithWhite:1 alpha:1.0];
    _phone.keyboardType = UIKeyboardTypeNumberPad;
    [_phone setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    _phone.layer.cornerRadius = 17;
    _phone.layer.masksToBounds = YES;
    
    _password = [[UITextField alloc] init];
    [creatControls text:_password Title:@"密码" Frame:CGRectMake(KSCREENWIDTH * 0.15,  KSCREENHEIGHT* 0.35 + 50, KSCREENWIDTH * 0.7, 35)];
    [self.view addSubview:_password];
    _password.keyboardType = UIKeyboardTypeNumberPad;
    _password.textColor = [UIColor darkGrayColor];
    _password.backgroundColor = [UIColor colorWithWhite:1 alpha:1.0];
    [_password setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    _password.layer.cornerRadius = 17;
    _password.layer.masksToBounds = YES;
    _password.secureTextEntry = YES;
    
    
    UIButton *PUTBtn = [[UIButton alloc] init];
    PUTBtn.frame = CGRectMake(KSCREENWIDTH * 0.15,  KSCREENHEIGHT* 0.35 + 100, KSCREENWIDTH * 0.7, 35);
    [PUTBtn setTitle:@"登录" forState:UIControlStateNormal];
    PUTBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [PUTBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [PUTBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [PUTBtn addTarget:self action:@selector(PUTBtnClick) forControlEvents:UIControlEventTouchUpInside];
    PUTBtn.backgroundColor = COLOR(231, 196, 128, 1);
    PUTBtn.layer.cornerRadius = 17;
    [self.view addSubview:PUTBtn];
    
    
    UIButton *registerBtn = [[UIButton alloc] init];
    registerBtn.frame = CGRectMake(KSCREENWIDTH * 0.15+10,  KSCREENHEIGHT* 0.35 + 140, 100, 35);
    [registerBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [registerBtn addTarget:self action:@selector(forgetBtnClick) forControlEvents:UIControlEventTouchUpInside];
    registerBtn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:registerBtn];
    
    
    UIButton *forgetBtn = [[UIButton alloc] init];
    forgetBtn.frame = CGRectMake(KSCREENWIDTH * 0.85-110,  KSCREENHEIGHT* 0.35 + 140, 100, 35);
    [forgetBtn setTitle:@"注册" forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [forgetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [forgetBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [forgetBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    forgetBtn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:forgetBtn];

    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(KSCREENWIDTH * 0.25,  KSCREENHEIGHT* 0.45 + 197, KSCREENWIDTH * 0.12, 1)];
    line.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:line];

    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(KSCREENWIDTH * 0.63,  KSCREENHEIGHT* 0.45 + 197, KSCREENWIDTH * 0.12, 1)];
    line2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:line2];

    UIButton *PUTBtn2 = [[UIButton alloc] init];
    PUTBtn2.frame = CGRectMake(KSCREENWIDTH * 0.35,  KSCREENHEIGHT* 0.45 + 180, KSCREENWIDTH * 0.3, 35);
    [PUTBtn2 setTitle:@"第三方登录" forState:UIControlStateNormal];
    PUTBtn2.titleLabel.font = [UIFont systemFontOfSize:15];
    [PUTBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [PUTBtn2 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [PUTBtn2 addTarget:self action:@selector(PUTBtn2Click) forControlEvents:UIControlEventTouchUpInside];
    PUTBtn2.backgroundColor = [UIColor clearColor];
    [self.view addSubview:PUTBtn2];
    
    
    UIButton *QQ = [[UIButton alloc] init];
    QQ.frame = CGRectMake(KSCREENWIDTH * 0.25,  KSCREENHEIGHT* 0.45 + 220, 40, 40);
    [QQ setBackgroundImage:[UIImage imageNamed:@"QQ"] forState:UIControlStateNormal];
    [QQ addTarget:self action:@selector(QQ) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:QQ];
    
    UIButton *WX = [[UIButton alloc] init];
    WX.frame = CGRectMake(KSCREENWIDTH * 0.5-20,  KSCREENHEIGHT* 0.45 + 220, 40, 40);
    [WX setBackgroundImage:[UIImage imageNamed:@"微信"] forState:UIControlStateNormal];
    [WX addTarget:self action:@selector(WX) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:WX];

    UIButton *XL = [[UIButton alloc] init];
    XL.frame = CGRectMake(KSCREENWIDTH * 0.75-40,  KSCREENHEIGHT* 0.45 + 220, 40, 40);
    [XL setBackgroundImage:[UIImage imageNamed:@"新浪"] forState:UIControlStateNormal];
    [XL addTarget:self action:@selector(XL) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:XL];

}

//授权登录
- (void)QQ {
    NSLog(@"QQ");
    
}

- (void)WX {
    NSLog(@"WX");
    
}

- (void)XL {
    NSLog(@"XL");
    
}

- (void)forgetBtnClick {
    ForgetPasswordController *forgetVC = [[ForgetPasswordController alloc] init];
    
    [self.navigationController pushViewController:forgetVC animated:YES];
    
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)registerBtnClick {
    RegisterController *registerVC = [[RegisterController alloc] init];
    
    [self.navigationController pushViewController:registerVC animated:YES];
    [self.navigationController setNavigationBarHidden:NO];
    
}

- (void)PUTBtn2Click {
    MainController *mainVC = [[MainController alloc]init];
    
    [self.navigationController pushViewController:mainVC animated:YES];

}

- (void)PUTBtnClick {
   
//    isPhone = [self valuatePhone];
//    
//    if (isPhone==NO)
//    {
//        [self showMessegeForResult:@"请输入正确的手机号"];
//    }
//    else
//    {
//
//            
//            if (_password.text.length<6)
//            {
//                [self showMessegeForResult:@"密码长度不可少于6位"];
//            }
//            else
//            {
//                NSDictionary * PostDic = @{@"login_name":_phone.text,@"login_pwd":_password.text};
//                
//                NSString * url = [NSString stringWithFormat:Main_URL,Login_URL];
//                
//                NSLog(@"%@",url);
//                
//                [AFNetwork POST:url parameters:PostDic success:^(id  _Nonnull json) {
//                    NSLog(@"请求成功---->>>%@",json);
//                    if ([json[@"code"] isEqualToString:@"200"])
//                    {
//                        NSDictionary *dict = json[@"data"];
//                        UserModel *userModel = [UserModel userWithDict:dict];
//                        [[DBManager sharedManager] insertUserModel:userModel];
//
//                    
//                        MainController *mainVC = [[MainController alloc]init];
//                        
//                        [self.navigationController pushViewController:mainVC animated:YES];
//
//                        
//                    }
//                    else
//                    {
//                        [self showMessegeForResult:json[@"msg"]];
//                    }
//                    
//                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                    NSLog(@"请求失败---->>>%@",error);
//                }];
//                
//                
//            }
//        }
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_phone resignFirstResponder];
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
