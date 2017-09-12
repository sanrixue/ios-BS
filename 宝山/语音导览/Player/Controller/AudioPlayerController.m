//
//  AudioPlayerController.m
//  AudioPlayer
//
//  Created by ClaudeLi on 16/4/1.
//  Copyright © 2016年 ClaudeLi. All rights reserved.
//

#import "AudioPlayerController.h"
#import "AudioPlayerController+methods.h"
#import "NSString+time.h"

@interface AudioPlayerController ()<UIWebViewDelegate>{
    AVPlayerItem *playerItem;
    id _playTimeObserver; // 播放进度观察者
    NSArray *_modelArray; // 歌曲数组
    NSArray *_randomArray; //随机数组
    NSInteger _index; // 播放标记
    BOOL isPlaying; // 播放状态
    BOOL isRemoveNot; // 是否移除通知
    AudioPlayerMode _playerMode; // 播放模式

    MusicModel *_playingModel; // 正在播放的model
    CGFloat _totalTime; // 总时间
    
    
    UILabel *_title;
    
   
}
@property (weak, nonatomic) IBOutlet UISlider *paceSlider; // 进度条
@property (weak, nonatomic) IBOutlet UIButton *playButton; // 播放按钮
@property (weak, nonatomic) IBOutlet UILabel *playingTime; // 当前播放时间Label
@property (weak, nonatomic) IBOutlet UILabel *maxTime; // 总时间Label

@property (nonatomic, strong) AVPlayer *player;

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) NSString *ID;

@end

static AudioPlayerController *audioVC;
@implementation AudioPlayerController

+(AudioPlayerController *)audioPlayerController{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        audioVC = [[AudioPlayerController alloc] init];
        audioVC.view.backgroundColor = [UIColor whiteColor];
        audioVC.player = [[AVPlayer alloc]init];
        //后台播放
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    });
    return audioVC;
}

- (void)rightItemClick {
    DBManager *model = [[DBManager sharedManager] selectOneModel];
    NSMutableArray *mutArray = [NSMutableArray array];
    [mutArray addObject:model];
    UserModel *userModel = mutArray[0];
    
    
    NSString *url = [NSString stringWithFormat:Main_URL,AddCollection_URL];
    
    NSLog(@"%@",url);
    
    NSDictionary *dic = @{@"fkId":self.ID,
                          @"type":@"5",
                          @"uid":userModel.user_id};
    
    NSLog(@"%@",dic);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        
        [self showMessegeForResult:responseObject[@"msg"]];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"语音导览详情";
    
    
    UIView *rightButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    UIButton *mainAndSearchBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [rightButtonView addSubview:mainAndSearchBtn];
    [mainAndSearchBtn setImage:[UIImage imageNamed:@"xin1"] forState:UIControlStateNormal];
    [mainAndSearchBtn addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightCunstomButtonView = [[UIBarButtonItem alloc] initWithCustomView:rightButtonView];
    self.navigationItem.rightBarButtonItem = rightCunstomButtonView;
    
    
    self.ID = [NSString string];
    
    
    [self.paceSlider setThumbImage:[UIImage imageNamed:@"Slider_控制点"] forState:UIControlStateNormal];
    [self creatViews];
    
    _title = [[UILabel alloc] initWithFrame:CGRectMake(0, 275*KSCREENHEIGHT/667, KSCREENWIDTH, 30)];
    _title.textColor = [UIColor whiteColor];
    _title.textAlignment = NSTextAlignmentCenter;
    _title.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:_title];
    
   
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(20, 310*KSCREENHEIGHT/667, KSCREENWIDTH-40, 200*KSCREENHEIGHT/667)];
    self.webView.dataDetectorTypes = UIDataDetectorTypeAll;
    [self.view addSubview:self.webView];
    self.webView.scrollView.bounces = NO;
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self setRotatingViewFrame];
}

- (void)initWithArray:(NSArray *)array index:(NSInteger)index{
    _index = index;
    _modelArray = array;
    _randomArray = nil;
    [self updateAudioPlayer];
}

- (void)updateAudioPlayer{
    if (isRemoveNot) {
        // 如果已经存在 移除通知、KVO，各控件设初始值
        [self removeObserverAndNotification];
        [self initialControls];
        isRemoveNot = NO;
    }
    MusicModel *model;
    
    // 判断是不是随机播放
    if (_playerMode == AudioPlayerModeRandomPlay) {
        // 如果是随机播放，判断随机数组是否有值
        if (_randomArray.count == 0) {
            // 如果随机数组没有值，播放当前音乐并给随机数组赋值
            model = [_modelArray objectAtIndex:_index];
            _randomArray = [_modelArray sortedArrayUsingComparator:(NSComparator)^(id obj1, id obj2) {
                return arc4random() % _modelArray.count;
            }];
        }else{
            // 如果随机数组有值，从随机数组取值
            model = [_randomArray objectAtIndex:_index];
        }
    }else{
        model = [_modelArray objectAtIndex:_index];
    }
    _playingModel = model;
    // 更新界面歌曲信息：歌名，歌手，图片
    [self updateUIDataWith:model];
    

    
    playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:[NSString stringWithFormat:Main_URL,model.voice_path]]];
    
    
    [self.player replaceCurrentItemWithPlayerItem:playerItem];
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];// 监听status属性
    [self monitoringPlayback:playerItem];// 监听播放状态
    [self addEndTimeNotification];
    isRemoveNot = YES;
}

