//
//  TitleModel.m
//  宝山
//
//  Created by 尤超 on 17/4/21.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "TitleModel.h"

@implementation TitleModel

static TitleModel *dictModel = nil;

+(TitleModel *)shareModel
{
    if (dictModel == nil) {
        dictModel = [[TitleModel alloc] init];//实现一个实例构造方法检查上面声明的静态实例是否为nil，如果是则新建并返回一个本类的实例
    }
    return dictModel;
}

-(id)init
{
    if (self = [super init]) {
        self.title = [[NSString alloc] init];
    }
    return self;
}


@end
