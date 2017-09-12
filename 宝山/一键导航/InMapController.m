//
//  InMapController.m
//  宝山
//
//  Created by 尤超 on 2017/5/8.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "InMapController.h"
#import "YCHead.h"

@interface InMapController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UIGestureRecognizerDelegate>{
    
    UIView *_backView;
    UIView *_searchView;
    
    UIButton *_start;
    UIButton *_end;
    
    UITableView *_tableView;
    
    NSArray *_array;
    
    NSInteger _tag;
    
    NSString *_startID;
    
    NSString *_endID;
    
    UIImageView *_map;
    
    CGFloat _lastScale;
    CGFloat _firstX;
    CGFloat _firstY;
    
    CGAffineTransform _oldTransform;
}

@end

@implementation InMapController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"一键导航";
    
    
    UIView *leftButtonView = [[UIView alloc] initWithFrame:CGRectMake(-15, 0, 30, 30)];
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(-15, 0, 30, 30)];
    [leftButtonView addSubview:leftBtn];
    [leftBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftTtemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftCunstomButtonView = [[UIBarButtonItem alloc] initWithCustomView:leftButtonView];
    self.navigationItem.leftBarButtonItem = leftCunstomButtonView;

    
    UIView *rightButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [rightButtonView addSubview:rightBtn];
    [rightBtn setTitle:@"查询" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightTtemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightCunstomButtonView = [[UIBarButtonItem alloc] initWithCustomView:rightButtonView];
    self.navigationItem.rightBarButtonItem = rightCunstomButtonView;
    
    
    [self setUpUI];
}

- (void)setUpUI {
    
    _map = [[UIImageView alloc] init];
    _map.image = [UIImage imageNamed:@"bg"];
    _map.frame = self.view.frame;
    [self.view addSubview:_map];
    
   
    _backView = [[UIView alloc] init];
    _backView.frame = self.view.frame;
    _backView.backgroundColor = COLOR(0, 0, 0, 0.3);
    [self.view addSubview:_backView];
    
    _searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 500*KSCREENHEIGHT/667, KSCREENWIDTH, KSCREENHEIGHT-500*KSCREENHEIGHT/667)];
    _searchView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_searchView];
    
    
    UIImageView *back = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, KSCREENWIDTH-20, 100)];
    back.image = [UIImage imageNamed:@"oneback"];
    back.layer.masksToBounds = YES;
    back.layer.cornerRadius = 5;
    [_searchView addSubview:back];
    
    
    _start = [[UIButton alloc] initWithFrame:CGRectMake(150, 0, KSCREENWIDTH-160, 50)];
    _start.backgroundColor = [UIColor clearColor];
    [_start setTitle:nil forState:UIControlStateNormal];
    [_start  setTitleColor:COLOR(0, 125, 23, 1) forState:UIControlStateNormal];
    [_start addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _start.tag = 100;
    [_searchView addSubview:_start];
    
    
    
    _end = [[UIButton alloc] initWithFrame:CGRectMake(150, 50, KSCREENWIDTH-160, 50)];
    _end.backgroundColor = [UIColor clearColor];
    [_end setTitle:nil forState:UIControlStateNormal];
    [_end  setTitleColor:COLOR(0, 125, 23, 1) forState:UIControlStateNormal];
    [_end addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _end.tag = 200;
    [_searchView addSubview:_end];

    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 110, KSCREENWIDTH-20, 40)];
    btn.backgroundColor = COLOR(242, 243, 244, 1);
    [btn setTitle:@"查询" forState:UIControlStateNormal];
    [btn setTitleColor:COLOR(0, 125, 23, 1) forState:UIControlStateNormal];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5;
    [btn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_searchView addSubview:btn];
    
    
    _array = [NSArray array];
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(KSCREENWIDTH*0.5, 200*KSCREENHEIGHT/667, KSCREENWIDTH*0.5-10, 300*KSCREENHEIGHT/667) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = COLOR(242, 243, 244, 1);
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.hidden = YES;
    
    NSString *url = [NSString stringWithFormat:Main_URL,Point_URL];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        _array = responseObject[@"data"];
        
        [_tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
  
    _oldTransform = _map.transform;
    
    _startID = [NSString string];
    _endID = [NSString string];
    
    
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
        _firstX = [_map center].x;
        _firstY = [_map center].y;
    }
    
    translatedPoint = CGPointMake(_firstX+translatedPoint.x, _firstY+translatedPoint.y);
    
    [_map setCenter:translatedPoint];
    
    
}

// 缩放
-(void)scale:(id)sender {
    
    if([(UIPinchGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        _lastScale = 1.0;
    }
    
    CGFloat scale = 1.0 - (_lastScale - [(UIPinchGestureRecognizer*)sender scale]);
    
    CGFloat scaleW = _map.frame.size.width/[UIScreen mainScreen].bounds.size.width;
    NSLog(@"%f",scaleW);
    
    
    CGAffineTransform currentTransform = _map.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
    
    [_map setTransform:newTransform];
    
    _lastScale = [(UIPinchGestureRecognizer*)sender scale];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = _array[indexPath.row][@"title"];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _tableView.hidden = YES;
    
    
    if (_tag == 100) {
        [_start setTitle:_array[indexPath.row][@"title"] forState:UIControlStateNormal];
        
        _startID = [NSString stringWithFormat:@"%@",_array[indexPath.row][@"id"]];
        
    } else if (_tag == 200) {
        [_end setTitle:_array[indexPath.row][@"title"] forState:UIControlStateNormal];
        
        _endID  = [NSString stringWithFormat:@"%@",_array[indexPath.row][@"id"]];
    }
    
    
}

- (void)btnClick:(UIButton *)sender {
    _tableView.hidden = NO;
    
    if (sender.tag == 100) {
        _tag = 100;
    } else if (sender.tag == 200) {
        _tag = 200;
    }
}


- (void)searchBtnClick {
    if ([_start.titleLabel.text isEqualToString:_end.titleLabel.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请选择不同的起点终点" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    } else if (_start.titleLabel.text == nil || _end.titleLabel.text == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请选择起点或终点" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    } else {
    
        NSString *url = [NSString stringWithFormat:Main_URL,DH_URL];
        
        NSDictionary *dic = @{@"spoint":_startID,
                              @"epoint":_endID};
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if ([responseObject[@"code"] isEqualToString:@"200"]) {
                _backView.hidden = YES;
                _searchView.hidden = YES;
                
                [_map sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:Main_URL,responseObject[@"data"][@"img"]]]];
            }
           
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];

    }
    
    
}

- (void)leftTtemClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)rightTtemClick {
    _backView.hidden = NO;
    _searchView.hidden = NO;
    
    _map.transform = CGAffineTransformIdentity;
    _map.center = CGPointMake(KSCREENWIDTH*0.5, KSCREENHEIGHT*0.5);
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
