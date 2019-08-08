//
//  JDNetworkChain.h
//  JDNetwork
//
//  Created by JD on 2015/8/7.
//  Copyright © 2015 JD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JDNetworkEntity.h"

NS_ASSUME_NONNULL_BEGIN

@class JDNetworkInterceptorCenter;

@interface JDNetworkChain<T> : NSObject {
    JDNetworkInterceptorCenter *_interceptorCenter;
}

@property (nonatomic, strong) T object;

+ (instancetype)requestChain;

+ (instancetype)responseChain;

- (void)restart;

- (void)stop;

- (void)resume;

- (void)pause;

- (void)complete:(void(^)(BOOL complete, T object))completeBlock;

@end

NS_ASSUME_NONNULL_END
