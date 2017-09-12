//
//  ActivityModel.h
//  宝山城市规划馆
//
//  Created by YC on 16/11/17.
//
//
/**
 ———————————————————————————————————————————————————————————
 |--------------------------_ooOoo_------------------------|
 |------------------------o888888888o----------------------|
 |------------------------88"" . ""88----------------------|
 |------------------------(|  - -  |)----------------------|
 |------------------------0\   =   /0----------------------|
 |------------------------_/` --- '\____-------------------|
 |-------------------.'  \\|       |//  `. ----------------|
 |------------------/  \\|||   :   |||//  \ ---------------|
 |---------------- /  _|||||  -:-  |||||-  \---------------|
 |---------------- |   | \\\   -   /// |   |---------------|
 |---------------- | \_|  ``\ --- /''  |   |---------------|
 |---------------- \  .-\__   `-'   ___/-. / --------------|
 |--------------___ `. . '  /--.--\  '. . __---------------|
 |-----------.""  '<  `.___ \_<|>_/___.'  >'"". -----------|
 |----------| | :   `- \`.;` \ _ /`;.`/ - ` : | |----------|
 |----------\  \ `-.    \_  __\ /__ _/   .-` /  /----------|
 |===========`-.____`-.___ \______/___.-`____.-'===========|
 |--------------------------`=---='------------------------|
 |^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^|
 |------佛祖保佑 --------------永无BUG-----------永不修改------|
 */


#import <Foundation/Foundation.h>

@interface ActivityModel : NSObject

@property (nonatomic, copy) NSString *icon;       //图片
@property (nonatomic, copy) NSString *title;      //标题
@property (nonatomic, copy) NSString *content;    //简介
@property (nonatomic, copy) NSString *time;       //背景
@property (nonatomic, copy) NSString *state;      //状态

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)activityWithDict:(NSDictionary *)dic;

@end
