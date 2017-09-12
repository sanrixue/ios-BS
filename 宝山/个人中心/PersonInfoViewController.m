//
//  PersonInfoViewController.m
//  宝山
//
//  Created by 尤超 on 17/4/20.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "PersonInfoViewController.h"
#import "Masonry.h"
#import "RSKImageCropper.h"
#import "UIImageView+WebCache.h"
#import "DBManager.h"
#import "YCHead.h"
#import "TitleModel.h"
#import "ForgetPasswordController.h"    

@interface PersonInfoViewController ()<UIActionSheetDelegate,RSKImageCropViewControllerDelegate,UIAlertViewDelegate>{
    UIImageView *_headImage;
    //头像
    UIImageView *_iconImage;
    
    UITextField *_nameText;
    UITextField *_phoneText;
    
    UILabel *_sexLab;
    
    NSString *_sex;
}

@end

@implementation PersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"修改个人资料";
    
    [self setUpUI];
    
    _sex = [[NSString alloc] init];
}

- (void)setUpUI {
    CreatControls *creatControls = [[CreatControls alloc] init];
    
    _headImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 259 * KSCREENWIDTH / 375)];
    _headImage.image = [UIImage imageNamed:@"back"];
    [self.view addSubview:_headImage];
    
    _iconImage = [[UIImageView alloc] init];
    [_headImage addSubview:_iconImage];
    
    _iconImage.layer.cornerRadius = 120*0.5*KSCREENWIDTH/375.0;
    _iconImage.layer.masksToBounds = YES;
    _iconImage.layer.borderWidth = 4*KSCREENWIDTH/375.0;
    _iconImage.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
    
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(_headImage.mas_centerX);
        make.centerY.mas_equalTo(_headImage.mas_centerY).offset(30*KSCREENWIDTH/375.0);
        make.size.mas_equalTo(CGSizeMake(120*KSCREENWIDTH/375.0, 120*KSCREENWIDTH/375.0));
    }];
    
    //头像添加透明的Btn
    UIButton *iconBtn = [[UIButton alloc] init];
    [iconBtn addTarget:self action:@selector(iconBtnClick) forControlEvents:UIControlEventTouchUpInside];
    iconBtn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:iconBtn];
    
    [iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_iconImage.mas_centerX);
        make.centerY.mas_equalTo(_iconImage.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(120*KSCREENWIDTH/375.0, 120*KSCREENWIDTH/375.0));
    }];
    
    
    DBManager *model = [[DBManager sharedManager] selectOneModel];
    NSMutableArray *mutArray = [NSMutableArray array];
    [mutArray addObject:model];
    UserModel *userModel = mutArray[0];
    
    NSLog(@"%@",userModel.user_logo);
    
    //读取图片
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_user",userModel.user_id]];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    if (image) {
        _iconImage.image = image;
        
    } else if ([[NSString stringWithFormat:@"%@",userModel.user_logo] isEqualToString:@"(null)"]) {
        _iconImage.image = [UIImage imageNamed:@"default.jpg"];
        
    } else {
        [_iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:Main_URL,userModel.user_logo]]];
    }
    
    
    
    
