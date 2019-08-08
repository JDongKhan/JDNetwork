//
//  JDNetwork.h
//
//  Created by JD on 15/7/7.
//  Copyright (c) 2015年 JD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIView.h>
#import "JDNetworkEntity.h"
#import "JDNetworkInterceptor.h"

NS_ASSUME_NONNULL_BEGIN

@interface JDNetwork : NSObject {
    __strong JDNetworkEntity *entity;
}

/**
 请求是否正在运行
 */
@property (nonatomic, readonly, assign) BOOL running;

/**
 GET
 */
@property (nonatomic, readonly, class, copy) JDNetwork *(^GET)(NSString *fullURLString);

/**
 POST
 */
@property (nonatomic, readonly, class, copy) JDNetwork *(^POST)(NSString *fullURLString);

/**
 HEAD
 */
@property (nonatomic, readonly, class, copy) JDNetwork *(^HEAD)(NSString *fullURLString);

/**
 PUT
 */
@property (nonatomic, readonly, class, copy) JDNetwork *(^PUT)(NSString *fullURLString);

/**
 DELETE
 */
@property (nonatomic, readonly, class, copy) JDNetwork *(^DELETE)(NSString *fullURLString);

/**
 PATCH
 */
@property (nonatomic, readonly, class, copy) JDNetwork *(^PATCH)(NSString *fullURLString);

/**
 baseURL
 */
@property (nonatomic, readonly, class, copy) JDNetwork *(^baseURLString)(NSString *baseURLString);

/**
 GET
 */
@property (nonatomic, readonly, copy) JDNetwork *(^GET)(NSString *pathOrFullURLString);

/**
 POST
 */
@property (nonatomic, readonly, copy) JDNetwork *(^POST)(NSString *pathOrFullURLString);

/**
 HEAD
 */
@property (nonatomic, readonly, copy) JDNetwork *(^HEAD)(NSString *pathOrFullURLString);

/**
 PUT
 */
@property (nonatomic, readonly, copy) JDNetwork *(^PUT)(NSString *pathOrFullURLString);

/**
 DELETE
 */
@property (nonatomic, readonly, copy) JDNetwork *(^DELETE)(NSString *pathOrFullURLString);

/**
 PATCH
 */
@property (nonatomic, readonly, copy) JDNetwork *(^PATCH)(NSString *pathOrFullURLString);

/**
 拦截器
 */
@property (nonatomic, readonly) JDNetwork *(^addInterceptor)(id<JDNetworkInterceptor> interceptor);

/**
 设置请求参数
 */
@property (nonatomic, readonly, copy) JDNetwork *(^parametersForKey)(NSString *key,id obj);
@property (nonatomic, readonly, copy) JDNetwork *(^parameters)(NSDictionary *params);

/**
 超时
 */
@property (nonatomic, readonly, copy) JDNetwork *(^timeoutInterval)(CGFloat timeoutInterval);

/**
 参数类型
 */
@property (nonatomic, readonly, copy) JDNetwork *(^parameterEncoding)(JDNetworkParameterEncoding parameterEncoding);

/**
 响应的类型
 */
@property (nonatomic, readonly, copy) JDNetwork *(^responseEncoding)(JDNetworkResponseEncoding responseEncoding);

/**
 success 回调
 */
@property (nonatomic, readonly, copy) JDNetwork *(^success)(JDNetworkCompletionBlock success);

/**
 error 回调
 */
@property (nonatomic, readonly, copy) JDNetwork *(^error)(JDNetworkErrorBlock error);

/**
 开始
 */
@property (nonatomic, readonly, copy) void(^start)(void);

/**
 取消
 */
@property (nonatomic, readonly, copy) void(^cancel)(void);


@end

NS_ASSUME_NONNULL_END
