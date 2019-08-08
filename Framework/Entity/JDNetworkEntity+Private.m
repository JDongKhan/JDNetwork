//
//  JDNetworkEntity+Private.m
//  JDNetwork
//
//  Created by JD on 2015/6/7.
//  Copyright © 2015 JD. All rights reserved.
//

#import "JDNetworkEntity+Private.h"

@implementation JDRequest (Private)

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

- (NSURLRequest *)convertToNSURLRequest:(NSError **)error {
    NSMutableURLRequest *request = nil;
    NSError *serializationError = nil;
    
    NSString *fullURLString = [NSURL URLWithString:self.pathOrFullURLString relativeToURL:[NSURL URLWithString:self.baseURLString]].absoluteString;
    
    if (self.usedMultipartFormData) {
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
        request = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:fullURLString parameters:self.parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
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
            *error = serializationError;
            return nil;
        }
        
    } else {
        request = [self.requestSerializer requestWithMethod:self.HTTPMethod URLString:fullURLString parameters:self.parameters error:&serializationError];
        if (serializationError != nil) {
            *error = serializationError;
            return nil;
        }
    }
    return request;
}

@end

@implementation JDResponse (Private)


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


@end


@implementation JDNetworkEntity (Private)


- (AFHTTPSessionManager *)sessionManager {
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] init];
    //request
    sessionManager.requestSerializer = [self.request requestSerializer];
    CGFloat timeoutInterval = self.request.timeoutInterval;
    if (timeoutInterval == 0) {
        timeoutInterval = 20.0f;
    }
    sessionManager.requestSerializer.timeoutInterval = timeoutInterval;
    //response
    sessionManager.responseSerializer = [self.response responseSerializer];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/json",@"text/javascript",nil];
    return sessionManager;
}

- (void)reportResponse:(JDResponse *)response {
    if (response.error != nil) {
        [self reportError:response.error];
        return;
    }
    [self reportSuccess:response.responseObject];
//    if (originalRequest.shouldCache) {
//        [JDNetworkCache saveResponseToCacheFile:responseObject andURL:originalRequest.keyForCaching];
//    }
    
}

- (void)reportSuccess:(id)responseObject {
    if (self.success != nil) {
        self.success(responseObject);
    }
}

- (void)reportError:(NSError *)error {
    if (self.error != nil) {
        self.error(error);
    }
}

@end

