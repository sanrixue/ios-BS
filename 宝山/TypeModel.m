//
//  TypeModel.m
//  宝山
//
//  Created by 尤超 on 17/4/20.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "TypeModel.h"

@implementation TypeModel

static TypeModel* dictModel = nil;  //为单例对象实现一个静态实例，并初始化，然后设置成nil，

+(TypeModel *)shareModel
{
    if (dictModel == nil) {
        dictModel = [[TypeModel alloc] init];//实现一个实例构造方法检查上面声明的静态实例是否为nil，如果是则新建并返回一个本类的实例
    }
    return dictModel;
}

-(id)init
{
    if (self = [super init]) {
        self.type = [[NSString alloc] init];
    }
    return self;
}

@end
