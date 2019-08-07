//
//  JDNetwork.m
//
//  Created by JD on 15/7/7.
//  Copyright (c) 2015年 JD. All rights reserved.
//

#import "JDNetwork.h"
#import "JDNetworkOperation.h"

@interface JDNetwork ()

@property (nonatomic, weak) JDNetworkOperation *operation;

@end

@implementation JDNetwork

+ (JDNetwork *(^)(NSString *))get {
    return ^(NSString *pathOrFullURLString){
        JDNetwork *requst = [[self alloc] init];
        JDNetworkEntity *entity = [[JDNetworkEntity alloc] init];
        entity.request.pathOrFullURLString = pathOrFullURLString;
        entity.request.HTTPMethod = @"GET";
        requst->entity = entity;
        return requst;
    };
}

+ (JDNetwork *(^)(NSString *))post {
    return ^(NSString *pathOrFullURLString){
        JDNetwork *requst = [[self alloc] init];
        JDNetworkEntity *entity = [[JDNetworkEntity alloc] init];
        entity.request.pathOrFullURLString = pathOrFullURLString;
        entity.request.HTTPMethod = @"POST";
        requst->entity = entity;
        return requst;
    };
}

+ (JDNetwork *(^)(NSString *))baseURLString {
    return ^(NSString *baseURLString){
        JDNetwork *requst = [[self alloc] init];
        JDNetworkEntity *entity = [[JDNetworkEntity alloc] init];
        entity.request.baseURLString = baseURLString;
        requst->entity = entity;
        return requst;
    };
}

- (JDNetwork *(^)(NSString *))get {
    return ^(NSString *pathOrFullURLString){
        self->entity.request.pathOrFullURLString = pathOrFullURLString;
        self->entity.request.HTTPMethod = @"GET";
        return self;
    };
}

- (JDNetwork *(^)(NSString *))post {
    return ^(NSString *pathOrFullURLString){
        self->entity.request.pathOrFullURLString = pathOrFullURLString;
        self->entity.request.HTTPMethod = @"POST";
        return self;
    };
}

- (JDNetwork *(^)(id<JDNetworkInterceptor>))addInterceptor {
    return ^(id<JDNetworkInterceptor> interceptor){
        [self->entity addInterceptor:interceptor];
        return self;
    };
}

- (JDNetwork *(^)(NSString *key,id obj))parametersForKey {
    return ^(NSString *key,id obj){
        [self->entity.request addParameter:obj forKey:key];
        return self;
    };
}

- (JDNetwork *(^)(NSDictionary *))parameters {
    return ^(NSDictionary *params){
        self->entity.request.parameters = params.mutableCopy;
        return self;
    };
}

- (JDNetwork *(^)(NSString *HTTPMethod))HTTPMethod {
    return ^(NSString *HTTPMethod){
        self->entity.request.HTTPMethod = HTTPMethod;
        return self;
    };
}

- (JDNetwork *(^)(CGFloat))timeoutInterval {
    return ^(CGFloat timeoutInterval){
        self->entity.request.timeoutInterval = timeoutInterval;
        return self;
    };
}

- (JDNetwork *(^)(JDNetworkParameterEncoding))parameterEncoding {
    return ^(JDNetworkParameterEncoding parameterEncoding) {
        self->entity.request.parameterEncoding = parameterEncoding;
        return self;
    };
}

- (JDNetwork *(^)(JDNetworkResponseEncoding))responseEncoding {
    return ^(JDNetworkResponseEncoding responseEncoding) {
        self->entity.response.responseEncoding = responseEncoding;
        return self;
    };
}

- (JDNetwork *(^)(JDNetworkCompletionBlock successResponse))successResponse {
    return ^(JDNetworkCompletionBlock successResponse){
        self->entity.successResponse = successResponse ;
        return self;
    };
}

- (JDNetwork *(^)(JDNetworkErrorBlock errorResponse))errorResponse {
    return ^(JDNetworkErrorBlock errorResponse){
        self->entity.errorResponse = errorResponse ;
        return self;
    };
}

- (void(^)(void))start {
    __weak JDNetwork *_weaskSelf = self;
    return ^(void){
        [_weaskSelf _start];
    };
}

- (void (^)(void))cancel {
    __weak JDNetwork *_weaskSelf = self;
    return ^(void) {
        [_weaskSelf.operation cancel];
    };
}

- (BOOL)running {
    return self.operation.running;
}

#pragma mark 私有方法 -------------

- (void)_start {
    JDNetworkOperation *operation = [[JDNetworkOperation alloc] init];
    operation.entity = self->entity;
    [operation start];
    self.operation = operation;
}

- (void)dealloc {
    NSLog(@"%@ dealloc",NSStringFromClass(self.class));
}

@end
