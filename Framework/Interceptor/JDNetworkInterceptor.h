//
//  JDNetworkInterceptor.h
//  JDNetwork
//
//  Created by JD on 2015/8/7.
//  Copyright © 2015 JD. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JDNetworkRequestChain;
@class JDNetworkResponseChain;
@class JDResponse;

/**
 这块不好设计，因为AF的请求是异步的导致请求和响应流程无法窜起来，等后续有好的想法再优化

 */
NS_ASSUME_NONNULL_BEGIN

@protocol JDNetworkInterceptor <NSObject>

@optional

/**
 优先级
 
 值越大越先执行
 */
- (NSInteger)priority;

/**
 拦截请求

 @param chain 拦截链
 */
- (void)request:(JDNetworkRequestChain *)chain;

/**
 拦截响应

 @param chain 拦截链
 */
- (void)response:(JDNetworkResponseChain *)chain;

@end

NS_ASSUME_NONNULL_END
