//
//  PersonalController.m
//  宝山
//
//  Created by 尤超 on 17/4/12.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "PersonalController.h"
#import "YCHead.h"
#import "UserModel.h"
#import "UIButton+ImageTitleSpacing.h"
#import "PersonInfoViewController.h"
#import "PTicketController.h"
#import "PCollectController.h"
#import "PActivityController.h"
#import "PMessageController.h"
#import "MyEXController.h"
#import "MyPostController.h"

@interface PersonalController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    
    NSArray *_titles;
    
    NSArray *_images;
    
    //头试图
    UIView *_headerView;
    
    //头像
    UIImageView *_imageview;
    
    //名字和手机号
    UILabel *_label1;
    UILabel *_label2;
    
    //线
    UILabel *_lineLab;
    
    //门票预约，活动，收藏，消息
    UIButton *_btn;
    UIButton *_btn2;
    UIButton *_btn3;
    UIButton *_btn4;
    
    //背景底图片
    UIImageView *_headimageView;
    
    
    //二维码
    UIView *_backView;
    UIView *_QRView;
    
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *cacheLab;

@end

@implementation PersonalController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"个人中心";
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _titles = @[@"我的发布",@"我的展项",@"我的二维码",@"清除缓存"];
    
    _images = @[@"p1",@"p2", @"p3", @"p4"];
    
    
    [self createTableView];
    
    self.cacheLab = [[UILabel alloc] initWithFrame:CGRectMake(KSCREENWIDTH-115, 404*KSCREENHEIGHT/667, 100, 50)];
    self.cacheLab.backgroundColor = [UIColor clearColor];
    self.cacheLab.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:self.cacheLab];
    
    double size = [[SDImageCache sharedImageCache] getSize] / 1000.0 / 1000.0;
    NSString * cache_Str = [NSString stringWithFormat:@"%.2fM",size];
    self.cacheLab.text = cache_Str;
    
    
    _backView = [[UIView alloc] init];
    _backView.frame = self.view.frame;
    _backView.backgroundColor = COLOR(0, 0, 0, 0.4);
    [self.view addSubview:_backView];
    _backView.hidden = YES;
    
    
    _QRView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280*KSCREENHEIGHT/667, 350*KSCREENHEIGHT/667)];
    _QRView.center = self.view.center;
    _QRView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_QRView];
    _QRView.hidden = YES;
    
    UIImageView *QRicon = [[UIImageView alloc] initWithFrame:CGRectMake(15*KSCREENHEIGHT/667, 50*KSCREENHEIGHT/667, 250*KSCREENHEIGHT/667, 250*KSCREENHEIGHT/667)];
    [_QRView addSubview:QRicon];
    
    
    
    DBManager *model = [[DBManager sharedManager] selectOneModel];
    NSMutableArray *mutArray = [NSMutableArray array];
    [mutArray addObject:model];
    UserModel *userModel = mutArray[0];
    
   [QRicon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:Main_URL,[NSString stringWithFormat:@"res/upload/%@",userModel.user_QRcode]]]];
   
}

//创建表示图
-(void)createTableView{
    
    if (_tableView==nil) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT) style:UITableViewStylePlain];
    }
    
    _tableView.dataSource=self;
    _tableView.delegate=self;
    
    _tableView.tableFooterView = [UIView new];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    _tableView.scrollEnabled = NO;
    
    
    [self.view addSubview:_tableView];
    
}

//显示多少数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _titles.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50 * KSCREENWIDTH / 375.0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    
    
    if (indexPath.row == 3) {
         cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
    
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = _titles[indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:_images[indexPath.row]];
    return cell;
}

