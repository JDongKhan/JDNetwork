//
//  JDNetworkRequestChain.m
//  JDNetwork
//
//  Created by JD on 2015/8/7.
//  Copyright © 201 JD. All rights reserved.
//

#import "JDNetworkChain.h"
#import "JDNetworkInterceptorCenter.h"

@interface JDNetworkRequestChain ()

@end

@implementation JDNetworkRequestChain {
    JDNetworkRequestInterceptorCenter *_interceptorCenter;
}


- (JDNetworkRequestInterceptorCenter *)interceptorCenter {
    if (_interceptorCenter == nil) {
        _interceptorCenter = [[JDNetworkRequestInterceptorCenter alloc] init];
    }
    return _interceptorCenter;
}

- (void)restart {
    [self.interceptorCenter restart];
}

- (void)stop {
    [self.interceptorCenter stop];
}

- (void)dealloc {
//    NSLog(@"%@ dealloc",NSStringFromClass(self.class));
}

@end


@interface JDNetworkResponseChain ()

@end

@implementation JDNetworkResponseChain {
    JDNetworkResponseInterceptorCenter *_interceptorCenter;
}


- (JDNetworkResponseInterceptorCenter *)interceptorCenter {
    if (_interceptorCenter == nil) {
        _interceptorCenter = [[JDNetworkResponseInterceptorCenter alloc] init];
    }
    return _interceptorCenter;
}

- (void)restart {
    [self.interceptorCenter restart];
}

- (void)stop {
    [self.interceptorCenter stop];
}

- (void)dealloc {
    //    NSLog(@"%@ dealloc",NSStringFromClass(self.class));
}

@end
