//
//  JDNetwork.m
//
//  Created by 王金东 on 15/7/7.
//  Copyright (c) 2015年 王金东. All rights reserved.
//

#import "JDNetwork.h"
#import "JDNetworkOperation.h"

@interface JDNetwork ()

@property (nonatomic, strong) JDNetworkConfig *config;

@property (nonatomic, strong) JDNetworkOperation *operation;

@end

@implementation JDNetwork

+ (JDNetwork *(^)(NSString *))get {
    return ^(NSString *pathOrFullURLString){
        JDNetwork *requst = [[self alloc] init];
        JDNetworkConfig *config = [[JDNetworkConfig alloc] init];
        config.urlString = pathOrFullURLString;
        config.HTTPMethod = @"GET";
        requst.config = config;
        return requst;
    };
}

+ (JDNetwork *(^)(NSString *))post {
    return ^(NSString *pathOrFullURLString){
        JDNetwork *requst = [[self alloc] init];
        JDNetworkConfig *config = [[JDNetworkConfig alloc] init];
        config.urlString = pathOrFullURLString;
        config.HTTPMethod = @"POST";
        requst.config = config;
        return requst;
    };
}

+ (JDNetwork *(^)(NSString *))baseURLString {
    return ^(NSString *baseURLString){
        JDNetwork *requst = [[self alloc] init];
        JDNetworkConfig *config = [[JDNetworkConfig alloc] init];
        config.baseURLString = baseURLString;
        requst.config = config;
        return requst;
    };
}

- (JDNetwork *(^)(NSString *))get {
    __weak JDNetwork *_weaskSelf = self;
    return ^(NSString *pathOrFullURLString){
        _weaskSelf.config.urlString = pathOrFullURLString;
        _weaskSelf.config.HTTPMethod = @"GET";
        return _weaskSelf;
    };
}

- (JDNetwork *(^)(NSString *))post {
    __weak JDNetwork *_weaskSelf = self;
    return ^(NSString *pathOrFullURLString){
        _weaskSelf.config.urlString = pathOrFullURLString;
        _weaskSelf.config.HTTPMethod = @"POST";
        return _weaskSelf;
    };
}

- (JDNetwork *(^)(NSString *key,id obj))parametersForKey {
    __weak JDNetwork *_weaskSelf = self;
    return ^(NSString *key,id obj){
        [_weaskSelf.config.parameters setValue:obj forKey:key];
        return _weaskSelf;
    };
}

- (JDNetwork *(^)(NSDictionary *))parameters {
    __weak JDNetwork *_weaskSelf = self;
    return ^(NSDictionary *params){
        _weaskSelf.config.parameters = params.mutableCopy;
        return _weaskSelf;
    };
}

- (JDNetwork *(^)(NSString *HTTPMethod))HTTPMethod {
    __weak JDNetwork *_weaskSelf = self;
    return ^(NSString *HTTPMethod){
        _weaskSelf.config.HTTPMethod = HTTPMethod;
        return _weaskSelf;
    };
}

- (JDNetwork *(^)(JDNetworkCachePolicy))cachePolicy {
    __weak JDNetwork *_weaskSelf = self;
    return ^(JDNetworkCachePolicy cachePolicy){
        _weaskSelf.config.cachePolicy = cachePolicy;
        return _weaskSelf;
    };
}

- (JDNetwork *(^)(CGFloat))timeoutInterval {
    __weak JDNetwork *_weaskSelf = self;
    return ^(CGFloat timeoutInterval){
        _weaskSelf.config.timeoutInterval = timeoutInterval;
        return _weaskSelf;
    };
}

- (JDNetwork *(^)(JDNetworkParameterEncoding))parameterEncoding {
    __weak JDNetwork *_weaskSelf = self;
    return ^(JDNetworkParameterEncoding parameterEncoding) {
        _weaskSelf.config.parameterEncoding = parameterEncoding;
        return _weaskSelf;
    };
}

- (JDNetwork *(^)(JDNetworkResponseEncoding))responseEncoding {
    __weak JDNetwork *_weaskSelf = self;
    return ^(JDNetworkResponseEncoding responseEncoding) {
        _weaskSelf.config.responseEncoding = responseEncoding;
        return _weaskSelf;
    };
}

- (JDNetwork *(^)(JDNetworkCompletionBlock successResponse))successResponse {
    __weak JDNetwork *_weaskSelf = self;
    return ^(JDNetworkCompletionBlock successResponse){
        _weaskSelf.config.successResponse = successResponse ;
        return _weaskSelf;
    };
}

- (JDNetwork *(^)(JDNetworkCompletionBlock cachedDataResponse))cachedDataResponse {
    __weak JDNetwork *_weaskSelf = self;
    return ^(JDNetworkCompletionBlock cachedDataResponse){
        _weaskSelf.config.cachedDataResponse = cachedDataResponse ;
        return _weaskSelf;
    };
}

- (JDNetwork *(^)(JDNetworkErrorBlock errorResponse))errorResponse {
    __weak JDNetwork *_weaskSelf = self;
    return ^(JDNetworkErrorBlock errorResponse){
        _weaskSelf.config.errorResponse = errorResponse ;
        return _weaskSelf;
    };
}

- (void(^)(void))execute {
    __weak JDNetwork *_weaskSelf = self;
    return ^(void){
        [_weaskSelf _start];
    };
}

- (BOOL)running {
    return self.operation.running;
}

- (void (^)(void))cancel {
    __weak JDNetwork *_weaskSelf = self;
    return ^(void) {
        [_weaskSelf.operation cancel];
    };
}


#pragma mark 私有方法 -------------

- (void)_start {
    JDNetworkOperation *operation = [[JDNetworkOperation alloc] init];
    operation.config = self.config;
    [operation start];
    self.operation = operation;
}


@end
