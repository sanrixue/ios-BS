//
//  AddPostController.m
//  宝山
//
//  Created by 尤超 on 17/5/3.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "AddPostController.h"
#import "GBTagListView.h"
#import "YCHead.h"
#import "LNImagePickerView.h"  //添加图片
#import "LNPhotoLibaryController.h"   //获取到所有的图片控制器
#import "PhotoModle.h"

@interface AddPostController ()<UITextViewDelegate,LNImagePickerViewDelegate,UIAlertViewDelegate> {
    
    UILabel * label;
    UILabel * imagelabel;
    LNImagePickerView *imagePickerView;  //选取头像按钮
    NSMutableArray * Image_MutabAry;     //接受通知的数组
    
    NSMutableArray *strArray;//保存标签数据的数组
    GBTagListView *_tempTag;
    
    UITextField *_titleText;
    UITextView *_contentText;
    
    NSString *_tagStr;
}

@end

@implementation AddPostController

//发布
- (void)rightItemClick {
    NSLog(@"!!%@",_tagStr);

    if ([_tagStr isEqualToString:@""]) {
        [self showMessegeForResult:@"请添加一个标签"];
        
    } else {
        DBManager *model = [[DBManager sharedManager] selectOneModel];
        NSMutableArray *mutArray = [NSMutableArray array];
        [mutArray addObject:model];
        UserModel *userModel = mutArray[0];
        
        //URL接口
        NSString * url = [NSString stringWithFormat:Main_URL,AddPost_URL];
       
        NSDictionary * post_dic = @{@"title":_titleText.text,
                                    @"content":_contentText.text,
                                    @"uid":userModel.user_id,
                                    @"tag":_tagStr
                                    };
        
        AFHTTPSessionManager * man = [AFHTTPSessionManager manager];
        man.responseSerializer = [AFHTTPResponseSerializer serializer];
        [man POST:url parameters:post_dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
         {
             NSString * name = @"nrtPath";
             
             
             NSLog(@"打印出选择图片数量---->>>%lu",(unsigned long)Image_MutabAry.count);
             for (int i=0; i<Image_MutabAry.count;i++)
             {
                 if (i>8)
                 {
                     break;
                 }
                 else
                 {
                     PhotoModle *photoModel = [PhotoModle shareModel];
                     
                     Image_MutabAry = photoModel.dict;
                     
//                     NSLog(@"!!!!!!!!~~~~~~~~~~~%@",Image_MutabAry);
                     
                     [formData appendPartWithFileData:Image_MutabAry[i] name:@"nrtPath" fileName:[NSString stringWithFormat:@"%@%@.png",name,@(i)] mimeType:@"image/png"];
                 }
             }
         } progress:^(NSProgress * _Nonnull uploadProgress)
         {
             NSLog(@"打印出请求的详细进度--->>>%@",uploadProgress);
         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             NSLog(@"请求成功--->>>%@",responseObject);
             
             PhotoModle *photoModel = [PhotoModle shareModel];
             
             [photoModel.dict removeAllObjects];
             
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"发布成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
             
             [alert show];
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             NSLog(@"请求失败---->>>>%@",error);
             [self showMessegeForResult:@"发布失败"];
         }];
    }
 
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"编辑";
    
    UIView *rightButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 25)];
    UIButton *mainAndSearchBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 25)];
    [rightButtonView addSubview:mainAndSearchBtn];
    [mainAndSearchBtn setTitle:@"发帖" forState:UIControlStateNormal];
    [mainAndSearchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [mainAndSearchBtn addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightCunstomButtonView = [[UIBarButtonItem alloc] initWithCustomView:rightButtonView];
    self.navigationItem.rightBarButtonItem = rightCunstomButtonView;
    
    
    _tagStr = [[NSString alloc] init];
    _tagStr = @"";
    
    CreatControls *creatControls = [[CreatControls alloc] init];
    

    //添加label
    UILabel *titleLab = [[UILabel alloc] init];
    [creatControls label:titleLab Name:@"添加标题" andFrame:CGRectMake(20, 72, 100, 20)];
    [self.view addSubview:titleLab];
    titleLab.textColor = [UIColor grayColor];
    titleLab.font = [UIFont systemFontOfSize:15];
    titleLab.textAlignment = NSTextAlignmentLeft;
    
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, KSCREENWIDTH-20, 1)];
    line.backgroundColor = [UIColor grayColor];
    line.alpha = 0.6;
    [self.view addSubview:line];
    
    _titleText = [[UITextField alloc] initWithFrame:CGRectMake(KSCREENWIDTH-220, 70, 200, 20)];
    _titleText.textColor = [UIColor blackColor];
    _titleText.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:_titleText];
    
    UILabel *contentLab = [[UILabel alloc] init];
    [creatControls label:contentLab Name:@"添加描述" andFrame:CGRectMake(20, 110, 100, 20)];
    [self.view addSubview:contentLab];
    contentLab.textColor = [UIColor grayColor];
    contentLab.font = [UIFont systemFontOfSize:15];
    contentLab.textAlignment = NSTextAlignmentLeft;
    
    _contentText = [[UITextView alloc] initWithFrame:CGRectMake(20, 135, KSCREENWIDTH-40, 100)];
    _contentText.textColor = [UIColor blackColor];
    _contentText.delegate = self;
    [self.view addSubview:_contentText];
    
    
    UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 460, KSCREENWIDTH, 5)];
    line3.backgroundColor = [UIColor grayColor];
    line3.alpha = 0.3;
    [self.view addSubview:line3];
    
    
    UILabel *tagLab = [[UILabel alloc] init];
    [creatControls label:tagLab Name:@"至少添加一个标签" andFrame:CGRectMake(20, 475, 150, 20)];
    [self.view addSubview:tagLab];
    tagLab.textColor = [UIColor grayColor];
    tagLab.font = [UIFont systemFontOfSize:15];
    tagLab.textAlignment = NSTextAlignmentLeft;

    
