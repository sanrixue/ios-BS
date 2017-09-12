//
//  ActivityController.m
//  宝山城市规划馆
//
//  Created by YC on 16/11/17.
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

#import "ActivityController.h"
#import "YCHead.h"  
#import "ActivityModel.h"
#import "ActivityCell.h"

@interface ActivityController ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSMutableArray * _array;
    
}
@property (nonatomic, strong) UITableView *tableView;

@end



@implementation ActivityController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    NSString *url = [NSString stringWithFormat:Main_URL,[NSString stringWithFormat:ActiveList_URL,1]];
    
    NSLog(@"%@",url);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        _array = [responseObject[@"data"][@"result"] mutableCopy];
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"活动信息";
    
    self.view.backgroundColor = [UIColor whiteColor];
    

    _array = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    //注册表格单元
    [self.tableView registerClass:[ActivityCell class] forCellReuseIdentifier:activityIndentifier];
    
 
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = _array[indexPath.row];
    
    ActivityModel *activityModel = [ActivityModel activityWithDict:dic];
    
    
    
    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:activityIndentifier];
    
    //传递模型给cell
    cell.activityModel = activityModel;
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = [[UIView alloc] init];
    cell.selectedBackgroundView.frame = cell.frame;
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    return cell;
    
}

//Cell点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
