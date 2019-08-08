//
//  JDNetworkInterceptor.h
//  JDNetwork
//
//  Created by JD on 2015/8/7.
//  Copyright © 2015 JD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JDNetworkChain.h"

/**
 这块不好设计，因为AF的请求是异步的导致很多流程无法窜起来，等后续有好的想法再优化

 */
NS_ASSUME_NONNULL_BEGIN

@protocol JDNetworkInterceptor <NSObject>

- (BOOL)intercept:(JDNetworkChain *)chain;

@optional

/**
 优先级
 
 值越大越先执行
 */
- (NSInteger)priority;

- (void)disposeOfResponse:(JDResponse *)response;

@end

NS_ASSUME_NONNULL_END
