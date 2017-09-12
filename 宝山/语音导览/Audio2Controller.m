//
//  Audio2Controller.m
//  宝山
//
//  Created by 尤超 on 2017/5/5.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "Audio2Controller.h"
#import "YCHead.h"
#import "AudioModel.h"
#import "AudioCell.h"
#import "MusicModel.h"
#import "AudioPlayerController.h"

@interface Audio2Controller ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSMutableArray * _array;
    
}
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *songArray;

@end

@implementation Audio2Controller

- (NSMutableArray *)songArray
{
    if (!_songArray) {
        _songArray = [NSMutableArray array];
    }
    return _songArray;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    NSString *url = [NSString stringWithFormat:Main_URL,VoiceList_URL];
    
    
    
    NSDictionary *dic = @{@"pid":self.ID};
    
    NSLog(@"%@~~~~%@",url,self.ID);
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        _array = [responseObject[@"data"][@"result"] mutableCopy];
        
        NSLog(@"!!!!%@",_array);
        
        for (NSDictionary *dic in _array) {
            MusicModel *model = [[MusicModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.songArray addObject:model];
            
        }
        
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"展厅导览";
    _array = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    //注册表格单元
    [self.tableView registerClass:[AudioCell class] forCellReuseIdentifier:audioIndentifier];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = _array[indexPath.row];
    
    
    AudioModel *model = [AudioModel audioWithDict:dic];
    
    AudioCell *cell = [tableView dequeueReusableCellWithIdentifier:audioIndentifier];
    
    //传递模型给cell
    cell.audioModel = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = [[UIView alloc] init];
    cell.selectedBackgroundView.frame = cell.frame;
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    return cell;
    
}

//Cell点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    AudioPlayerController *audio = [AudioPlayerController audioPlayerController];
    [audio initWithArray:self.songArray index:indexPath.row];
    [self.navigationController pushViewController:audio animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 250;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
