//
//  MusicModel.h
//  AudioPlayer
//
//  Created by ClaudeLi on 16/4/1.
//  Copyright © 2016年 ClaudeLi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicModel : NSObject

@property (nonatomic, strong) NSString *voice_path;
@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *etitle;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *mid;

@end
