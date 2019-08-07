//
//  JDNetworkEntity+Private.h
//  JDNetwork
//
//  Created by JD on 2018/6/7.
//  Copyright © 2018 JD. All rights reserved.
//

#import "JDNetworkEntity.h"
#import <AFNetworking/AFNetworking.h>


NS_ASSUME_NONNULL_BEGIN

@interface JDRequest (Private)

@property (nonatomic, strong, readonly) AFHTTPRequestSerializer <AFURLRequestSerialization> *requestSerializer;

/**
 Responses sent from the server in data tasks created with `dataTaskWithRequest:success:failure:` and run using the `GET` / `POST` / et al. convenience methods are automatically validated and serialized by the response serializer. By default, this property is set to an instance of `AFJSONResponseSerializer`.
 
 @warning `responseSerializer` must not be `nil`.
 */
@property (nonatomic, strong, readonly) AFHTTPResponseSerializer <AFURLResponseSerialization> *responseSerializer;


- (NSMutableURLRequest *)toRequest:(NSError **)error;

@end


@interface JDResponse (Private)

@end

@interface JDNetworkEntity (Private)

@property (nonatomic, strong, readonly) AFHTTPSessionManager *sessionManager;

- (void)reportResponse:(JDResponse *)response;

@end


NS_ASSUME_NONNULL_END
