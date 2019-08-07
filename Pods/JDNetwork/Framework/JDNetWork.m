//
//  JDNetWork.m
//
//  Created by 王金东 on 14/12/10.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import "JDNetWork.h"
#import <objc/runtime.h>
#import <objc/message.h>


@implementation JDNetWork


+ (id)urlRequestWithProgressView:(JDRequest *)request
                        delegate:(id<JDNetWorkDelegate>)delegate{
    NSDictionary *_params = [request _requestParams];
    request.params = _params.mutableCopy;
    
    NSString *method = request.method;
    //请求开始
    [self urlRequestWillStart:request delegate:delegate];
    //默认GET
    if (method == nil) {
        method = @"GET";
    }
    //处理url
    NSString *url = [self _urlRequestHandleUrl:request];
    NSLog(@"\r\n请求地址为:%@\r\n请求方式:%@\r\n请求参数:%@",url,method,_params);
    NSURL *toUrl = [NSURL URLWithString:url];
    if(toUrl == nil){
        [self urlRequest:request
                       error:[NSError errorWithDomain:@"url is null" code:-99 userInfo:nil]
                    delegate:delegate
         ];
        return nil;
    }
    
    //组织参数
    id requestParams = [self urlRequestWillHandleParams:request delegate:delegate];
    //创建request请求管理对象
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
//    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;

    //参数是String
    if ([requestParams isKindOfClass:[NSString class]]) {
        AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.requestSerializer = requestSerializer;
        [requestSerializer setQueryStringSerializationWithBlock:^(NSURLRequest *request, id parameters, NSError *__autoreleasing *error) {
            return parameters;
        }];
    }else{
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    //设置超时时间
    manager.requestSerializer.timeoutInterval = 30.0f;
    // 设置返回格式
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSURLSessionDataTask *task = nil;
    void (^success)(NSURLSessionDataTask * _Nonnull, id _Nullable) = ^(NSURLSessionDataTask *task, id responseObject) {
        [self urlRequest:request sourceDic:responseObject delegate:delegate];
    };
    void (^failure)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull) = ^(NSURLSessionDataTask *task, NSError *error) {
        [self urlRequest:request error:error delegate:delegate];
    };
    //POST请求
    NSComparisonResult comparisonResult = [method caseInsensitiveCompare:@"POST"];
    NSMutableDictionary *_files;
    if (comparisonResult == NSOrderedSame) {
        for (NSString * key in _params.allKeys) {
            id value = _params[key];
            //判断请求参数是否是文件数据
            if ([value isKindOfClass:[NSData class]]) {
                if(_files == nil){
                    _files = [NSMutableDictionary dictionary];
                }
                _files[key] = value;
            }
        }
    }
    //有文件
    if(_files){
            task =  [manager POST:url
                       parameters:requestParams
        constructingBodyWithBlock:^(id formData) {
                    for (NSString *key in _files) {
                            id value = _params[key];
                            [formData
                              appendPartWithFileData:value
                                                name:key
                                            fileName:key
                                            mimeType:@"image/jpeg"];
                    }
                }
                         progress:nil
                          success:success failure:failure];
    }else{
        #pragma clang diagnostic push //收集当前的警告
        #pragma clang diagnostic ignored "-Wundeclared-selector"
        SEL typeFunc = @selector(dataTaskWithHTTPMethod:URLString:parameters:uploadProgress:downloadProgress:success:failure:);
        #pragma clang diagnostic pop //弹出所有的警告
        task = ((NSURLSessionDataTask*(*)(id,SEL,NSString*,NSString*,NSDictionary*,id,id,id,id))objc_msgSend)(manager, typeFunc, method, url,requestParams,nil,nil,success,failure);
        [task resume];
    }
    
    //if([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 ){
        //[[NSNotificationCenter defaultCenter] postNotificationName:AFNetworkingTaskDidResumeNotification object:task];
    //}
    //任务开始
    [self urlRequestDidStart:request task:task delegate:delegate];
    return task;
}

+  (void)urlRequestWithUploadFile:(NSString *)urlString
                   params:(NSDictionary *)params
               httpMethod:(NSString*)method
                   secure:(BOOL)secure
                      ssl:(BOOL)ssl
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure {
    
    JDRequest *request = [[JDRequest alloc] init];
    request.url = urlString;
    request.method = method;
    request.secure = secure;
    request.ssl = ssl;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:request.url parameters:[request _requestParams] constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if(block)block(formData);
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //打印下上传进度
        NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //请求成功
        NSLog(@"请求成功：%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        NSLog(@"请求失败：%@",error);
    }];
}

