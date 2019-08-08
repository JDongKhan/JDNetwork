//
//  JDNetworkInterceptorCenter.h
//  AFNetworking
//
//  Created by JD on 2017/8/8.
//

#import <Foundation/Foundation.h>
#import "JDNetworkChain.h"
#import "JDNetworkInterceptor.h"

NS_ASSUME_NONNULL_BEGIN

@interface JDNetworkRequestInterceptorCenter : NSObject

/**
 添加拦截器
 
 @param interceptors 拦截器
 */
- (void)addInterceptors:(NSArray<id<JDNetworkInterceptor>> *)interceptors;

- (void)addFinallyInterceptors:(id<JDNetworkInterceptor>)interceptors;

- (void)run:(JDNetworkRequestChain *)chain;

- (void)run;

- (void)restart;

- (void)stop;

- (void)complete:(void(^)(BOOL complete))completeBlock;


@end


@interface JDNetworkResponseInterceptorCenter : NSObject

/**
 添加拦截器
 
 @param interceptors 拦截器
 */
- (void)addInterceptors:(NSArray<id<JDNetworkInterceptor>> *)interceptors;

- (void)addFinallyInterceptors:(id<JDNetworkInterceptor>)interceptors;

- (void)run:(JDNetworkResponseChain *)chain;

- (void)run;

- (void)restart;

- (void)stop;

- (void)complete:(void(^)(BOOL complete))completeBlock;


@end

NS_ASSUME_NONNULL_END
