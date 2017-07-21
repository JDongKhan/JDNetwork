//
//  JDRequest.h
//
//  Created by 王金东 on 15/7/7.
//  Copyright (c) 2015年 王金东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIView.h>

typedef void (^CompletionBlock)(id result);
typedef void (^ErrorBlock)(NSError* error);

@interface JDRequest : NSObject

//请求是否正在运行
@property (nonatomic,assign,readonly) BOOL running;

//请求的url
@property (nonatomic,strong) NSString *url;

//请求的参数
@property (nonatomic,strong) NSMutableDictionary *params;

//请求方式 GET、POST、DELETE、PUT
@property (nonatomic,strong) NSString *method;

//请求时相关的view，默认般为空
@property (nonatomic,weak) UIView *view;

//请求成功block
@property (nonatomic,copy) CompletionBlock success;

//请求失败block
@property (nonatomic,copy) ErrorBlock error;

//是否有等待框 默认不显示
@property (nonatomic,assign) BOOL isProgress;

//是否加密 默认不加密
@property (nonatomic,assign) BOOL secure;

//是否是https 默认为http
@property (nonatomic,assign) BOOL ssl;

//清理请求的配置
- (void)clear;

//开始请求
- (void)sendRequest;

//取消请求
- (void)cancel;

@end




@interface JDRequest (netoworkBlock)

//开始网络
+ (JDRequest *(^)())jd_request;
//设置url
- (JDRequest *(^)(NSString *url))jd_url;
//设置请求参数
- (JDRequest *(^)(NSString *key,id obj))jd_param;
- (JDRequest *(^)(NSDictionary *))jd_params;
//设置GET or POST
- (JDRequest *(^)(NSString *method))jd_method;
//是否显示等待框
- (JDRequest *(^)(BOOL isProgress))jd_isProgress;
//是否加密
- (JDRequest *(^)(BOOL secure))jd_secure;
//是否是https
- (JDRequest *(^)(BOOL ssl))jd_ssl;
//成功回掉
- (JDRequest *(^)(CompletionBlock success))jd_success;
//失败回调
- (JDRequest *(^)(ErrorBlock error))jd_error;
//开始请求
- (JDRequest *(^)())jd_send;

@end