//下载
+  (void)urlRequestWithDownloadFile:(NSString *)urlString
                     params:(NSDictionary *)params
                 httpMethod:(NSString*)method
                     secure:(BOOL)secure
                        ssl:(BOOL)ssl
                    success:(void (^)(id responseObject))success
                    failure:(void (^)(NSError *error))failure {
    JDRequest *rq = [[JDRequest alloc] init];
    rq.url = urlString;
    rq.method = method;
    rq.secure = secure;
    rq.ssl = ssl;
    //创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURL *_url = [NSURL URLWithString:rq.url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:_url];
    NSComparisonResult compResult2 = [method caseInsensitiveCompare:@"POST"];
    if (compResult2 == NSOrderedSame) {
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:params options:0 error:nil]];
    }
    //下载任务
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //打印下下载进度
        NSLog(@"%lf",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //下载地址
        NSLog(@"默认下载地址:%@",targetPath);
        //设置下载路径，通过沙盒获取缓存地址，最后返回NSURL对象
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        return [NSURL fileURLWithPath:filePath];
        

    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        //下载完成调用的方法
        NSLog(@"下载完成：");
        NSLog(@"%@--%@",response,filePath);
        
    }];
    
    //开始启动任务
    [task resume];
}

#pragma mark -----------------------private------------------------
+ (NSString *)_urlRequestHandleUrl:(JDRequest *)request {
    return [NSString stringWithFormat:@"%@://%@",request.ssl?@"https://":@"http",request.url];
}
#pragma mark --------------------------可重写-------------------------

+ (void)urlRequestWillStart:(JDRequest *)request
                   delegate:(id<JDNetWorkDelegate>)delegate {
    if (delegate && [delegate respondsToSelector:@selector(urlRequestWillStart:)]) {
        [delegate urlRequestWillStart:request];
    }
}
+ (NSDictionary *)urlRequestWillHandleParams:(JDRequest *)request delegate:(id<JDNetWorkDelegate>)delegate {
    if (delegate && [delegate respondsToSelector:@selector(urlRequestWillHandleParams:)]) {
        [delegate urlRequestWillHandleParams:request];
    }
    return request.params;
}

+ (void)urlRequestDidStart:(JDRequest *)request
                      task:(id)task
                  delegate:(id<JDNetWorkDelegate>)delegate {
    if (delegate && [delegate respondsToSelector:@selector(urlRequestDidStart:task:)]) {
        [delegate urlRequestDidStart:request task:task];
    }
}


//处理异常
+ (void)urlRequest:(JDRequest *)request
                sourceDic:(NSDictionary*)sourceDic
                 delegate:(id<JDNetWorkDelegate>)delegate {
    if (delegate && [delegate respondsToSelector:@selector(urlRequest:sourceDic:)]) {
        [delegate urlRequest:request sourceDic:sourceDic];
    }else{
        if(request.view != nil){
            //__weak JDNetWork *engine = self;
        }else{
            if(request.isProgress){
           //     [[JDDialog shareInstance] dismissAfterDelay:1.0f];
            }
        }
        //取消等待框
        if (sourceDic != nil) {
            if(request.success != nil){
                request.success(sourceDic);
            }
        }else{
            if (request.error != nil) {
                request.error(nil);
            }
          //网络异常或数据不正确
        }
    }
}


//处理异常
+ (void)urlRequest:(JDRequest *)request
                 error:(NSError*)error
              delegate:(id<JDNetWorkDelegate>)delegate {
    if (delegate && [delegate respondsToSelector:@selector(urlRequest:error:)]) {
        [delegate urlRequest:request error:error];
    }else{
        if(request.view != nil){
            //__weak JDNetWork *engine = self;
        }else{
            if(request.isProgress){
                //[[JDDialog shareInstance] dismissAfterDelay:1.0f];
            }
        }
        if (request.error != nil) {
            request.error(nil);
        }
    }
}


@end


@implementation JDRequest (params)
- (NSDictionary *)_requestParams {
    NSMutableDictionary *ps = [NSMutableDictionary dictionaryWithDictionary:self.params];
    if(ps.count > 0){
        return ps;
    }
    Class clazz = [self class];
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList(clazz, &outCount);
    for(unsigned int i = 0; i < outCount; i ++){
        objc_property_t pt = properties[i];
        const char *name = property_getName(pt);
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [ps setValue:value forKey:key];
    }
    free(properties);
    return ps;
}
@end



