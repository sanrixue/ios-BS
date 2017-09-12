
//
//  RotatingView.m
//  AudioPlayer
//
//  Created by ClaudeLi on 16/4/12.
//  Copyright © 2016年 ClaudeLi. All rights reserved.
//

#import "RotatingView.h"
#define BorderWidth 6.0f //边界半透明宽度

@implementation RotatingView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.imageView = [[UIImageView alloc] init];
        [self addSubview:self.imageView];
    }
    return self;
}

- (void)setRotatingViewLayoutWithFrame:(CGRect)frame{
   
    self.imageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    
}

/// 添加动画
- (void)addAnimation{
    
    CABasicAnimation *monkeyAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    monkeyAnimation.toValue = [NSNumber numberWithFloat:2.0 *M_PI];
    monkeyAnimation.duration = 20.0f;
    monkeyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    monkeyAnimation.cumulative = NO;
    monkeyAnimation.removedOnCompletion = NO; //No Remove
    monkeyAnimation.fillMode = kCAFillModeForwards;
    monkeyAnimation.repeatCount = FLT_MAX;
    [self.imageView.layer addAnimation:monkeyAnimation forKey:@"AnimatedKey"];
    [self.imageView stopAnimating];
    self.imageView.layer.speed = 0.0;
}

// 停止
-(void)pauseLayer
{
    CFTimeInterval pausedTime = [self.imageView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.imageView.layer.speed = 0.0;
    self.imageView.layer.timeOffset = pausedTime;
}

// 恢复
-(void)resumeLayer
{
    CFTimeInterval pausedTime = self.imageView.layer.timeOffset;
    self.imageView.layer.speed = 1.0;
    self.imageView.layer.timeOffset = 0.0;
    self.imageView.layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self.imageView.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.imageView.layer.beginTime = timeSincePause;
}

- (void)removeAnimation{
    [self.imageView.layer removeAllAnimations];
}

@end
