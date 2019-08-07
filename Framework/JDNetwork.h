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
 get
 */
@property (nonatomic, readonly, class, copy) JDNetwork *(^get)(NSString *pathOrFullURLString);

/**
 post
 */
@property (nonatomic, readonly, class, copy) JDNetwork *(^post)(NSString *pathOrFullURLString);


/**
 baseURL
 */
@property (nonatomic, readonly, class, copy) JDNetwork *(^baseURLString)(NSString *baseURLString);

/**
 get
 */
@property (nonatomic, readonly, copy) JDNetwork *(^get)(NSString *pathOrFullURLString);

/**
 post
 */
@property (nonatomic, readonly, copy) JDNetwork *(^post)(NSString *pathOrFullURLString);

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
@property (nonatomic, readonly, copy) JDNetwork *(^successResponse)(JDNetworkCompletionBlock successResponse);

/**
 error 回调
 */
@property (nonatomic, readonly, copy) JDNetwork *(^errorResponse)(JDNetworkErrorBlock errorResponse);

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
