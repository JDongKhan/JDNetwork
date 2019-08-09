//
//  JDNetworkInterceptorCenter.h
//  AFNetworking
//
//  Created by JD on 2017/8/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class JDNetworkChain;
@protocol JDNetworkInterceptor;


@interface JDNetworkInterceptorCenter : NSObject

@property (nonatomic, assign) SEL selector;
/**
 添加拦截器
 
 @param interceptors 拦截器
 */
- (void)addInterceptors:(NSArray<id<JDNetworkInterceptor>> *)interceptors;

- (void)addFinallyInterceptors:(id<JDNetworkInterceptor>)interceptors;

- (void)runWithChain:(JDNetworkChain *)chain;

- (void)restart;

- (void)stop;

- (void)pause;

- (void)resume;

- (void)complete:(void(^)(BOOL complete, id object))completeBlock;


@end

NS_ASSUME_NONNULL_END
