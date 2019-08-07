//
//  UIView+hs_networkd.m
//
//  Created by 王金东 on 14-7-30.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import "UIView+hs_network.h"
#import <objc/runtime.h>
#import <AFNetworking/AFNetworking.h>


static const void *_netWorkRequestKey = &_netWorkRequestKey;

@implementation UIView (hs_network)

+ (void)load {
     Method m1;
     Method m2;
     //将方法替换
     m1 = class_getInstanceMethod(self, @selector(newRemoveFromSuperview));
     m2 = class_getInstanceMethod(self, @selector(removeFromSuperview));
     method_exchangeImplementations(m1, m2);
}

- (void)newRemoveFromSuperview {
    if(self._request != nil){
        [self._request cancel];
        [self _setRequest:nil];
    }
    //表面调用的自己 其实调用的是dealloc方法
    [self newRemoveFromSuperview];
}

- (BOOL)running {
    return self._request.running;
}
- (JDRequest *)_request {
    return objc_getAssociatedObject(self, _netWorkRequestKey);
}
- (void)_setRequest:(JDRequest *)request {
    objc_setAssociatedObject(self, _netWorkRequestKey, request, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView *(^)(Class))jd_request {
    __weak UIView *_weaskSelf = self;
    return ^(Class clazz){
        [_weaskSelf _setRequest:[[clazz alloc] init]];
        return _weaskSelf;
    };
}
- (UIView *(^)(NSString *url))jd_url {
    __weak UIView *_weaskSelf = self;
    return ^(NSString *url){
        JDRequest *request = [_weaskSelf _request];
        request.url = url;
        return _weaskSelf;
    };
}

- (UIView *(^)(NSString *key,id obj))jd_param {
    __weak UIView *_weaskSelf = self;
    return ^(NSString *key,id obj){
        JDRequest *request = [_weaskSelf _request];
        [request.params setValue:obj forKey:key];
        return _weaskSelf;
    };
}
- (UIView *(^)(NSDictionary *))jd_params {
    __weak UIView *_weaskSelf = self;
    return ^(NSDictionary *params){
        JDRequest *request = [_weaskSelf _request];
        request.params = params.mutableCopy;
        return _weaskSelf;
    };
}

- (UIView *(^)(NSString *method))jd_method {
    __weak UIView *_weaskSelf = self;
    return ^(NSString *method){
        JDRequest *request = [_weaskSelf _request];
        request.method = method;
        return _weaskSelf;
    };
}
- (UIView *(^)(BOOL isProgress))jd_isProgress {
    __weak UIView *_weaskSelf = self;
    return ^(BOOL isProgress){
        JDRequest *request = [_weaskSelf _request];
        request.isProgress = isProgress;
        return _weaskSelf;
    };
}
- (UIView *(^)(BOOL secure))jd_secure {
    __weak UIView *_weaskSelf = self;
    return ^(BOOL secure){
        JDRequest *request = [_weaskSelf _request];
        request.secure = secure;
        return _weaskSelf;
    };
}
- (UIView *(^)(BOOL ssl))jd_ssl {
    __weak UIView *_weaskSelf = self;
    return ^(BOOL ssl){
        JDRequest *request = [_weaskSelf _request];
        request.ssl = ssl;
        return _weaskSelf;
    };
}

- (UIView *(^)(CompletionBlock success))jd_success {
    __weak UIView *_weaskSelf = self;
    return ^(CompletionBlock success){
        JDRequest *request = [_weaskSelf _request];
        request.success = success ;
        return _weaskSelf;
    };
}
- (UIView *(^)(ErrorBlock error))jd_error {
    __weak UIView *_weaskSelf = self;
    return ^(ErrorBlock error){
        JDRequest *request = [_weaskSelf _request];
        request.error = error ;
        return _weaskSelf;
    };
}
- (UIView *(^)())jd_send {
    __weak UIView *_weaskSelf = self;
    return ^(){
        [_weaskSelf _request].view = _weaskSelf;
        [[_weaskSelf _request] sendRequest];
        return _weaskSelf;
    };
}



@end
