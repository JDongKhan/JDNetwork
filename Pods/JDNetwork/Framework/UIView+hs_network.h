//
//  UIView+hs_networkd.h
//
//  Created by 王金东 on 14-7-30.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JDNetWork.h"
#import "JDRequest.h"


/***
    为啥给view加入网络功能呢？
    有以下优势：
    1、view removeFromSuperview后就会取消网络，然而你什么都不需要做
    2、有时候会需要在view上显示提示，比如在tableview中间显示/隐藏加载动画，比如在button上显示/隐藏菊花转，比如在出现错误，需要在view上显示错误信息等等。
    3、还有... 暂时没有想到
 
    4、view 显示网络 一般都是线程安全的，也不会有人给view开几个线程并发请求网络吧，如果这样，我怀疑产品需求（相信开发是无辜的^_^），所以本工程没有加线程锁！！！！！！
 
 */
 
@interface UIView (hs_network)


@property (nonatomic,assign,readonly) BOOL running;

//网络链式编程

//开始网络
- (UIView *(^)(Class))jd_request;
//设置url
- (UIView *(^)(NSString *url))jd_url;
//设置请求参数
- (UIView *(^)(NSString *key,id obj))jd_param;
- (UIView *(^)(NSDictionary *))jd_params;

//设置GET or POST
- (UIView *(^)(NSString *method))jd_method;
//是否显示等待框
- (UIView *(^)(BOOL isProgressView))jd_isProgress;
//是否加密
- (UIView *(^)(BOOL secure))jd_secure;
//是否是https
- (UIView *(^)(BOOL ssl))jd_ssl;
//成功回掉
- (UIView *(^)(CompletionBlock success))jd_success;
//失败回调
- (UIView *(^)(ErrorBlock error))jd_error;
//开始请求
- (UIView *(^)())jd_send;


@end
