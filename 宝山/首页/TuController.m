//
//  TuController.m
//  宝山
//
//  Created by 尤超 on 2017/5/8.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "TuController.h"
#import "YCHead.h"

@interface TuController ()<UIGestureRecognizerDelegate>{
    CGFloat _lastScale;
    UIImageView *_imageView;
    UIImageView *_imageView2;
   
    CGFloat _firstX;
    CGFloat _firstY;
    
    CGAffineTransform _oldTransform;
}

@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UIButton *btn2;



@end

@implementation TuController

- (void)rightItemClick {
    _imageView.transform = CGAffineTransformIdentity;
    _imageView2.transform = CGAffineTransformIdentity;
    _imageView.center = CGPointMake(KSCREENWIDTH*0.5, KSCREENHEIGHT*0.5+114/2);
    _imageView2.center = CGPointMake(KSCREENWIDTH*0.5, KSCREENHEIGHT*0.5+114/2);

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"展厅分布";
    
    
    UIView *rightButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 25)];
    UIButton *mainAndSearchBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 25)];
    [rightButtonView addSubview:mainAndSearchBtn];
    [mainAndSearchBtn setTitle:@"还原" forState:UIControlStateNormal];
    [mainAndSearchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [mainAndSearchBtn addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightCunstomButtonView = [[UIBarButtonItem alloc] initWithCustomView:rightButtonView];
    self.navigationItem.rightBarButtonItem = rightCunstomButtonView;

    
    
    NSString *url = [NSString stringWithFormat:Main_URL,Tu_URL];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 115, KSCREENWIDTH, KSCREENHEIGHT-114)];
            [img1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:Main_URL,responseObject[@"data"][0][@"img"]]]];
            [self.view addSubview:img1];
            _imageView = img1;
            _oldTransform = _imageView.transform;
            
            UIImageView *img2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 115, KSCREENWIDTH, KSCREENHEIGHT-114)];
            [img2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:Main_URL,responseObject[@"data"][1][@"img"]]]];
            [self.view addSubview:img2];
            _imageView2 = img2;
            _imageView2.hidden = YES;
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败: %@",error);
        
    }];

    
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 64, KSCREENWIDTH*0.5, 50)];
    [btn1 setTitle:@"1F" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
    [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn1.backgroundColor = COLOR(241, 242, 243, 1);
    [btn1 addTarget:self action:@selector(btn1Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    btn1.selected = YES;
    self.btn1 = btn1;
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(KSCREENWIDTH*0.5, 64, KSCREENWIDTH*0.5, 50)];
    [btn2 setTitle:@"2F" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
    [btn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn2.backgroundColor = COLOR(241, 242, 243, 1);
    [btn2 addTarget:self action:@selector(btn2Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    btn2.selected = NO;
    self.btn2 = btn2;
    
    UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 114, KSCREENWIDTH, 1)];
    line1.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line1];
    
    UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(KSCREENWIDTH*0.5, 74, 0.5, 30)];
    line2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line2];
    
    
    
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [panRecognizer setDelegate:self];
    [self.view addGestureRecognizer:panRecognizer];
    
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scale:)];
    [pinchRecognizer setDelegate:self];
    [self.view addGestureRecognizer:pinchRecognizer];

}

// 移动
-(void)move:(id)sender {
    
    CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        _firstX = [_imageView center].x;
        _firstY = [_imageView center].y;
    }
    
    translatedPoint = CGPointMake(_firstX+translatedPoint.x, _firstY+translatedPoint.y);
    
    [_imageView setCenter:translatedPoint];
    
    [_imageView2 setCenter:translatedPoint];
    
    
    
}

// 缩放
-(void)scale:(id)sender {
    
    if([(UIPinchGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        _lastScale = 1.0;
    }
    
    CGFloat scale = 1.0 - (_lastScale - [(UIPinchGestureRecognizer*)sender scale]);
    
    CGFloat scaleW = _imageView.frame.size.width/[UIScreen mainScreen].bounds.size.width;
    NSLog(@"%f",scaleW);
    
    
    CGAffineTransform currentTransform = _imageView.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
    
    [_imageView setTransform:newTransform];
    
    CGAffineTransform currentTransform2 = _imageView2.transform;
    CGAffineTransform newTransform2 = CGAffineTransformScale(currentTransform2, scale, scale);
    
    [_imageView2 setTransform:newTransform2];
    
    _lastScale = [(UIPinchGestureRecognizer*)sender scale];
        
    
}

- (void)btn1Click {
    self.btn1.selected = YES;
    self.btn2.selected = NO;
    
    
    _imageView.hidden = NO;
    _imageView2.hidden = YES;
    
    
    _imageView.transform = CGAffineTransformIdentity;
    _imageView2.transform = CGAffineTransformIdentity;
    _imageView.center = CGPointMake(KSCREENWIDTH*0.5, KSCREENHEIGHT*0.5+114/2);
    _imageView2.center = CGPointMake(KSCREENWIDTH*0.5, KSCREENHEIGHT*0.5+114/2);
}

- (void)btn2Click {
    self.btn1.selected = NO;
    self.btn2.selected = YES;
    
    _imageView.hidden = YES;
    _imageView2.hidden = NO;
    
    _imageView.transform = CGAffineTransformIdentity;
    _imageView2.transform = CGAffineTransformIdentity;
    _imageView.center = CGPointMake(KSCREENWIDTH*0.5, KSCREENHEIGHT*0.5+114/2);
    _imageView2.center = CGPointMake(KSCREENWIDTH*0.5, KSCREENHEIGHT*0.5+114/2);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
