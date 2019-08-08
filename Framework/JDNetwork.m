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
        JDNetwork *network = [[self alloc] init];
        JDNetworkEntity *entity = [[JDNetworkEntity alloc] init];
        entity.request.pathOrFullURLString = fullURLString;
        entity.request.HTTPMethod = @"GET";
        network->entity = entity;
        return network;
    };
}

+ (JDNetwork *(^)(NSString *))POST {
    return ^(NSString *fullURLString){
        JDNetwork *network = [[self alloc] init];
        JDNetworkEntity *entity = [[JDNetworkEntity alloc] init];
        entity.request.pathOrFullURLString = fullURLString;
        entity.request.HTTPMethod = @"POST";
        network->entity = entity;
        return network;
    };
}

+ (JDNetwork *(^)(NSString *))HEAD {
    return ^(NSString *fullURLString){
        JDNetwork *network = [[self alloc] init];
        JDNetworkEntity *entity = [[JDNetworkEntity alloc] init];
        entity.request.pathOrFullURLString = fullURLString;
        entity.request.HTTPMethod = @"HEAD";
        network->entity = entity;
        return network;
    };
}

+ (JDNetwork *(^)(NSString *))PUT {
    return ^(NSString *fullURLString){
        JDNetwork *network = [[self alloc] init];
        JDNetworkEntity *entity = [[JDNetworkEntity alloc] init];
        entity.request.pathOrFullURLString = fullURLString;
        entity.request.HTTPMethod = @"PUT";
        network->entity = entity;
        return network;
    };
}

+ (JDNetwork *(^)(NSString *))DELETE {
    return ^(NSString *fullURLString){
        JDNetwork *network = [[self alloc] init];
        JDNetworkEntity *entity = [[JDNetworkEntity alloc] init];
        entity.request.pathOrFullURLString = fullURLString;
        entity.request.HTTPMethod = @"DELETE";
        network->entity = entity;
        return network;
    };
}

+ (JDNetwork *(^)(NSString *))PATCH {
    return ^(NSString *fullURLString){
        JDNetwork *network = [[self alloc] init];
        JDNetworkEntity *entity = [[JDNetworkEntity alloc] init];
        entity.request.pathOrFullURLString = fullURLString;
        entity.request.HTTPMethod = @"PATCH";
        network->entity = entity;
        return network;
    };
}

+ (JDNetwork *(^)(NSString *))baseURLString {
    return ^(NSString *baseURLString){
        JDNetwork *network = [[self alloc] init];
        JDNetworkEntity *entity = [[JDNetworkEntity alloc] init];
        entity.request.baseURLString = baseURLString;
        network->entity = entity;
        return network;
    };
}

- (JDNetwork *(^)(NSString *))GET {
    return ^(NSString *pathOrFullURLString){
        JDNetwork *network = [self copy];
        network->entity.request.pathOrFullURLString = pathOrFullURLString;
        network->entity.request.HTTPMethod = @"GET";
        return network;
    };
}

- (JDNetwork *(^)(NSString *))POST {
    return ^(NSString *pathOrFullURLString){
        JDNetwork *network = [self copy];
        network->entity.request.pathOrFullURLString = pathOrFullURLString;
        network->entity.request.HTTPMethod = @"POST";
        return network;
    };
}

- (JDNetwork *(^)(NSString *))HEAD {
    return ^(NSString *pathOrFullURLString){
        JDNetwork *network = [self copy];
        network->entity.request.pathOrFullURLString = pathOrFullURLString;
        network->entity.request.HTTPMethod = @"HEAD";
        return network;
    };
}

- (JDNetwork *(^)(NSString *))PUT {
    return ^(NSString *pathOrFullURLString){
        JDNetwork *network = [self copy];
        network->entity.request.pathOrFullURLString = pathOrFullURLString;
        network->entity.request.HTTPMethod = @"PUT";
        return network;
    };
}

- (JDNetwork *(^)(NSString *))DELETE {
    return ^(NSString *pathOrFullURLString){
        JDNetwork *network = [self copy];
        network->entity.request.pathOrFullURLString = pathOrFullURLString;
        network->entity.request.HTTPMethod = @"DELETE";
        return network;
    };
}

- (JDNetwork *(^)(NSString *))PATCH {
    return ^(NSString *pathOrFullURLString){
        JDNetwork *network = [self copy];
        network->entity.request.pathOrFullURLString = pathOrFullURLString;
        network->entity.request.HTTPMethod = @"PATCH";
        return network;
    };
}

- (JDNetwork *(^)(id<JDNetworkInterceptor>))addInterceptor {
    return ^(id<JDNetworkInterceptor> interceptor){
        [self->entity addInterceptor:interceptor];
        return self;
    };
}

- (JDNetwork *(^)(id<JDNetworkInterceptor>))addFinallyInterceptor {
    return ^(id<JDNetworkInterceptor> interceptor){
        [self->entity addFinallyInterceptor:interceptor];
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


- (id)copyWithZone:(NSZone *)zone {
    JDNetwork *network = [[[self class] allocWithZone:zone] init];
    network->entity = [self->entity copy];
    return network;
}

- (void)dealloc {
//    NSLog(@"%@ dealloc",NSStringFromClass(self.class));
}

@end
