//
//  JDNetworkInterceptor.h
//  JDNetwork
//
//  Created by JD on 2015/8/7.
//  Copyright © 2015 JD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JDNetworkChain.h"

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
- (void)request:(JDNetworkChain *)chain;

/**
 拦截响应

 @param chain 拦截链
 */
- (void)response:(JDNetworkChain *)chain;

@end

NS_ASSUME_NONNULL_END
