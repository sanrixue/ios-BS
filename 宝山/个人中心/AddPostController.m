//
//  AddPostController.m
//  宝山城市规划馆
//
//  Created by YC on 16/11/18.
//
//
/**
 ———————————————————————————————————————————————————————————
 |--------------------------_ooOoo_------------------------|
 |------------------------o888888888o----------------------|
 |------------------------88"" . ""88----------------------|
 |------------------------(|  - -  |)----------------------|
 |------------------------0\   =   /0----------------------|
 |------------------------_/` --- '\____-------------------|
 |-------------------.'  \\|       |//  `. ----------------|
 |------------------/  \\|||   :   |||//  \ ---------------|
 |---------------- /  _|||||  -:-  |||||-  \---------------|
 |---------------- |   | \\\   -   /// |   |---------------|
 |---------------- | \_|  ``\ --- /''  |   |---------------|
 |---------------- \  .-\__   `-'   ___/-. / --------------|
 |--------------___ `. . '  /--.--\  '. . __---------------|
 |-----------.""  '<  `.___ \_<|>_/___.'  >'"". -----------|
 |----------| | :   `- \`.;` \ _ /`;.`/ - ` : | |----------|
 |----------\  \ `-.    \_  __\ /__ _/   .-` /  /----------|
 |===========`-.____`-.___ \______/___.-`____.-'===========|
 |--------------------------`=---='------------------------|
 |^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^|
 |------佛祖保佑 --------------永无BUG-----------永不修改------|
 */

#import "AddPostController.h"
#import "GBTagListView.h"
#import "YCHead.h"


@implementation AddPostController{
    
    NSArray*strArray;//保存标签数据的数组
    GBTagListView*_tempTag;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    CreatControls *creatControls = [[CreatControls alloc] init];
    

    //添加label
    UILabel *titleLab = [[UILabel alloc] init];
    [creatControls label:titleLab Name:@"添加标题" andFrame:CGRectMake(20, 60, 100, 20)];
    [self.view addSubview:titleLab];
    titleLab.textColor = [UIColor grayColor];
    titleLab.textAlignment = NSTextAlignmentLeft;
    
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(20, 95, KSCREENWIDTH-20, 1)];
    line.backgroundColor = [UIColor grayColor];
    line.alpha = 0.6;
    [self.view addSubview:line];
    
    
    UILabel *contentLab = [[UILabel alloc] init];
    [creatControls label:contentLab Name:@"添加描述" andFrame:CGRectMake(20, 110, 100, 20)];
    [self.view addSubview:contentLab];
    contentLab.textColor = [UIColor grayColor];
    contentLab.textAlignment = NSTextAlignmentLeft;
    
    
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 240, KSCREENWIDTH-20, 1)];
    line2.backgroundColor = [UIColor grayColor];
    line2.alpha = 0.6;
    [self.view addSubview:line2];
    
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(20, 250, 80, 80)];
    image.image = [UIImage imageNamed:@"postBack.png"];
    [self.view addSubview:image];
    
    
    
    UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 340, KSCREENWIDTH, 8)];
    line3.backgroundColor = [UIColor grayColor];
    line3.alpha = 0.3;
    [self.view addSubview:line3];
    
    
    UILabel *tagLab = [[UILabel alloc] init];
    [creatControls label:tagLab Name:@"至少添加一个标签" andFrame:CGRectMake(20, 360, 150, 20)];
    [self.view addSubview:tagLab];
    tagLab.textColor = [UIColor grayColor];
    tagLab.textAlignment = NSTextAlignmentLeft;

    
    
    strArray=@[@"活动",@"摄影",@"开幕式",@"双十一",@"线上活动",@"艺术"];
    
    GBTagListView *tagList=[[GBTagListView alloc]initWithFrame:CGRectMake(0, 530, KSCREENWIDTH, 0)];
    
    //注意如果要自定义tag的颜色和整体的背景色定义方法一定要写在setTagWithTagArray方法之前
    tagList.canTouch=YES;
    tagList.signalTagColor=COLOR(231, 196, 128, 1);
    [tagList setTagWithTagArray:strArray];
    __weak __typeof(self)weakSelf = self;
    [tagList setDidselectItemBlock:^(NSArray *arr) {
        NSLog(@"%@",arr);
        [_tempTag removeFromSuperview];
        GBTagListView*selectItems=[[GBTagListView alloc]initWithFrame:CGRectMake(0,tagList.frame.origin.y-tagList.frame.size.height-60 , KSCREENWIDTH, 0)];
        selectItems.signalTagColor=COLOR(231, 196, 128, 1);
        selectItems.canTouch=NO;
        [selectItems setTagWithTagArray:arr];
        [weakSelf.view addSubview:selectItems];
        _tempTag=selectItems;
        
        
    }];
    [self.view addSubview:tagList];
    
    
    UILabel*tip=[[UILabel alloc]initWithFrame:CGRectMake(0, tagList.frame.origin.y-tagList.frame.size.height+20, KSCREENWIDTH, 20)];
    tip.text=@"热门标签";
    tip.textColor = [UIColor grayColor];
    tip.textAlignment=NSTextAlignmentCenter;
    tip.font=[UIFont boldSystemFontOfSize:18];
    [self.view addSubview:tip];
    
    UILabel *line4 = [[UILabel alloc] initWithFrame:CGRectMake(KSCREENWIDTH*0.5-65, tagList.frame.origin.y-tagList.frame.size.height+30, 20, 1)];
    line4.backgroundColor = [UIColor grayColor];
    line4.alpha = 0.6;
    [self.view addSubview:line4];
    
    
    UILabel *line5 = [[UILabel alloc] initWithFrame:CGRectMake(KSCREENWIDTH*0.5+45, tagList.frame.origin.y-tagList.frame.size.height+30, 20, 1)];
    line5.backgroundColor = [UIColor grayColor];
    line5.alpha = 0.6;
    [self.view addSubview:line5];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
