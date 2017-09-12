//
//  YCNewFeatureController.m
//  常熟智能汽车三折屏
//
//  Created by 尤超 on 17/4/25.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "YCNewFeatureController.h"
#import "LoginController.h"

#define YCNewFeatureCount 3

@interface YCNewFeatureController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIPageControl *pageControl;

@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation YCNewFeatureController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    
    scrollView.frame = self.view.bounds;
    
    [self.view addSubview:scrollView];
    
    self.scrollView = scrollView;
    
    CGFloat scrollW = scrollView.frame.size.width;
    
    CGFloat scrollH = scrollView.frame.size.height;
    
    for (int i = 0; i < YCNewFeatureCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        
        CGFloat imageViewX = i * scrollW;
        CGFloat imageViewY = 0;
        CGFloat imageViewW = scrollW;
        CGFloat imageViewH = scrollH;
        imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
        NSString *name = [NSString stringWithFormat:@"new_feature_%d", i + 1];
        imageView.image = [UIImage imageNamed:name];
        [scrollView addSubview:imageView];
        // 如果是最后一个imageView，就往里面添加其他内容
        if (i == YCNewFeatureCount - 1) {
            [self setupLastImageView:imageView];
        }
    }
    scrollView.contentSize = CGSizeMake(YCNewFeatureCount * scrollW, 0);
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    
    // PageControl 进行数据分页
    
    UIPageControl *pageController = [[UIPageControl alloc] init];
    pageController.numberOfPages = YCNewFeatureCount;
    pageController.backgroundColor = [UIColor redColor];
    pageController.currentPageIndicatorTintColor = [UIColor whiteColor                                                     ];
    pageController.pageIndicatorTintColor = [UIColor grayColor];
    CGPoint center = CGPointZero;
    center.x = scrollW * 0.5;
    center.y = scrollH - 50;
    //    pageController.userInteractionEnabled = NO;
    pageController.bounds = CGRectZero;
    pageController.backgroundColor = [UIColor redColor];
    pageController.center = center;
    [self.view addSubview:pageController];
    self.pageControl = pageController;
    // Do any additional setup after loading the view.
    
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    double page = scrollView.contentOffset.x / scrollView.frame.size.width;
    // 1.5 + 0.5  => 2
    // 1.1 + 0.5  => 1
    // 1.6 + 0.5  => 2
    self.pageControl.currentPage = (int)(page + 0.5);
}

- (void)setupLastImageView:(UIImageView *)imageView {
    // 开启交互功能
    imageView.userInteractionEnabled = YES;
    

    //开始
    UIButton *startBtn = [[UIButton alloc] init];
    startBtn.frame = self.view.frame;
    startBtn.backgroundColor = [UIColor clearColor];
    [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startBtn];

 
}

- (void)startClick {
    LoginController *VC = [[LoginController alloc] init];
    [self presentViewController:VC animated:YES completion:nil];
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
