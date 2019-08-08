//
//  JDRequest.h
//  JDNetwork
//
//  Created by JD on 2015/8/7.
//  Copyright © 2015 JD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, JDNetworkParameterEncoding) {
    JDNetworkParameterHTTPEncoding,
    JDNetworkParameterJSONEncoding,
    JDNetworkParameterPropertyListEncoding,
};

@interface JDRequest : NSObject<NSCopying>

/**
 base url,such as http://xxx/xxx/xx.do
 */
@property (nonatomic, copy) NSString *baseURLString;

/**
 request path， such as /xx/xx.do?xx=xx or http://xxx/xxx/xx.do?xx=xxx
 */
@property (nonatomic, copy) NSString *pathOrFullURLString;

/**
    baseURLString + pathOrFullURLString
    or
    pathOrFullURLString
 */
@property (nonatomic, copy, readonly) NSString *fullURLString;

/**
 parameters
 */
@property (nonatomic, strong) NSDictionary<NSString*, id> *parameters;

/**
 parameter type :
     JDNetworkParameterHTTPEncoding
     JDNetworkParameterJSONEncoding
     JDNetworkParameterPropertyListEncoding
 */
@property (nonatomic, assign) JDNetworkParameterEncoding parameterEncoding;

/**
 file upload
 */
@property (nonatomic, assign) BOOL usedMultipartFormData;

/**
 request method: GET、POST、DELETE、PUT
 */
@property (nonatomic, copy) NSString *HTTPMethod;

/**
 timeout
 */
@property (nonatomic, assign) CGFloat timeoutInterval;

/**
 add parameter for key

 @param parameter parameter
 @param key key
 */
- (void)addParameter:(id)parameter forKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
