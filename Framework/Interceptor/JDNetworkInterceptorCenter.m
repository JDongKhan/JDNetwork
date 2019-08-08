//
//  JDNetworkInterceptorCenter.m
//  AFNetworking
//
//  Created by JD on 2017/8/8.
//

#import "JDNetworkInterceptorCenter.h"

@implementation JDNetworkRequestInterceptorCenter {
    NSMutableArray<id<JDNetworkInterceptor>> *_interceptors;
    NSMutableArray<id<JDNetworkInterceptor>> *_finallyInterceptors;
    NSInteger _currentIndex;
    JDNetworkRequestChain *_chain;
    void(^_completeBlock)(BOOL complete);
    BOOL _stop;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _interceptors = [NSMutableArray arrayWithCapacity:0];
        _finallyInterceptors = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)addInterceptors:(NSArray<id<JDNetworkInterceptor>> *)interceptors {
    [_interceptors addObjectsFromArray:interceptors];
}

- (void)addFinallyInterceptors:(NSArray<id<JDNetworkInterceptor>> *)interceptors {
    [_finallyInterceptors addObjectsFromArray:interceptors];
}

- (void)run:(JDNetworkRequestChain *)chain {
    _chain = chain;
    [self run];
}

- (void)run {
    _currentIndex = 0;
    _stop = NO;
    while (!_stop && [self hasNext]) {
        [self next];
    }
    
    //执行finally 拦截器
    [_finallyInterceptors enumerateObjectsUsingBlock:^(id<JDNetworkInterceptor>  _Nonnull interceptor, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([interceptor respondsToSelector:@selector(request:)]) {
            [interceptor request:self->_chain];
        }
    }];
    
    //完成
    if (_stop) {
        if (_completeBlock) {
            _completeBlock(NO);
        }
    } else {
        if (_completeBlock) {
            _completeBlock(YES);
        }
    }
}

- (BOOL)hasNext {
    return (_currentIndex < _interceptors.count);
}

- (void)restart {
    [self run];
}

- (void)next {
    if (_currentIndex < _interceptors.count) {
        id<JDNetworkInterceptor> interceptor = [_interceptors objectAtIndex:_currentIndex];
        if ([interceptor respondsToSelector:@selector(request:)]) {
            [interceptor request:_chain];
        }
    }
     _currentIndex ++;
}

- (void)stop {
    _stop = YES;
}

- (void)complete:(void(^)(BOOL complete))completeBlock {
    _completeBlock = [completeBlock copy];
}

@end


/********************   response ***************************/

@implementation JDNetworkResponseInterceptorCenter {
    NSMutableArray<id<JDNetworkInterceptor>> *_interceptors;
    NSMutableArray<id<JDNetworkInterceptor>> *_finallyInterceptors;
    NSInteger _currentIndex;
    JDNetworkResponseChain *_chain;
    void(^_completeBlock)(BOOL complete);
    BOOL _stop;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _interceptors = [NSMutableArray arrayWithCapacity:0];
        _finallyInterceptors = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)addInterceptors:(NSArray<id<JDNetworkInterceptor>> *)interceptors {
    [_interceptors addObjectsFromArray:interceptors];
}

- (void)addFinallyInterceptors:(NSArray<id<JDNetworkInterceptor>> *)interceptors {
    [_finallyInterceptors addObjectsFromArray:interceptors];
}

- (void)run:(JDNetworkResponseChain *)chain {
    _chain = chain;
    [self run];
}

- (void)run {
    _currentIndex = 0;
    _stop = NO;
    while (!_stop && [self hasNext]) {
        [self next];
    }
    
    //执行finally 拦截器
    [_finallyInterceptors enumerateObjectsUsingBlock:^(id<JDNetworkInterceptor>  _Nonnull interceptor, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([interceptor respondsToSelector:@selector(response:)]) {
            [interceptor response:self->_chain];
        }
    }];
    
    //完成
    if (_stop) {
        if (_completeBlock) {
            _completeBlock(NO);
        }
    } else {
        if (_completeBlock) {
            _completeBlock(YES);
        }
    }
}

- (BOOL)hasNext {
    return (_currentIndex < _interceptors.count);
}

- (void)restart {
    [self run];
}

- (void)next {
    if (_currentIndex < _interceptors.count) {
        id<JDNetworkInterceptor> interceptor = [_interceptors objectAtIndex:_currentIndex];
        if ([interceptor respondsToSelector:@selector(response:)]) {
            [interceptor response:_chain];
        }
    }
    _currentIndex ++;
}

- (void)stop {
    _stop = YES;
}

- (void)complete:(void(^)(BOOL complete))completeBlock {
    _completeBlock = [completeBlock copy];
}

@end