//    UILabel *lineLab1 = [[UILabel alloc] initWithFrame:CGRectMake(0.05*KSCREENWIDTH, 260*KSCREENWIDTH/375.0, 0.9*KSCREENWIDTH, 1)];
//    lineLab1.backgroundColor = [UIColor lightGrayColor];
//    lineLab1.alpha = 0.3;
//    [self.view addSubview:lineLab1];
    
    UILabel *lineLab2 = [[UILabel alloc] initWithFrame:CGRectMake(0.05*KSCREENWIDTH, 260*KSCREENWIDTH/375.0+41, 0.9*KSCREENWIDTH, 1)];
    lineLab2.backgroundColor = [UIColor lightGrayColor];
    lineLab2.alpha = 0.3;
    [self.view addSubview:lineLab2];
    
    UILabel *lineLab3 = [[UILabel alloc] initWithFrame:CGRectMake(0.05*KSCREENWIDTH, 260*KSCREENWIDTH/375.0+82, 0.9*KSCREENWIDTH, 1)];
    lineLab3.backgroundColor = [UIColor lightGrayColor];
    lineLab3.alpha = 0.3;
    [self.view addSubview:lineLab3];
    
    UILabel *lineLab4 = [[UILabel alloc] initWithFrame:CGRectMake(0.05*KSCREENWIDTH, 260*KSCREENWIDTH/375.0+123, 0.9*KSCREENWIDTH, 1)];
    lineLab4.backgroundColor = [UIColor lightGrayColor];
    lineLab4.alpha = 0.3;
    [self.view addSubview:lineLab4];
    
    
    _nameText = [[UITextField alloc] init];
    [creatControls text:_nameText Title:nil Frame:CGRectMake(0.15*KSCREENWIDTH,260*KSCREENWIDTH/375.0+1, 0.7*KSCREENWIDTH, 40) Image:nil];
    _nameText.textAlignment = NSTextAlignmentRight;
    [self.view addSubview: _nameText];
    _nameText.textColor = [UIColor grayColor];
    _nameText.font = [UIFont systemFontOfSize:18];
    
    if ([[NSString stringWithFormat:@"%@",userModel.user_name] isEqualToString:@"(null)"]) {
        _nameText.text = @"某某某";
        
    } else {
        _nameText.text = userModel.user_name;
    }

    
