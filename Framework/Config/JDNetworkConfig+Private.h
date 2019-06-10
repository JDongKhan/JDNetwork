//
//  JDNetworkConfig+Private.h
//  JDNetwork
//
//  Created by JD on 2019/6/7.
//  Copyright © 2019 王金东. All rights reserved.
//

#import "JDNetworkConfig.h"
#import <AFNetworking/AFNetworking.h>


NS_ASSUME_NONNULL_BEGIN

@interface JDNetworkConfig (Private)

@property (nonatomic, strong, readonly) AFHTTPSessionManager *sessionManager;

@property (nonatomic, strong, readonly) AFHTTPRequestSerializer <AFURLRequestSerialization> *requestSerializer;

/**
 Responses sent from the server in data tasks created with `dataTaskWithRequest:success:failure:` and run using the `GET` / `POST` / et al. convenience methods are automatically validated and serialized by the response serializer. By default, this property is set to an instance of `AFJSONResponseSerializer`.
 
 @warning `responseSerializer` must not be `nil`.
 */
@property (nonatomic, strong, readonly) AFHTTPResponseSerializer <AFURLResponseSerialization> *responseSerializer;

/**
 request
 */
@property (nonatomic, strong, readonly) NSMutableURLRequest *request;

/**
 keyForCaching
 */
@property (nonatomic, copy, readonly) NSString *keyForCaching;


@property (nonatomic, readonly) BOOL shouldCache;

@property (nonatomic, readonly) BOOL shouldContinueRequestAfterLoaded;


//回调数据出去
- (void)reportSuccess:(id)responseObject;

- (void)reportCacheData:(id)responseObject;

- (void)reportError:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
