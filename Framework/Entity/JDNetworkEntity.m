//
//  JDNetworkEntity.m
//  JDNetwork
//
//  Created by JD on 2015/6/7.
//  Copyright © 2015 JD. All rights reserved.
//

#import "JDNetworkEntity.h"

@implementation JDNetworkEntity

- (instancetype)init {
    if(self = [super init]){
        _interceptors = [NSMutableArray arrayWithCapacity:0];
        _finallyInterceptors = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (JDRequest *)request {
    if (_request == nil) {
        _request = [[JDRequest alloc] init];
    }
    return _request;
}

- (JDResponse *)response {
    if (_response == nil) {
        _response = [[JDResponse alloc] init];
    }
    return _response;
}

- (void)addInterceptor:(id<JDNetworkInterceptor>)interceptor {
    NSMutableArray *interceptors = (NSMutableArray *)self.interceptors;
    [interceptors addObject:interceptor];
}

- (void)addFinallyInterceptor:(id<JDNetworkInterceptor>)interceptor {
    NSMutableArray *interceptors = (NSMutableArray *)self.finallyInterceptors;
    [interceptors addObject:interceptor];
}

- (id)copyWithZone:(NSZone *)zone {
    JDNetworkEntity *entity = [[[self class] allocWithZone:zone] init];
    entity.request = [self.request copy];
    entity.response = [self.response copy];
    entity->_interceptors = [self.interceptors mutableCopy];
    [entity->_finallyInterceptors = self.finallyInterceptors mutableCopy];
    return entity;
}

- (void)dealloc {
//    NSLog(@"%@ dealloc",NSStringFromClass(self.class));
}


@end
