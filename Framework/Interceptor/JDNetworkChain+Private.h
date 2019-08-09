//
//  JDNetworkChain+Private.h
//  AFNetworking
//
//  Created by JD on 2019/8/8.
//

#import "JDNetworkChain.h"

NS_ASSUME_NONNULL_BEGIN

@interface JDNetworkChain (Private)

- (void)addInterceptors:(NSArray<id<JDNetworkInterceptor>> *)interceptors;

- (void)addFinallyInterceptors:(id<JDNetworkInterceptor>)interceptors;

- (void)run;


@end

NS_ASSUME_NONNULL_END
