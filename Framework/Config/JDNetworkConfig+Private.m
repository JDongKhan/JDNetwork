//
//  JDNetworkConfig+Private.m
//  JDNetwork
//
//  Created by JD on 2019/6/7.
//  Copyright © 2019 王金东. All rights reserved.
//

#import "JDNetworkConfig+Private.h"

@implementation JDNetworkConfig (Private)

- (AFHTTPSessionManager *)sessionManager {
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] init];
    //request
    sessionManager.requestSerializer = [self requestSerializer];
    CGFloat timeoutInterval = self.timeoutInterval;
    if (timeoutInterval == 0) {
        timeoutInterval = 20.0f;
    }
    sessionManager.requestSerializer.timeoutInterval = timeoutInterval;
    //response
    sessionManager.responseSerializer = [self responseSerializer];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/json",@"text/javascript",nil];
    return sessionManager;
}

- (AFHTTPRequestSerializer<AFURLRequestSerialization> *)requestSerializer {
    switch (self.parameterEncoding) {
        case JDNetworkParameterJSONEncoding: {
            return [AFJSONRequestSerializer serializer];
        }
        case JDNetworkParameterPropertyListEncoding: {
            return [AFPropertyListRequestSerializer serializer];
        }
        default: {
            return [AFHTTPRequestSerializer serializer];
        }
    }
}

- (AFHTTPResponseSerializer<AFURLResponseSerialization> *)responseSerializer {
    switch (self.responseEncoding) {
        case JDNetworkResponseJSONEncoding:
            return [AFJSONResponseSerializer serializer];
        case JDNetworkResponseXMLParserEncoding:
            return [AFXMLParserResponseSerializer serializer];
        case JDNetworkResponsePropertyListEncoding:
            return [AFPropertyListResponseSerializer serializer];
        case JDNetworkResponseImageEncoding:
            return [AFImageResponseSerializer serializer];
        default:
            return [AFHTTPResponseSerializer serializer];
    }
}


- (NSMutableURLRequest *)request {
    NSMutableURLRequest *request = nil;
    NSError *serializationError = nil;
    if(self.usedMultipartFormData){
        //TODO下面的方法没有测试，待完善
        //有文件
        NSMutableDictionary *_files;
        for (NSString * key in self.parameters.allKeys) {
            id value = self.parameters[key];
            //判断请求参数是否是文件数据
            if ([value isKindOfClass:[NSData class]]) {
                if(_files == nil){
                    _files = [NSMutableDictionary dictionary];
                }
                _files[key] = value;
            }
        }
        request = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:self.fullURLString parameters:self.parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            for (NSString *key in _files) {
                id value = _files[key];
                [formData
                 appendPartWithFileData:value
                 name:key
                 fileName:key
                 mimeType:@"image/jpeg"];
            }
        } error:&serializationError];
        
        if (serializationError != nil) {
            [self reportError:serializationError];
            return nil;
        }
        
    }else{
        request = [self.requestSerializer requestWithMethod:self.HTTPMethod URLString:self.fullURLString parameters:self.parameters error:&serializationError];
        
        if (serializationError != nil) {
            [self reportError:serializationError];
            return nil;
        }
    }
    
    return request;
}


- (BOOL)shouldCache {
    return self.cachePolicy != JDNetworkCachePolicyIgnored;
}


- (BOOL)shouldContinueRequestAfterLoaded {
    switch (self.cachePolicy) {
        case JDNetworkCachePolicyUsesCacheWhenNetworkUnreachable:
        case JDNetworkCachePolicyDoesNotRequestWithinDuration:
        return NO;
        default:
            break;
    }
    return YES;
}



- (void)reportSuccess:(id)responseObject {
    if (self.successResponse != nil) {
        self.successResponse(responseObject);
    }
}

- (void)reportCacheData:(id)responseObject {
    if (self.cachedDataResponse != nil) {
        self.cachedDataResponse(responseObject);
    }
}

- (void)reportError:(NSError *)error {
    if (self.errorResponse != nil) {
        self.errorResponse(error);
    }
}

- (NSString *)keyForCaching {
    NSString *urlString = self.fullURLString;
    NSURL *url = [NSURL URLWithString:urlString];
    NSAssert(url != nil, @"The url is nil of %@", self.fullURLString);
    NSString *query = AFQueryStringFromParameters(self.parameters);
    if (query.length > 0) {
        NSString *queryToAppend = [NSString stringWithFormat:url.query ? @"&%@" : @"?%@", query];
        urlString = [urlString stringByAppendingString:queryToAppend];
    }
    return urlString;
}

- (NSString *)fullURLString {
    return [NSURL URLWithString:self.pathOrFullURLString relativeToURL:[NSURL URLWithString:self.baseURLString]].absoluteString;
}

@end
