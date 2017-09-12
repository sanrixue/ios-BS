//
//  PhotoModle.m
//  Ecological
//
//  Created by 尤超 on 16/9/2.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import "PhotoModle.h"

@implementation PhotoModle

static PhotoModle* dictModel = nil;  //为单例对象实现一个静态实例，并初始化，然后设置成nil，

+(PhotoModle *)shareModel
{
    if (dictModel == nil) {
        dictModel = [[PhotoModle alloc] init];//实现一个实例构造方法检查上面声明的静态实例是否为nil，如果是则新建并返回一个本类的实例
    }
    return dictModel;
}

-(id)init
{
    if (self = [super init]) {
        self.dict = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