//    UILabel *lab = [[UILabel alloc] init];
//    [creatControls label:lab Name:@"头像" andFrame:CGRectMake(0.1*KSCREENWIDTH, 260*KSCREENWIDTH/375.0-100, 80, 40)];
//    lab.textAlignment = NSTextAlignmentLeft;
//    [self.view addSubview:lab];
    
    UILabel *lab1 = [[UILabel alloc] init];
    [creatControls label:lab1 Name:@"昵称" andFrame:CGRectMake(0.1*KSCREENWIDTH, 260*KSCREENWIDTH/375.0+1, 80, 40)];
    lab1.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:lab1];
    
    UILabel *lab2 = [[UILabel alloc] init];
    [creatControls label:lab2 Name:@"性别" andFrame:CGRectMake(0.1*KSCREENWIDTH, 260*KSCREENWIDTH/375.0+42, 80, 40)];
    lab2.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:lab2];
    
    _sexLab = [[UILabel alloc] init];
    [creatControls label:_sexLab Name:@"男" andFrame:CGRectMake(0.8*KSCREENWIDTH-15, 260*KSCREENWIDTH/375.0+42, 0.1*KSCREENWIDTH, 40)];
    _sexLab.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:_sexLab];
    
    if ([[NSString stringWithFormat:@"%@",userModel.user_sex] isEqualToString:@"2"]) {
        _sexLab.text = @"女";
    } else {
        _sexLab.text = @"男";
    }
    
    
    //性别添加透明的Btn
    UIButton *sexBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.1*KSCREENWIDTH, 260*KSCREENWIDTH/375.0+42, 0.8*KSCREENWIDTH, 40)];
    [sexBtn addTarget:self action:@selector(sexBtnClick) forControlEvents:UIControlEventTouchUpInside];
    sexBtn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:sexBtn];
    
    
    UILabel *lab3 = [[UILabel alloc] init];
    [creatControls label:lab3 Name:@"修改密码" andFrame:CGRectMake(0.1*KSCREENWIDTH, 260*KSCREENWIDTH/375.0+83, 80, 40)];
    lab3.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:lab3];
    
    
    UIButton *changeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 260*KSCREENWIDTH/375.0+83, KSCREENWIDTH, 40)];
    changeBtn.backgroundColor = [UIColor clearColor];
    [changeBtn addTarget:self action:@selector(changeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeBtn];
    
    
    UIButton *PUTBtn = [[UIButton alloc] init];
    PUTBtn.frame = CGRectMake(KSCREENWIDTH *0.15, 260*KSCREENWIDTH/375.0+140, KSCREENWIDTH * 0.7, KSCREENWIDTH * 0.125 -10);
    [PUTBtn setTitle:@"保存" forState:UIControlStateNormal];
    PUTBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [PUTBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [PUTBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [PUTBtn addTarget:self action:@selector(PUTBtnClick) forControlEvents:UIControlEventTouchUpInside];
    PUTBtn.backgroundColor = COLOR(0, 123, 23, 0.8);
    PUTBtn.layer.cornerRadius = 5;
    [self.view addSubview:PUTBtn];
    
}

- (void)sexBtnClick {
    [self startChooseSex];
}


//开始创建actionSheet
- (void)startChooseSex {
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"男", @"女", nil];
    choiceSheet.tag = 1000;
    [choiceSheet showInView:self.view];
}


- (void)changeBtnClick {
    
    TitleModel *model = [TitleModel shareModel];
    model.title = @"2";
    
    ForgetPasswordController *forgetVC = [[ForgetPasswordController alloc] init];
    
    [self.navigationController pushViewController:forgetVC animated:YES];
    
}

- (void)returnBlock:(MyBlock)block {
    self.myBlock = block;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    
    if (self.myBlock != nil) {
        self.myBlock(_nameText.text,_iconImage.image);
    }
}

//图片压缩
- (NSData *) scaleImage:(UIImage *) image
{
    NSData *dataImage = UIImageJPEGRepresentation(image, 1.0);
    NSLog(@"imagesize:%ld",(long)dataImage.length/1024);
    NSUInteger sizeOrigin = [dataImage length];
    NSUInteger sizesizeOriginKB = sizeOrigin / 1024;
    
    
    float q = 1.0;
    if (sizesizeOriginKB > 1024*10) //10M
    {
        q = 0.5;
    }else if(sizesizeOriginKB > 1024*7) //7M
    {
        q = 0.7;
    }
    else if(sizesizeOriginKB > 1024*5) //5M
    {
        q = 0.8;
    }else if(sizesizeOriginKB > 1024*4){
        q = 0.9;
    }
    else if(sizesizeOriginKB > 1024*3)//3M
    {
        q = 0.92;
    }
    // 图片压缩
    if (q !=1.0)
    {
        NSLog(@"q:%f",q);
        CGSize sizeImage = [image size];
        NSLog(@"before !!!!,%@,%f,%f",image,sizeImage.width,sizeImage.height);
        CGFloat iwidthSmall = sizeImage.width * q;
        CGFloat iheightSmall = sizeImage.height * q;
        
        //为了保证在主页的显示，宽度不低于320
        if (iwidthSmall < 320)
        {
            iheightSmall = iheightSmall * (320/iwidthSmall);
            iwidthSmall = 320;
        }
        CGSize itemSizeSmall = CGSizeMake(iwidthSmall, iheightSmall);
        UIGraphicsBeginImageContext(itemSizeSmall);
        
        CGRect imageRectSmall = CGRectMake(0.0f, 0.0f, itemSizeSmall.width+2, itemSizeSmall.height+2);  //长和宽都增加2个像素，防止有些图片绘制旁边出现白线
        NSLog(@"before drawInRect!!,%f,%f",imageRectSmall.size.width,imageRectSmall.size.height);
        [image drawInRect:imageRectSmall];
        //NSLog(@"after drawInRect!!!!");
        UIImage *scaleImage = UIGraphicsGetImageFromCurrentImageContext();
        dataImage = UIImageJPEGRepresentation(scaleImage,0.38);
        
        //UIImagePNGRepresentation(scaleImage);// UIImageJPEGRepresentation(scaleImage,0.9);
        
    }else{
        dataImage = UIImageJPEGRepresentation(image,0.38);
    }
    NSLog(@"压缩bit 后：%ld",(long)[dataImage length]/1024);
    return dataImage;
    
}


- (void)PUTBtnClick {
    NSLog(@"保存");
    
    DBManager *model = [[DBManager sharedManager] selectOneModel];
    NSMutableArray *mutArray = [NSMutableArray array];
    [mutArray addObject:model];
    UserModel *userModel = mutArray[0];
    
    //URL接口
    NSString * url = [NSString stringWithFormat:Main_URL,Modify_URL];
    
    NSData * UP_data = [self scaleImage:_iconImage.image];
    
    UIImage *image = [UIImage imageWithData:UP_data];
    
    NSLog(@"%@",_iconImage.image);
    
    NSString * ID_Str = userModel.user_id;
    
    if ([_sexLab.text isEqualToString:@"男"]) {
        _sex = @"1";
    } else {
        _sex = @"2";
    }
    
    
    
    //上传的参数
    NSDictionary * dic = @{@"userName":_nameText.text,
                           @"sex":_sex,
                           @"id":ID_Str};
    NSLog(@"打印出上传的参数--->>>%@",dic);
    NSLog(@"打印出URL--->>>%@",url);
    AFHTTPSessionManager * man = [AFHTTPSessionManager manager];
    man.responseSerializer = [AFHTTPResponseSerializer serializer];
    [man POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
     {
        
         [formData appendPartWithFileData:UP_data name:@"imgPath" fileName:[NSString stringWithFormat:@"titleimage%@.png",ID_Str] mimeType:@"image/png"];
         
     } progress:^(NSProgress * _Nonnull uploadProgress)
     {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSLog(@"上传头像成功--->>>%@",responseObject);
        
         
         NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
         
         NSString *uniquePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_user",ID_Str]];
         
         BOOL result = [UIImagePNGRepresentation(image)writeToFile: uniquePath atomically:YES];
         if (result) {
             NSLog(@"success");
             
         }
         
         [[DBManager sharedManager]upadteUserModelModelName:_nameText.text ModelModelSex:_sex FromModelId:ID_Str];
         
         
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"修改成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
         
         alert.tag = 200;
         
         [alert show];
         
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"请求失败---->>>>%@",error);
        
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"修改失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
         
         [alert show];
     }];
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 200) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}


