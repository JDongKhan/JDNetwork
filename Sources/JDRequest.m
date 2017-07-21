//
//  JDRequest.m
//
//  Created by 王金东 on 15/7/7.
//  Copyright (c) 2015年 王金东. All rights reserved.
//

#import "JDRequest.h"
#import "JDNetWork.h"

@interface JDRequest ()<JDNetWorkDelegate>
@end

@implementation JDRequest {
    id _task;
}

- (instancetype)init {
    if(self = [super init]){
        _params = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)urlRequestWillStart:(JDRequest *)request {
    //显示等待框
}

- (NSDictionary *)urlRequestWillHandleParams:(JDRequest *)request {
    return request.params;
}
/**
 *  @author wangjindong, 16-01-15 18:01:56
 *
 *  @brief 请求任务开始
 *
 *  @param task 任务
 *  @param request request
 *
 */
- (void)urlRequestDidStart:(JDRequest *)request task:(id)task {

}

/**
 *  @author wangjindong
 *
 *  处理成功block
 *
 *  @param request request
 */
- (void)urlRequest:(JDRequest *)request sourceDic:(NSDictionary*)sourceDic {
    //取消等待框
    if (sourceDic != nil) {
        if(request.success != nil){
            request.success(sourceDic);
        }
    }else if (request.error != nil) {
        request.error(nil);
    }
}


/**
 *  @author wangjindong
 *
 *  处理失败
 *
 *  @param request      request
 *
 */
- (void)urlRequest:(JDRequest *)request error:(NSError*)error {
    if (request.error != nil) {
        request.error(nil);
    }
}


- (BOOL)running {
    return ((NSURLSessionTask *)_task).state == NSURLSessionTaskStateRunning;
}


- (void)clear {
    self.url = nil;
    self.method = nil;
    self.success = nil;
    self.error = nil;
    self.isProgress = NO;
    self.secure = NO;
    self.ssl = NO;
}

- (void)sendRequest {
    _task = [JDNetWork urlRequestWithProgressView:self delegate:self];
    
}

- (void)cancel {
    [_task cancel];
}

@end


@implementation JDRequest (netoworkBlock)

+ (JDRequest *(^)())jd_request {
    return ^(){
        JDRequest *requst = [[self alloc] init];
        return requst;
    };
}
- (JDRequest *(^)(NSString *url))jd_url {
    __weak JDRequest *_weaskSelf = self;
    return ^(NSString *url){
        _weaskSelf.url = url;
        return _weaskSelf;
    };
}
- (JDRequest *(^)(NSString *key,id obj))jd_param {
    __weak JDRequest *_weaskSelf = self;
    return ^(NSString *key,id obj){
        [_weaskSelf.params setValue:obj forKey:key];
        return _weaskSelf;
    };
}
- (JDRequest *(^)(NSDictionary *))jd_params {
    __weak JDRequest *_weaskSelf = self;
    return ^(NSDictionary *params){
        _weaskSelf.params = params.mutableCopy;
        return _weaskSelf;
    };
}

- (JDRequest *(^)(NSString *method))jd_method {
    __weak JDRequest *_weaskSelf = self;
    return ^(NSString *method){
        _weaskSelf.method = method;
        return _weaskSelf;
    };
}
- (JDRequest *(^)(BOOL isProgress))jd_isProgress {
    __weak JDRequest *_weaskSelf = self;
    return ^(BOOL isProgress){
        _weaskSelf.isProgress = isProgress;
        return _weaskSelf;
    };
}
- (JDRequest *(^)(BOOL secure))jd_secure {
    __weak JDRequest *_weaskSelf = self;
    return ^(BOOL secure){
        _weaskSelf.secure = secure;
        return _weaskSelf;
    };
}
- (JDRequest *(^)(BOOL ssl))jd_ssl {
    __weak JDRequest *_weaskSelf = self;
    return ^(BOOL ssl){
        _weaskSelf.ssl = ssl;
        return _weaskSelf;
    };
}

- (JDRequest *(^)(CompletionBlock success))jd_success {
    __weak JDRequest *_weaskSelf = self;
    return ^(CompletionBlock success){
        _weaskSelf.success = success ;
        return _weaskSelf;
    };
}
- (JDRequest *(^)(ErrorBlock error))jd_error {
    __weak JDRequest *_weaskSelf = self;
    return ^(ErrorBlock error){
        _weaskSelf.error = error ;
        return _weaskSelf;
    };
}
- (JDRequest *(^)())jd_send {
    __weak JDRequest *_weaskSelf = self;
    return ^(){
        [_weaskSelf sendRequest];
        return _weaskSelf;
    };
}

@end
