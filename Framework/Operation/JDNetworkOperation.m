//
//  JDNetworkOperation.m
//  JDNetwork
//
//  Created by JD on 2015/6/7.
//  Copyright © 2015 JD. All rights reserved.
//

#import "JDNetworkOperation.h"
#import <AFNetworking/AFNetworking.h>
#import "JDNetworkEntity+Private.h"
#import "JDNetworkCache.h"
#import "JDNetworkInterceptor.h"

@interface JDNetworkOperation()

@property (nonatomic, assign) BOOL task_running;

@property (nonatomic, strong) NSURLSessionTask *task;

@end

@implementation JDNetworkOperation

- (void)start {
    //拦截处理request
    JDNetworkEntity *entity = self.entity;
    JDNetworkChain *chain = [[JDNetworkChain alloc] initWithOperation:self];
    chain.entity = entity;
    
    //common interceptor
    BOOL intercept = NO;
    NSArray *sortInterceptors = [entity sortInterceptorsArrayByPriority];
    for (id<JDNetworkInterceptor> interceptor in sortInterceptors) {
        if ((intercept = [interceptor intercept:chain])) {
            break;
        }
    }
    
    //finally interceptor
    NSArray *sortFinallyInterceptors = [entity sortFinallyInterceptorsArrayByPriority];
    for (id<JDNetworkInterceptor> interceptor in sortFinallyInterceptors) {
        if ((intercept = [interceptor intercept:chain])) {
            break;
        }
    }
    
    if (intercept) {
        return;
    }
    
    NSError *error = nil;
    JDRequest *resultRequest = chain.entity.request;
    NSURLRequest *request = [resultRequest convertToURLRequest:&error];
    
    if (self.task_running) {
        return;
    }
    
    void (^completionBlock)(NSURLResponse *,id,NSError *) = ^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error){
        JDResponse *resultResponse = [entity.response copy];
        resultResponse.response = response;
        resultResponse.responseObject = responseObject;
        resultResponse.error = error;
        resultResponse.source = JDResponseNetworkSource;
        
        //common interceptor
        for (id<JDNetworkInterceptor> interceptor in sortInterceptors) {
            if ([interceptor respondsToSelector:@selector(disposeOfResponse:)]) {
                [interceptor disposeOfResponse:resultResponse];
            }
        }
        
        //finally interceptor
        for (id<JDNetworkInterceptor> interceptor in sortFinallyInterceptors) {
            if ([interceptor respondsToSelector:@selector(disposeOfResponse:)]) {
                [interceptor disposeOfResponse:resultResponse];
            }
        }
    
        [entity reportResponse:resultResponse];
        
        self.task_running = NO;
    };
    
    //创建request请求管理对象
    AFHTTPSessionManager *manager = entity.sessionManager;
    
    NSURLSessionTask *task = nil;
    
    NSAssert(request != nil, @"request is null ");
    if (resultRequest.usedMultipartFormData) {
        task = [manager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } completionHandler:completionBlock];
    } else {
        task = [manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
            
        } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
            
        } completionHandler:completionBlock];
    }
    [task resume];
    self.task_running = YES;
    self.task = task;
}

//TODO 
//下载 待实现
+ (void)urlRequestWithDownloadFile:(NSString *)urlString
                             params:(NSDictionary *)params
                         httpMethod:(NSString*)method
                             secure:(BOOL)secure
                                ssl:(BOOL)ssl
                            success:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure {
    
    //创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURL *_url = [NSURL URLWithString:urlString];
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

- (BOOL)running {
    return _task.state == NSURLSessionTaskStateRunning;
}

- (void)cancel {
    [self.task cancel];
}

- (void)dealloc {
//    NSLog(@"%@ dealloc",NSStringFromClass(self.class));
}

@end