#pragma mark 标签
    strArray = [NSMutableArray array];
    
    NSString * url = [NSString stringWithFormat:Main_URL,Tag_URL];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *array = responseObject[@"data"];
        
        for (int i = 0; i<array.count; i++) {
            [strArray addObject:array[i][@"name"]];
        }
        
        GBTagListView *tagList=[[GBTagListView alloc]initWithFrame:CGRectMake(10, 600, KSCREENWIDTH-20, 0)];
        
        //注意如果要自定义tag的颜色和整体的背景色定义方法一定要写在setTagWithTagArray方法之前
        tagList.canTouch=YES;
        tagList.signalTagColor=[UIColor grayColor];
        [tagList setTagWithTagArray:strArray];
        __weak __typeof(self)weakSelf = self;
        [tagList setDidselectItemBlock:^(NSMutableArray *arr) {
            _tagStr = [arr componentsJoinedByString:@","];
            NSLog(@"%@",_tagStr);
            
            [_tempTag removeFromSuperview];
            GBTagListView*selectItems=[[GBTagListView alloc]initWithFrame:CGRectMake(10,tagList.frame.origin.y-tagList.frame.size.height-60 , KSCREENWIDTH-20, 0)];
            selectItems.signalTagColor=COLOR(0, 124, 23, 1);
            selectItems.canTouch=NO;
            [selectItems setTagWithTagArray:arr];
            [weakSelf.view addSubview:selectItems];
            _tempTag=selectItems;
            
            
        }];
        [self.view addSubview:tagList];
        
        
        UILabel*tip=[[UILabel alloc]initWithFrame:CGRectMake(0, tagList.frame.origin.y-tagList.frame.size.height, KSCREENWIDTH, 20)];
        tip.text=@"热门标签";
        tip.textColor = [UIColor grayColor];
        tip.textAlignment=NSTextAlignmentCenter;
        tip.font=[UIFont boldSystemFontOfSize:18];
        [self.view addSubview:tip];
        
        UILabel *line4 = [[UILabel alloc] initWithFrame:CGRectMake(KSCREENWIDTH*0.5-65, tagList.frame.origin.y-tagList.frame.size.height+10, 20, 1)];
        line4.backgroundColor = [UIColor grayColor];
        line4.alpha = 0.6;
        [self.view addSubview:line4];
        
        
        UILabel *line5 = [[UILabel alloc] initWithFrame:CGRectMake(KSCREENWIDTH*0.5+45, tagList.frame.origin.y-tagList.frame.size.height+10, 20, 1)];
        line5.backgroundColor = [UIColor grayColor];
        line5.alpha = 0.6;
        [self.view addSubview:line5];
        

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败: %@",error);
    }];

    
    Image_MutabAry = [NSMutableArray array];
    //添加接受数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNO:) name:NOTIFICATION_NAME object:nil];
    
    
    //提示文字
    label = [[UILabel alloc]initWithFrame:CGRectMake(3, 6, 250, 20)];
    label.enabled = NO;
    label.text = @"最多输入140字";
    label.font =  [UIFont systemFontOfSize:15];
    label.textColor = [UIColor lightGrayColor];
    [_contentText addSubview:label];
    
    //提示还可以添加几张照片
    imagelabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 250, 150, 20)];
    imagelabel.text = @"添加照片 (0/9)";
    imagelabel.textColor = [UIColor grayColor];
    imagelabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:imagelabel];
    
    UILabel * line_label = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(imagelabel.frame), KSCREENWIDTH-20, 1)];
    line_label.backgroundColor = [UIColor grayColor];
    line_label.alpha = 0.6;
    [self.view addSubview:line_label];
    
    
    imagePickerView = [[LNImagePickerView alloc] initWithPointY:CGRectGetMaxY(line_label.frame)+10 target:self];
    imagePickerView.maxSelectCount = 9;
    imagePickerView.delegate = self;
    [imagePickerView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:imagePickerView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadImagelabel) name:@"tongzhigengxin" object:nil];
    
}

