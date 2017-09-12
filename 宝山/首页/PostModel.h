//
//  PostModel.h
//  宝山
//
//  Created by 尤超 on 2017/5/5.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostModel : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *icon;       //头像
@property (nonatomic, copy) NSString *title;      //标题
@property (nonatomic, copy) NSString *content;    //简介
@property (nonatomic, copy) NSString *start_time; //开始时间
@property (nonatomic, copy) NSString *image;      //图片
@property (nonatomic, copy) NSString *name;       //名字
@property (nonatomic, copy) NSString *like;       //收藏
@property (nonatomic, copy) NSString *look;       //浏览
@property (nonatomic, copy) NSString *comment;    //评论
@property (nonatomic, copy) NSString *tag;        //标签

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)postWithDict:(NSDictionary *)dic;

@end
