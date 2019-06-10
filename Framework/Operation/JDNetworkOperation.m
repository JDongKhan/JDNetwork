//
//  JDNetworkOperation.m
//  JDNetwork
//
//  Created by JD on 2015/6/7.
//  Copyright © 2015 王金东. All rights reserved.
//

#import "JDNetworkOperation.h"
#import <AFNetworking/AFNetworking.h>
#import "JDNetworkConfig+Private.h"
#import "JDNetworkCache.h"

@interface JDNetworkOperation()

@property (nonatomic, assign) BOOL task_running;

@property (nonatomic, strong) NSURLSessionTask *task;

@end

@implementation JDNetworkOperation

- (void)start {
    
    if (self.task_running) {
        return;
    }

    //加载缓存
    if ([self loadCacheData] && ![self.config shouldContinueRequestAfterLoaded]) {
        return;
    }
    
    //请求
    //此处不要使用weak，因为外界可能没有持有JDNetworkOperation导致其已经释放了
    void (^completionBlock)(NSURLResponse *,id,NSError *) = ^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error){
        if (error != nil) {
            [self.config reportError:error];
            return;
        }
        [self.config reportSuccess:responseObject];
        if (self.config.shouldCache) {
            [JDNetworkCache saveResponseToCacheFile:responseObject andURL:self.config.keyForCaching];
        }
        
        self.task_running = NO;
    };
    
    //创建request请求管理对象
    AFHTTPSessionManager *manager = _config.sessionManager;
  
    NSURLSessionTask *task = nil;
    if(_config.usedMultipartFormData) {
        task = [manager uploadTaskWithStreamedRequest:_config.request progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } completionHandler:completionBlock];
    } else {

        task = [manager dataTaskWithRequest:_config.request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
            
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

//处理缓存
- (BOOL)loadCacheData {
    if (self.config.shouldCache) {
        id response = [JDNetworkCache cacheWithURL:self.config.keyForCaching];
        if (response) {
            [self.config reportCacheData:response];
            return YES;
        }
    }
    return NO;
}

- (BOOL)running {
    return _task.state == NSURLSessionTaskStateRunning;
}

- (void)cancel {
    [self.task cancel];
}

@end