///更新几张图片
- (void)loadImagelabel
{
    if (imagePickerView.photoAssets.count>9)
    {
        imagelabel.text = @"添加照片 (9/9)";
    }
    else
    {
        // NSLog(@"通知接受已经选中了几个image--->>>%lu",(unsigned long)[imagePickerView photoAssets].count);
        imagelabel.text = [NSString stringWithFormat:@"添加照片 (%lu/9)",(unsigned long)[imagePickerView photoAssets].count];
        if (imagePickerView.photoAssets.count>9)
        {
            UIAlertView *tipAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"最多选取9张图片" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [tipAlert show];
            
            for (int i=0; i<imagePickerView.photoAssets.count; i++)
            {
                if (i==9)
                {
                    [imagePickerView.photoAssets removeObjectAtIndex:i];
                    
                }
            }
        }
    }
}

#pragma mark - LNImagePickerView Delegate
- (void)imagePickerView:(LNImagePickerView *)imagePickerView imageView:(UIImageView *)imageView
{
    NSLog(@"点击了第%ld张图片",imageView.tag);
    // [imageView removeFromSuperview];
    
    //[[imagePickerView photoAssets] removeObjectAtIndex:imageView.tag];
}


#pragma mark - TextView的代理方法
- (void) textViewDidChange:(UITextView *)textView    //添加限制
{
    if ([textView.text length] == 0)
    {
        [label setHidden:NO];
    }else
    {
        [label setHidden:YES];
    }
    
    NSInteger number = [textView.text length];
    if (number > 140)
    {
        UIAlertView *tipAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"字数超出限制" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [tipAlert show];
        textView.text = [textView.text substringToIndex:140];
        number = 140;
    }
    
}

//选择图片之后的回调
- (void)NSNO:(NSNotification *)notification
{
    NSLog(@"打印出通知是否发送--->>");
    if (imagePickerView.photoAssets.count>=9)
    {
        imagePickerView.userInteractionEnabled = NO;
        imagePickerView.imageView.image = [UIImage imageNamed:@""];
        Image_MutabAry = notification.object;
        
        for (int i=0; i<imagePickerView.photoAssets.count; i++)
        {
            if (i>=0)
            {
                [imagePickerView.photoAssets removeObjectAtIndex:i];
            }
        }
    }
    else
    {
        Image_MutabAry = notification.object;
        
    }
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_titleText resignFirstResponder];
    [_contentText resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
