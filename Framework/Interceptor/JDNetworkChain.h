//
//  JDNetworkRequestChain.h
//  JDNetwork
//
//  Created by JD on 2015/8/7.
//  Copyright © 2015 JD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JDNetworkEntity.h"

NS_ASSUME_NONNULL_BEGIN

@class JDNetworkRequestInterceptorCenter;

@interface JDNetworkRequestChain : NSObject

@property (nonatomic, strong) JDNetworkRequestInterceptorCenter *interceptorCenter;

@property (nonatomic, strong) JDNetworkEntity *entity;

- (void)restart;

- (void)stop;

@end

@class JDNetworkResponseInterceptorCenter;

@interface JDNetworkResponseChain : NSObject

@property (nonatomic, strong) JDNetworkResponseInterceptorCenter *interceptorCenter;

@property (nonatomic, strong) JDResponse *response;

- (void)restart;

- (void)stop;

@end

NS_ASSUME_NONNULL_END
