//
//  DBManager.h
//  宝山
//
//  Created by 尤超 on 17/4/20.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FMDatabase.h"
#import "UserModel.h"

@interface DBManager : NSObject

//非标准单例
+ (DBManager *)sharedManager;


//存储类型
- (void)insertUserModel:(UserModel *)userModel;

//删除用户
- (void)deleteUserModel;



//查找是否已经存在
- (BOOL)userisExistModelId:(NSString *)modelId;


//查找所有的收藏
- (NSArray *)selectAllModel;

//根据modelId查找一个model
- (instancetype)selectOneModel;


//修改
- (void)upadteUserModelModelName:(NSString *)modelName ModelModelSex:(NSString *)modelSex FromModelId:(NSString *)modelId;

@end