- (void)iconBtnClick {
    
    [self startChoosePhoto];
}

//开始创建actionSheet
- (void)startChoosePhoto {
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册中选取", nil];
   
    [choiceSheet showInView:self.view];
}

// actionSheet的代理方法，用来设置每个按钮点击的触发事件
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 1000) {
        if (buttonIndex == 0) {
            
            _sexLab.text = @"男";
        } else if(buttonIndex == 1){
            _sexLab.text = @"女";
        } else{
            [actionSheet setHidden:YES];
        }

    } else {
        //构建图像选择器
        UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
        
        [pickerController setDelegate:(id)self];
        
        if (buttonIndex == 0) {
            
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            }
            [pickerController.view setTag:actionSheet.tag];
            [self presentViewController:pickerController animated:YES completion:nil];
            
        } else if(buttonIndex == 1){
            pickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:pickerController animated:YES completion:nil];
        }
        else{
            [actionSheet setHidden:YES];
        }
    }
    
}

// 图像选择器选取好后，将图片数据拿过来
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    RSKImageCropViewController *imageCropVC = [[RSKImageCropViewController alloc] initWithImage:image cropMode:RSKImageCropModeCircle];
    
    imageCropVC.delegate = self;
    
    [self.navigationController pushViewController:imageCropVC animated:YES];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - RSKImageCropViewControllerDelegate
//取消
- (void)imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller
{
    [self.navigationController popViewControllerAnimated:YES];
}

//确认
- (void)imageCropViewController:(RSKImageCropViewController *)controller didCropImage:(UIImage *)croppedImage usingCropRect:(CGRect)cropRect
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    _iconImage.image = croppedImage;
    
    
    
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_nameText resignFirstResponder];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

