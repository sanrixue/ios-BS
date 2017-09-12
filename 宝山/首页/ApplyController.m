//
//  ApplyController.m
//  宝山
//
//  Created by 尤超 on 2017/5/24.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "ApplyController.h"
#import "YCHead.h"

@interface ApplyController ()<UITextFieldDelegate,UIActionSheetDelegate> {

    UITextField *_nameText;
    UITextField *_phoneText;
    
    UILabel *_sexLab;
    UILabel *_birthdayLab;
    
    UIDatePicker *_datePicker;
}

@end

@implementation ApplyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"报名";
    self.view.backgroundColor = COLOR(234, 235, 236, 1);
    
    [self addLab:nil  Name:@"  姓      名" Frame:CGRectMake(20, 100, KSCREENWIDTH-40, 35)];
    
    [self addLab:nil  Name:@"  性      别" Frame:CGRectMake(20, 150, KSCREENWIDTH-40, 35)];
    
    [self addLab:nil  Name:@"  联系方式" Frame:CGRectMake(20, 200, KSCREENWIDTH-40, 35)];
    
    [self addLab:nil  Name:@"  生      日" Frame:CGRectMake(20, 250, KSCREENWIDTH-40, 35)];
    
    DBManager *model = [[DBManager sharedManager] selectOneModel];
    NSMutableArray *mutArray = [NSMutableArray array];
    [mutArray addObject:model];
    UserModel *userModel = mutArray[0];

    
    CreatControls *creatControls = [[CreatControls alloc] init];
    
    
    _nameText = [[UITextField alloc] init];
    [creatControls text:_nameText Title:nil Frame:CGRectMake(0.3*KSCREENWIDTH-30,100, 0.7*KSCREENWIDTH, 35) Image:nil];
    _nameText.textAlignment = NSTextAlignmentRight;
    [self.view addSubview: _nameText];
    _nameText.textColor = [UIColor grayColor];
    _nameText.font = [UIFont systemFontOfSize:14];
    _nameText.delegate = self;
    
    if ([[NSString stringWithFormat:@"%@",userModel.user_name] isEqualToString:@"(null)"]) {
        _nameText.text = @"某某某";
        
    } else {
        _nameText.text = userModel.user_name;
    }
    
    
    _sexLab = [[UILabel alloc] init];
    [creatControls label:_sexLab Name:@"男" andFrame:CGRectMake(0.8*KSCREENWIDTH-30, 150, 0.2*KSCREENWIDTH, 35)];
    _sexLab.textAlignment = NSTextAlignmentRight;
    _sexLab.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_sexLab];
    
    if ([[NSString stringWithFormat:@"%@",userModel.user_sex] isEqualToString:@"2"]) {
        _sexLab.text = @"女";
    } else {
        _sexLab.text = @"男";
    }
    
    //性别添加透明的Btn
    UIButton *sexBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 150, KSCREENWIDTH-40, 35)];
    [sexBtn addTarget:self action:@selector(sexBtnClick) forControlEvents:UIControlEventTouchUpInside];
    sexBtn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:sexBtn];

    
    _phoneText = [[UITextField alloc] init];
    [creatControls text:_phoneText Title:nil Frame:CGRectMake(0.3*KSCREENWIDTH-30,200, 0.7*KSCREENWIDTH, 35) Image:nil];
    _phoneText.textAlignment = NSTextAlignmentRight;
    [self.view addSubview: _phoneText];
    _phoneText.textColor = [UIColor grayColor];
    _phoneText.font = [UIFont systemFontOfSize:14];
    _phoneText.keyboardType = UIKeyboardTypePhonePad;
    _phoneText.delegate = self;
    
    if ([[NSString stringWithFormat:@"%@",userModel.user_phone] isEqualToString:@"(null)"]) {
        _phoneText.text = @"";
        
    } else {
        _phoneText.text = userModel.user_phone;
    }

    
    
    _birthdayLab = [[UILabel alloc] init];
    [creatControls label:_birthdayLab Name:@"" andFrame:CGRectMake(0.4*KSCREENWIDTH-30, 250, 0.6*KSCREENWIDTH, 35)];
    _birthdayLab.textAlignment = NSTextAlignmentRight;
    _birthdayLab.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_birthdayLab];
    
   
    
    //性别添加透明的Btn
    UIButton *birthdayBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 250, KSCREENWIDTH-40, 35)];
    [birthdayBtn addTarget:self action:@selector(birthdayBtnClick) forControlEvents:UIControlEventTouchUpInside];
    birthdayBtn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:birthdayBtn];
    
    
    UIButton *PUTBtn = [[UIButton alloc] init];
    PUTBtn.frame = CGRectMake(KSCREENWIDTH *0.15, 300, KSCREENWIDTH * 0.7, 35);
    [PUTBtn setTitle:@"报名" forState:UIControlStateNormal];
    PUTBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [PUTBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [PUTBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [PUTBtn addTarget:self action:@selector(PUTBtnClick) forControlEvents:UIControlEventTouchUpInside];
    PUTBtn.backgroundColor = COLOR(0, 123, 23, 0.8);
    PUTBtn.layer.cornerRadius = 5;
    [self.view addSubview:PUTBtn];

    
    
    // 创建日期选择控件
    UIDatePicker *dateP = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 350, KSCREENWIDTH, 300)];
    
    dateP.backgroundColor = [UIColor clearColor];
    
    _datePicker = dateP;
    
    // 设置日期模式,年月日
    dateP.datePickerMode = UIDatePickerModeDate;
    
    // 设置地区 zh:中国标识
    dateP.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    
    [dateP addTarget:self action:@selector(dateChamge:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:dateP];
    
    _datePicker.hidden = YES;

}

