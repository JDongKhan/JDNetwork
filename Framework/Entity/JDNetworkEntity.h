//
//  JDNetworkEntity.h
//  JDNetwork
//
//  Created by JD on 2015/6/7.
//  Copyright © 2015 JD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIView.h>
#import "JDRequest.h"
#import "JDResponse.h"

NS_ASSUME_NONNULL_BEGIN

@protocol JDNetworkInterceptor;

typedef void (^JDNetworkCompletionBlock)(id _Nullable result);

typedef void (^JDNetworkErrorBlock)(NSError *_Nullable error);

@interface JDNetworkEntity : NSObject

/**
 request
 */
@property (nonatomic, strong) JDRequest *request;

/**
 response
 */
@property (nonatomic, strong) JDResponse *response;

/**
 拦截器
 */
@property (nonatomic, strong, readonly) NSArray<id<JDNetworkInterceptor>> *interceptors;

/**
 请求成功block
 */
@property (nonatomic, copy) JDNetworkCompletionBlock success;

/**
 请求失败block
 */
@property (nonatomic, copy) JDNetworkErrorBlock error;


/**
 添加拦截器

 @param interceptor 拦截器
 */
- (void)addInterceptor:(id<JDNetworkInterceptor>)interceptor;

@end

NS_ASSUME_NONNULL_END