//点击跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    NSString *title = cell.textLabel.text;
    if ([title isEqualToString:@"我的发布"]) {
        MyPostController *VC = [[MyPostController alloc] init];
        
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if ([title isEqualToString:@"我的展项"]){
        MyEXController *VC = [[MyEXController alloc] init];
        
        [self.navigationController pushViewController:VC animated:YES];
        
        
        
    }else if ([title isEqualToString:@"我的二维码"]){
        _QRView.hidden = NO;
        _backView.hidden = NO;
        
        
    }else if ([title isEqualToString:@"清除缓存"]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"是否清除缓存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: @"确定", nil];
    
        [alert show];
        
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _QRView.hidden = YES;
    _backView.hidden = YES;
}


//清除缓存
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSLog(@"取消清除缓存");
        return;
    } else {
        NSLog(@"清除缓存");
        //清楚缓存
        [[SDImageCache sharedImageCache] clearMemory];
        //清楚磁盘缓存
        [[SDImageCache sharedImageCache] clearDisk];
        
        self.cacheLab.text = @"0M";
    }
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return (190+64) * KSCREENWIDTH/375.0;
    } else{
        
        return 1 * KSCREENWIDTH/375.0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
        
        //头像视图
        if (_headerView == nil) {
            
            _headerView  = [[UIView alloc] init];
            
            
            _headimageView = [[UIImageView alloc]init];
            
            [_headerView addSubview:_headimageView];
            [_headimageView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.edges.equalTo(_headerView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
                
            }];
            
           
            
            
            _imageview = [[UIImageView alloc]init];
            
            [_headerView addSubview:_imageview];
            
            
            _imageview.layer.cornerRadius = 100*0.5*KSCREENWIDTH/375.0;
            _imageview.layer.masksToBounds = YES;
            _imageview.layer.borderWidth = 4*KSCREENWIDTH/375.0;
            _imageview.layer.borderColor = [UIColor whiteColor].CGColor;
            
            
            
            [_imageview mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.mas_equalTo(_headerView.mas_left).offset(10*KSCREENWIDTH/375.0);
                make.centerY.mas_equalTo(_headerView.mas_top).offset((64+10+50)*KSCREENWIDTH/375.0);
                make.size.mas_equalTo(CGSizeMake(100*KSCREENWIDTH/375.0, 100*KSCREENWIDTH/375.0));
            }];
            
            _imageview.userInteractionEnabled = YES;
            
            UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureHandle:)];
            
            //添加给label
            [_imageview addGestureRecognizer:tgr];
            
            
            
            
            _label1 = [[UILabel alloc]init];
            [_headerView addSubview:_label1];
            
            
            _label1.numberOfLines = 0;
            _label1.textColor = [UIColor blackColor];
            _label1.font = [UIFont systemFontOfSize:16];
            _label1.textAlignment = NSTextAlignmentLeft;
            [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.mas_equalTo(_imageview.mas_centerY).offset(-15*KSCREENWIDTH/375.0);
                make.left.mas_equalTo(_imageview.mas_right).offset(20);
                make.size.mas_equalTo(CGSizeMake(120, 25));
            }];
            
            
            _label2 = [[UILabel alloc]init];
            [_headerView addSubview:_label2];
            
            
            _label2.numberOfLines = 0;
            _label2.textColor = [UIColor grayColor];
            _label2.font = [UIFont systemFontOfSize:14];
            _label2.textAlignment = NSTextAlignmentLeft;
            [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.mas_equalTo(_imageview.mas_right).offset(20);
                make.top.mas_equalTo(_label1.mas_bottom).offset(10);
                make.size.mas_equalTo(CGSizeMake(180, 25));
            }];
            
            
            //底背景图片
            _headimageView.image = [UIImage imageNamed:@"back"];
            
            
            //添加线
            _lineLab = [[UILabel alloc] init];
            _lineLab.backgroundColor = COLOR(236, 235, 235, 1);
            [_headerView addSubview:_lineLab];
            [_lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(_headerView.mas_centerX);
                make.top.mas_equalTo(_imageview.mas_bottom).offset(10);
                make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH, 1));
            }];
            
            
            UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 244*KSCREENHEIGHT/667, KSCREENWIDTH, 9)];
            lineLab.backgroundColor = COLOR(236, 235, 235, 1);
            [_headerView addSubview:lineLab];
            
            //添加button
            _btn = [[UIButton alloc] initWithFrame:CGRectMake(20*KSCREENHEIGHT/667, 184*KSCREENHEIGHT/667, 80, 60)];
            [_btn setTitle:@"门票预约" forState:UIControlStateNormal];
            _btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [_btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [_btn setImage:[UIImage imageNamed:@"table1"] forState:UIControlStateNormal];
            [_btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:0];
            [_btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
            [_headerView addSubview:_btn];
            
            
            _btn2 = [[UIButton alloc] initWithFrame:CGRectMake(110*KSCREENHEIGHT/667, 184*KSCREENHEIGHT/667, 80, 60)];
            [_btn2 setTitle:@"活动" forState:UIControlStateNormal];
            _btn2.titleLabel.font = [UIFont systemFontOfSize:15];
            [_btn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [_btn2 setImage:[UIImage imageNamed:@"table2"] forState:UIControlStateNormal];
            [_btn2 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:0];
            [_btn2 addTarget:self action:@selector(btn2Click) forControlEvents:UIControlEventTouchUpInside];
            [_headerView addSubview:_btn2];
            
            _btn3 = [[UIButton alloc] initWithFrame:CGRectMake(200*KSCREENHEIGHT/667, 184*KSCREENHEIGHT/667, 80, 60)];
            [_btn3 setTitle:@"收藏" forState:UIControlStateNormal];
            _btn3.titleLabel.font = [UIFont systemFontOfSize:15];
            [_btn3 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [_btn3 setImage:[UIImage imageNamed:@"table3"] forState:UIControlStateNormal];
            [_btn3 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:0];
            [_btn3 addTarget:self action:@selector(btn3Click) forControlEvents:UIControlEventTouchUpInside];
            [_headerView addSubview:_btn3];
            
            _btn4 = [[UIButton alloc] initWithFrame:CGRectMake(290*KSCREENHEIGHT/667, 184*KSCREENHEIGHT/667, 80, 60)];
            [_btn4 setTitle:@"消息" forState:UIControlStateNormal];
            _btn4.titleLabel.font = [UIFont systemFontOfSize:15];
            [_btn4 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [_btn4 setImage:[UIImage imageNamed:@"table4"] forState:UIControlStateNormal];
            [_btn4 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:0];
            [_btn4 addTarget:self action:@selector(btn4Click) forControlEvents:UIControlEventTouchUpInside];
            [_headerView addSubview:_btn4];
            
        }
        
        
        DBManager *model = [[DBManager sharedManager] selectOneModel];
        NSMutableArray *mutArray = [NSMutableArray array];
        [mutArray addObject:model];
        UserModel *userModel = mutArray[0];
        
        //读取图片
        NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_user",userModel.user_id]];
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:fullPath];
        
        if (image) {
            _imageview.image = image;
            
        } else if ([[NSString stringWithFormat:@"%@",userModel.user_logo] isEqualToString:@"(null)"]) {
            _imageview.image = [UIImage imageNamed:@"default"];
            
        } else {
            [_imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:Main_URL,userModel.user_logo]]];
        }
        
        
        if ([[NSString stringWithFormat:@"%@",userModel.user_name] isEqualToString:@"(null)"]) {
            _label1.text = @"某某某";
            
        } else {
            _label1.text = userModel.user_name;
        }
       
        _label2.text = [NSString stringWithFormat:@"手机号  %@",userModel.user_phone];
        
        return _headerView;
        
    }else{
        
        return nil;
    }
    
}

