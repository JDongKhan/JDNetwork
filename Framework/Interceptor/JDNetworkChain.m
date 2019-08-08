//
//  JDNetworkChain.m
//  JDNetwork
//
//  Created by JD on 2015/8/7.
//  Copyright © 201 JD. All rights reserved.
//

#import "JDNetworkChain.h"
#import "JDNetworkInterceptorCenter.h"

@implementation JDNetworkChain 

+ (instancetype)requestChain {
    JDNetworkChain *chain = [[JDNetworkChain alloc] init];
    chain.interceptorCenter.selector = @selector(request:);
    return chain;
}

+ (instancetype)responseChain {
    JDNetworkChain *chain = [[JDNetworkChain alloc] init];
    chain.interceptorCenter.selector = @selector(response:);
    return chain;
}

- (instancetype)init {
    NSAssert(self != nil, @"cant not init");
    return self;
}

- (JDNetworkInterceptorCenter *)interceptorCenter {
    if (_interceptorCenter == nil) {
        _interceptorCenter = [[JDNetworkInterceptorCenter alloc] init];
    }
    return _interceptorCenter;
}

- (void)restart {
    [self.interceptorCenter restart];
}

- (void)stop {
    [self.interceptorCenter stop];
}

- (void)resume {
    [self.interceptorCenter resume];
}

- (void)pause {
    [self.interceptorCenter pause];
}

- (void)complete:(void(^)(BOOL complete, id object))completeBlock {
    [_interceptorCenter complete:^(BOOL complete, id  _Nonnull object) {
        completeBlock(complete,object);
    }];
}

@end