- (void)PUTBtnClick {
    
    if ([_birthdayLab.text isEqualToString:@""]) {
        [self showMessegeForResult:@"请输入生日"];
    } else {
    
        NSString *url = [NSString stringWithFormat:Main_URL,AppActiveBm_URL];
    
        DBManager *model = [[DBManager sharedManager] selectOneModel];
        NSMutableArray *mutArray = [NSMutableArray array];
        [mutArray addObject:model];
        UserModel *userModel = mutArray[0];
        
        NSString *year = [_birthdayLab.text substringToIndex:4];
        
        NSDictionary *dic = @{@"uid":userModel.user_id,
                              @"type":self.ID,
                              @"name":_nameText.text,
                              @"phone":_phoneText.text,
                              @"sex":_sexLab.text,
                              @"birthdayYear":year};
    
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSLog(@"%@",responseObject);
            
            
            [self showMessegeForResult:responseObject[@"msg"]];
          
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }
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
    
    [alert dismissViewControllerAnimated:YES completion:^
    {
        [self.navigationController popViewControllerAnimated:YES];
    }];
  
}

// 只要UIDatePicker选中的时候调用
- (void)dateChamge:(UIDatePicker *)picker
{
    // 创建一个日期格式字符串对象
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    _birthdayLab.text = [fmt stringFromDate:picker.date];
}

- (void)birthdayBtnClick {
    _datePicker.hidden = NO;
    
    [_nameText resignFirstResponder];
    [_phoneText resignFirstResponder];
}


//是否允许输入框可以进行编辑
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    //返回YES表示可以进行编辑,返回NO表示不可以
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    //一旦进行编辑会响应的方法
    _datePicker.hidden = YES;
    
}

- (void)sexBtnClick {
    [self startChooseSex];
    
    _datePicker.hidden = YES;
}


//开始创建actionSheet
- (void)startChooseSex {
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"男", @"女", nil];
    
    [choiceSheet showInView:self.view];
}

// actionSheet的代理方法，用来设置每个按钮点击的触发事件
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
        if (buttonIndex == 0) {
            
            _sexLab.text = @"男";
        } else if(buttonIndex == 1){
            _sexLab.text = @"女";
        } else{
            [actionSheet setHidden:YES];
        }
        
}

- (void)addLab:(UILabel *)lab Name:(NSString *)name Frame:(CGRect)frame {
    lab = [[UILabel alloc] initWithFrame:frame];
    lab.backgroundColor = [UIColor whiteColor];
    lab.text = name;
    lab.textColor = [UIColor blackColor];
    lab.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:lab];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_nameText resignFirstResponder];
    [_phoneText resignFirstResponder];
    _datePicker.hidden = YES;
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