- (void)btnClick {
    PTicketController *TVC = [[PTicketController alloc] init];
    
    [self.navigationController pushViewController:TVC animated:YES];
    
}

- (void)btn2Click {
    PActivityController *AVC = [[PActivityController alloc] init];
    
    [self.navigationController pushViewController:AVC animated:YES];
    
}

- (void)btn3Click {
    PCollectController *CVC = [[PCollectController alloc] init];
    
    [self.navigationController pushViewController:CVC animated:YES];
    
}

- (void)btn4Click {
    PMessageController *MVC = [[PMessageController alloc] init];
    
    [self.navigationController pushViewController:MVC animated:YES];
    
}

- (void)tapGestureHandle:(UITapGestureRecognizer *)tgr{
    NSLog(@"点击头像");
    
    PersonInfoViewController *personInfoController = [[PersonInfoViewController alloc] init];
    
    CATransition *trasition = [CATransition animation];
    trasition.duration = 1;
    [trasition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    trasition.type = @"rippleEffect";
    [self.navigationController.view.layer addAnimation:trasition forKey:@"animation"];
    
    [self.navigationController pushViewController:personInfoController animated:YES];
    
    [personInfoController returnBlock:^(NSString *nameText, UIImage *iconImage) {
        _imageview.image = iconImage;
        _label1.text = nameText;
    }];
    
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat width = self.view.frame.size.width; // 图片宽度
    
    CGFloat yOffset = scrollView.contentOffset.y; // 偏移的y值
    
    if (yOffset < 0) {
        
        CGFloat totalOffset = ((180*(KSCREENWIDTH/375.0)+64*(KSCREENWIDTH/375.0)) + ABS(yOffset));
        
        CGFloat f = (totalOffset / (180*(KSCREENWIDTH/375.0)+64*(KSCREENWIDTH/375.0)));
        
        _headimageView.frame =CGRectMake(- (width * f - width) / 2, yOffset, width * f, totalOffset); //拉伸后的图片的frame应该是同比例缩放。
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