// 各控件设初始值
- (void)initialControls{
    [self stop];
    self.playingTime.text = @"00:00";
    self.paceSlider.value = 0.0f;
    [self.rotatingView removeAnimation];
}


- (void)updateUIDataWith:(MusicModel *)model{
    
    self.ID = model.mid;
    NSLog(@"~~~~~~~~~%@",self.ID);

    
    NSString *url = [NSString stringWithFormat:Main_URL,[NSString stringWithFormat:Addread_URL,self.ID]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"!!!!!!!!!!!!!!!!%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

    
    
    _title.text = [NSString stringWithFormat:@"%@-%@",model.etitle,model.title];
    
    [self.webView loadHTMLString:model.content baseURL:nil];
    
    [self setImageWith:model];
}

#pragma mark - KVO - status
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    AVPlayerItem *item = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]) {
        if ([playerItem status] == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayerStatusReadyToPlay");
            CMTime duration = item.duration;// 获取视频总长度
            [self setMaxDuratuin:CMTimeGetSeconds(duration)];
            [self play];
        }else if([playerItem status] == AVPlayerStatusFailed) {
            NSLog(@"AVPlayerStatusFailed");
            [self stop];
        }
    }
}

- (void)setMaxDuratuin:(float)duration{
    _totalTime = duration;
    self.paceSlider.maximumValue = duration;
    self.maxTime.text = [NSString convertTime:duration];
}

#pragma mark - _playTimeObserver
- (void)monitoringPlayback:(AVPlayerItem *)item {
    __weak __typeof(&*self)weakSelf = self;    //这里设置每秒执行30次
    _playTimeObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 30) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        // 计算当前在第几秒
        float currentPlayTime = (double)item.currentTime.value/item.currentTime.timescale;
        [weakSelf updateVideoSlider:currentPlayTime];
    }];
}

- (void)updateVideoSlider:(float)currentTime{
    [self setLockViewWith:_playingModel currentTime:currentTime];
    self.paceSlider.value = currentTime;
    self.playingTime.text = [NSString convertTime:currentTime];
}

- (IBAction)changeSlider:(id)sender{
    //转换成CMTime才能给player来控制播放进度
    CMTime dragedCMTime = CMTimeMake(self.paceSlider.value, 1);
    [playerItem seekToTime:dragedCMTime];
}

-(void)addEndTimeNotification{
    //给AVPlayerItem添加播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

-(void)playbackFinished:(NSNotification *)notification{
   
    [self nextIndexAdd];
    [self updateAudioPlayer];
    
}

#pragma mark --按钮点击事件--
- (IBAction)disMissSelfClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)playAndPauseClick:(id)sender {
    [self playerStatus];
}

- (void)playerStatus{
    if (isPlaying) {
        [self stop];
    }else{
        [self play];
    }
}

- (IBAction)previousClick:(id)sender {
    [self inASong];
}

- (void)inASong{
    
    [self previousIndexSub];
  
    [self updateAudioPlayer];
}

- (IBAction)nextClick:(id)sender {
    [self theNextSong];
}

- (void)theNextSong{
    [self nextIndexAdd];
    
    [self updateAudioPlayer];
}

- (void)nextIndexAdd{
    _index++;
    if (_index == _modelArray.count) {
        _index = 0;
    }
}

- (void)previousIndexSub{
    _index--;
    if (_index < 0) {
        _index = _modelArray.count -1;
    }
}


- (void)play{
    isPlaying = YES;
    [self.player play];
    [self.playButton setImage:[UIImage imageNamed:@"MusicPlayer_播放"] forState:UIControlStateNormal];
  
}

- (void)stop{
    isPlaying = NO;
    [self.player pause];
    [self.playButton setImage:[UIImage imageNamed:@"MusicPlayer_暂停"] forState:UIControlStateNormal];
   
}



#pragma mark - 移除通知&KVO
- (void)removeObserverAndNotification{
    [self.player replaceCurrentItemWithPlayerItem:nil];
    [playerItem removeObserver:self forKeyPath:@"status"];
    [self.player removeTimeObserver:_playTimeObserver];
    _playTimeObserver = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

#pragma mark - 后台UI设置
- (void)setLockViewWith:(MusicModel*)model currentTime:(CGFloat)currentTime
{
    NSMutableDictionary *musicInfo = [NSMutableDictionary dictionary];
    // 设置Singer
    [musicInfo setObject:model.title forKey:MPMediaItemPropertyArtist];
    // 设置歌曲名
    [musicInfo setObject:model.title forKey:MPMediaItemPropertyTitle];
    // 设置封面
    MPMediaItemArtwork *artwork;
    artwork = [[MPMediaItemArtwork alloc] initWithImage:self.rotatingView.imageView.image];
    [musicInfo setObject:artwork forKey:MPMediaItemPropertyArtwork];
    //音乐剩余时长
    [musicInfo setObject:[NSNumber numberWithDouble:_totalTime] forKey:MPMediaItemPropertyPlaybackDuration];
    //音乐当前播放时间
    [musicInfo setObject:[NSNumber numberWithDouble:currentTime] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:musicInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
