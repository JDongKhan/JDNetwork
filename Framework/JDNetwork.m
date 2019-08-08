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

+ (JDNetwork *(^)(NSString *))GET {
    return ^(NSString *fullURLString){
        JDNetwork *requst = [[self alloc] init];
        JDNetworkEntity *entity = [[JDNetworkEntity alloc] init];
        entity.request.pathOrFullURLString = fullURLString;
        entity.request.HTTPMethod = @"GET";
        requst->entity = entity;
        return requst;
    };
}

+ (JDNetwork *(^)(NSString *))POST {
    return ^(NSString *fullURLString){
        JDNetwork *requst = [[self alloc] init];
        JDNetworkEntity *entity = [[JDNetworkEntity alloc] init];
        entity.request.pathOrFullURLString = fullURLString;
        entity.request.HTTPMethod = @"POST";
        requst->entity = entity;
        return requst;
    };
}

+ (JDNetwork *(^)(NSString *))HEAD {
    return ^(NSString *fullURLString){
        JDNetwork *requst = [[self alloc] init];
        JDNetworkEntity *entity = [[JDNetworkEntity alloc] init];
        entity.request.pathOrFullURLString = fullURLString;
        entity.request.HTTPMethod = @"HEAD";
        requst->entity = entity;
        return requst;
    };
}

+ (JDNetwork *(^)(NSString *))PUT {
    return ^(NSString *fullURLString){
        JDNetwork *requst = [[self alloc] init];
        JDNetworkEntity *entity = [[JDNetworkEntity alloc] init];
        entity.request.pathOrFullURLString = fullURLString;
        entity.request.HTTPMethod = @"PUT";
        requst->entity = entity;
        return requst;
    };
}

+ (JDNetwork *(^)(NSString *))DELETE {
    return ^(NSString *fullURLString){
        JDNetwork *requst = [[self alloc] init];
        JDNetworkEntity *entity = [[JDNetworkEntity alloc] init];
        entity.request.pathOrFullURLString = fullURLString;
        entity.request.HTTPMethod = @"DELETE";
        requst->entity = entity;
        return requst;
    };
}

+ (JDNetwork *(^)(NSString *))PATCH {
    return ^(NSString *fullURLString){
        JDNetwork *requst = [[self alloc] init];
        JDNetworkEntity *entity = [[JDNetworkEntity alloc] init];
        entity.request.pathOrFullURLString = fullURLString;
        entity.request.HTTPMethod = @"PATCH";
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

- (JDNetwork *(^)(NSString *))GET {
    return ^(NSString *pathOrFullURLString){
        self->entity.request.pathOrFullURLString = pathOrFullURLString;
        self->entity.request.HTTPMethod = @"GET";
        return self;
    };
}

- (JDNetwork *(^)(NSString *))POST {
    return ^(NSString *pathOrFullURLString){
        self->entity.request.pathOrFullURLString = pathOrFullURLString;
        self->entity.request.HTTPMethod = @"POST";
        return self;
    };
}

- (JDNetwork *(^)(NSString *))HEAD {
    return ^(NSString *pathOrFullURLString){
        self->entity.request.pathOrFullURLString = pathOrFullURLString;
        self->entity.request.HTTPMethod = @"HEAD";
        return self;
    };
}

- (JDNetwork *(^)(NSString *))PUT {
    return ^(NSString *pathOrFullURLString){
        self->entity.request.pathOrFullURLString = pathOrFullURLString;
        self->entity.request.HTTPMethod = @"PUT";
        return self;
    };
}

- (JDNetwork *(^)(NSString *))DELETE {
    return ^(NSString *pathOrFullURLString){
        self->entity.request.pathOrFullURLString = pathOrFullURLString;
        self->entity.request.HTTPMethod = @"DELETE";
        return self;
    };
}

- (JDNetwork *(^)(NSString *))PATCH {
    return ^(NSString *pathOrFullURLString){
        self->entity.request.pathOrFullURLString = pathOrFullURLString;
        self->entity.request.HTTPMethod = @"PATCH";
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

- (JDNetwork *(^)(JDNetworkCompletionBlock success))success {
    return ^(JDNetworkCompletionBlock success){
        self->entity.success = success;
        return self;
    };
}

- (JDNetwork *(^)(JDNetworkErrorBlock error))error {
    return ^(JDNetworkErrorBlock error){
        self->entity.error = error;
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
