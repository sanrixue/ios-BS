//
//  DBManager.m
//  宝山
//
//  Created by 尤超 on 17/4/20.
//  Copyright © 2017年 尤超. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager
{
    //数据库对象
    FMDatabase *_database;
}

//非标准单例
+ (DBManager *)sharedManager {
    static DBManager *manager = nil;
    @synchronized(self) {//同步 执行 防止多线程操作
        if (manager == nil) {
            manager = [[self alloc] init];
        }
    }
    return manager;
}

- (id)init {
    if (self = [super init]) {
        //1.获取数据库文件app.db的路径
        NSString *filePath = [self getFileFullPathWithFileName:@"app.db"];
        
        //2.创建database
        _database = [[FMDatabase alloc] initWithPath:filePath];
        
        //3.open
        //第一次 数据库文件如果不存在那么 会创建并且打开
        //如果存在 那么直接打开
        if ([_database open]) {
            NSLog(@"数据库打开成功");
            //创建表 不存在 则创建
            [self creatTable];
            
        }else {
            NSLog(@"database open failed:%@",_database.lastErrorMessage);
        }
    }
    return self;
}

#pragma mark - 创建表
- (void)creatTable {
    
    NSString *sql = @"create table if not exists model(user_id integer primary key AUTOINCREMENT,user_loginName text,user_phone text,user_logo text,user_name text,user_sex text,user_type text,user_QRcode text)";
    
    //创建表 如果不存在则创建新的表
    BOOL isSuccees = [_database executeUpdate:sql];
    if (!isSuccees) {
        NSLog(@"creatTable error:%@",_database.lastErrorMessage);
    }
}


#pragma mark - 获取文件的全路径

//获取文件在沙盒中的 Documents中的路径
- (NSString *)getFileFullPathWithFileName:(NSString *)fileName {
    NSString *docPath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:docPath]) {
        
        NSLog(@"%@",[docPath stringByAppendingFormat:@"/%@",fileName]);
        //文件的全路径
        return [docPath stringByAppendingFormat:@"/%@",fileName];
    }else {
        //如果不存在可以创建一个新的
        NSLog(@"Documents不存在");
        return nil;
    }
}

- (void)insertUserModel:(UserModel *)userModel {
    NSString *sql = @"insert into model(user_id,user_loginName,user_phone,user_logo,user_name,user_sex,user_type,user_QRcode) values (?,?,?,?,?,?,?,?)";
    if ([self userisExistModelId:userModel.user_id]) {
        NSLog(@"数据已经存在");
        return;
    }
    BOOL isSuccess= [_database executeUpdate:sql,userModel.user_id,userModel.user_loginName,userModel.user_phone,userModel.user_logo,userModel.user_name,userModel.user_sex,userModel.user_type,userModel.user_QRcode];
    if (isSuccess) {
        NSLog(@"数据库收藏成功");
    }
}


//查找是否存在
- (BOOL)userisExistModelId:(NSString *)modelId {
    NSString *sql = @"select * from model where user_id = ?";
    FMResultSet *rs = [_database executeQuery:sql,modelId];
    if ([rs next]) {
        return YES;
    }else{
        return NO;
    }
}


//删除
- (void)deleteUserModel
{
    NSString *sql = @"delete from model";
    BOOL isSuccess= [_database executeUpdate:sql];
    if (!isSuccess) {
        NSLog(@"删除失败: %@",_database.lastErrorMessage);
    } else {
        NSLog(@"数据库删除收藏成功");
    }
}


////修改
- (void)upadteUserModelModelName:(NSString *)modelName ModelModelSex:(NSString *)modelSex FromModelId:(NSString *)modelId {
    NSString *sql = @"update model set user_name = ?,user_sex = ?where user_id = ?";
    BOOL isSuccess= [_database executeUpdate:sql,modelName,modelId];
    if (!isSuccess) {
        NSLog(@"修改失败: %@",_database.lastErrorMessage);
    } else {
        NSLog(@"数据库修改成功");
    }
}


//根据modelId查找所有的model
- (NSArray *)selectAllModel
{
    NSString *sql=@"select * from model";
    FMResultSet *rs=[_database executeQuery:sql];
    NSMutableArray *ary=[[NSMutableArray alloc]init];
    while ([rs next]) {
        
      
        UserModel *model=[[UserModel alloc]init];
        model.user_id = [rs stringForColumn:@"user_id"];
        model.user_name = [rs stringForColumn:@"user_name"];
        model.user_logo = [rs stringForColumn:@"user_logo"];
        model.user_phone = [rs stringForColumn:@"user_phone"];
        model.user_type = [rs stringForColumn:@"user_type"];
        model.user_sex = [rs stringForColumn:@"user_sex"];
        model.user_QRcode = [rs stringForColumn:@"user_QRcode"];
        [ary addObject:model];

        
    }
    return ary;
}

//根据modelId查找一个model
- (instancetype)selectOneModel
{
    NSString *sql = @"select * from model";
    FMResultSet *rs = [_database executeQuery:sql];
    NSMutableArray *ary=[[NSMutableArray alloc]init];
    while ([rs next]) {
        
        UserModel *model=[[UserModel alloc]init];
        model.user_id = [rs stringForColumn:@"user_id"];
        model.user_name = [rs stringForColumn:@"user_name"];
        model.user_logo = [rs stringForColumn:@"user_logo"];
        model.user_phone = [rs stringForColumn:@"user_phone"];
        model.user_type = [rs stringForColumn:@"user_type"];
        model.user_sex = [rs stringForColumn:@"user_sex"];
        model.user_QRcode = [rs stringForColumn:@"user_QRcode"];
        [ary addObject:model];
        
    }
    return [ary firstObject];
}


@end
