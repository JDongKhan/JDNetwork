//
//  JDNetworkChain+Private.m
//  AFNetworking
//
//  Created by JD on 2019/8/8.
//

#import "JDNetworkChain+Private.h"
#import "JDNetworkInterceptorCenter.h"

@implementation JDNetworkChain (Private)

- (void)addInterceptors:(NSArray<id<JDNetworkInterceptor>> *)interceptors {
    [self->_interceptorCenter addInterceptors:interceptors];
}

- (void)addFinallyInterceptors:(id<JDNetworkInterceptor>)interceptors {
    [self->_interceptorCenter addFinallyInterceptors:interceptors];
}

- (void)run:(JDNetworkChain *)chain {
    [self->_interceptorCenter run:chain];
}


@end
