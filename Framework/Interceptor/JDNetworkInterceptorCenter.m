//
//  JDNetworkInterceptorCenter.m
//  AFNetworking
//
//  Created by JD on 2017/8/8.
//

#import "JDNetworkInterceptorCenter.h"

@implementation JDNetworkInterceptorCenter {
    NSMutableArray<id<JDNetworkInterceptor>> *_interceptors;
    NSMutableArray<id<JDNetworkInterceptor>> *_finallyInterceptors;
    NSInteger _currentIndex;
    NSInteger _lastIndex;
    JDNetworkChain *_chain;
    void(^_completeBlock)(BOOL complete,NSObject *object);
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

static dispatch_queue_t  interceptor_queue() {
    static dispatch_queue_t interceptor_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        interceptor_queue = dispatch_queue_create("com.jd.interceptor.queue", DISPATCH_QUEUE_CONCURRENT);
    });
    return interceptor_queue;
}

static void interceptor_queue_create_task_safely(dispatch_block_t block) {
    dispatch_async(interceptor_queue(), block);
}

- (void)addInterceptors:(NSArray<id<JDNetworkInterceptor>> *)interceptors {
    [_interceptors addObjectsFromArray:interceptors];
}

- (void)addFinallyInterceptors:(NSArray<id<JDNetworkInterceptor>> *)interceptors {
    [_finallyInterceptors addObjectsFromArray:interceptors];
}

- (void)runWithChain:(JDNetworkChain *)chain {
    _chain = chain;
    _stop = NO;
    _currentIndex = 0;
    [self run];
}

- (void)run {
    //你可以会在拦截器里面做很多事情
    //让这个可能耗时的操作放到子线程去
    interceptor_queue_create_task_safely(^{
        [self runTask];
    });
}

- (void)runTask {
    
    while (!_stop && [self hasNext]) {
        [self next];
    }
    
    //执行finally 拦截器
    [_finallyInterceptors enumerateObjectsUsingBlock:^(id<JDNetworkInterceptor>  _Nonnull interceptor, NSUInteger idx, BOOL * _Nonnull stop) {
        if (self.selector != nil && [interceptor respondsToSelector:self.selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [interceptor performSelector:self.selector withObject:self->_chain];
#pragma clang diagnostic pop
        }
    }];
    
    //完成
    if (_stop) {
        if (_completeBlock) {
            _completeBlock(NO,_chain.object);
        }
    } else {
        if (_completeBlock) {
            _completeBlock(YES,_chain.object);
        }
    }
}

- (BOOL)hasNext {
    return (_currentIndex < _interceptors.count);
}

- (void)restart {
    _stop = NO;
    _currentIndex = 0;
    [self run];
}

- (void)stop {
    _stop = YES;
}

- (void)resume {
    _stop = NO;
    _currentIndex = _lastIndex;
    [self run];
}

- (void)pause {
    _stop = YES;
    _lastIndex = _currentIndex;
}

- (void)next {
    if (_currentIndex < _interceptors.count) {
        id<JDNetworkInterceptor> interceptor = [_interceptors objectAtIndex:_currentIndex];
        if (self.selector != nil && [interceptor respondsToSelector:self.selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [interceptor performSelector:self.selector withObject:_chain];
#pragma clang diagnostic pop
        }
    }
     _currentIndex ++;
}


- (void)complete:(void(^)(BOOL complete,id object))completeBlock {
    _completeBlock = [completeBlock copy];
}

@end

