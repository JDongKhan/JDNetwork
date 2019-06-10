//
//  JDNetworkConfig.h
//  JDNetwork
//
//  Created by JD on 2015/6/7.
//  Copyright © 2015 王金东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIView.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^JDNetworkCompletionBlock)(id result);
typedef void (^JDNetworkErrorBlock)(NSError* error);


typedef NS_ENUM(NSInteger, JDNetworkParameterEncoding) {
    JDNetworkParameterHTTPEncoding,
    JDNetworkParameterJSONEncoding,
    JDNetworkParameterPropertyListEncoding,
};

typedef NS_ENUM(NSInteger, JDNetworkResponseEncoding) {
    JDNetworkResponseHTTPEncoding,
    JDNetworkResponseJSONEncoding,
    JDNetworkResponseXMLParserEncoding,
    JDNetworkResponsePropertyListEncoding,
    JDNetworkResponseImageEncoding,
};

typedef NS_ENUM(NSInteger, JDNetworkCachePolicy) {
    JDNetworkCachePolicyIgnored,
    JDNetworkCachePolicyUsesCacheWhenNetworkUnreachable,
    JDNetworkCachePolicyLoadCacheOnlyAtFirstTimeAndAlwaysRequest,
    JDNetworkCachePolicyDoesNotRequestWithinDuration,
};

@interface JDNetworkConfig : NSObject

/**
 base url
 */
@property (nonatomic, copy) NSString *baseURLString;

/**
 请求的url
 */
@property (nonatomic, copy) NSString *pathOrFullURLString;

/**
 请求的参数
 */
@property (nonatomic, strong) NSMutableDictionary *parameters;

/**
 参数类型
 */
@property (nonatomic, assign) JDNetworkParameterEncoding parameterEncoding;

/**
 响应的类型
 */
@property (nonatomic, assign) JDNetworkResponseEncoding responseEncoding;

/**
 缓存策略
 */
@property (nonatomic, assign) JDNetworkCachePolicy cachePolicy;

/**
 文件上传
 */
@property (nonatomic, assign) BOOL usedMultipartFormData;

/**
 请求方式 GET、POST、DELETE、PUT
 */
@property (nonatomic, copy) NSString *HTTPMethod;

/**
 请求成功block
 */
@property (nonatomic, copy) JDNetworkCompletionBlock successResponse;

/**
 缓存数据
 */
@property (nonatomic, copy) JDNetworkCompletionBlock cachedDataResponse;

/**
 请求失败block
 */
@property (nonatomic, copy) JDNetworkErrorBlock errorResponse;

/**
 超时
 */
@property (nonatomic, assign) CGFloat timeoutInterval;

@end

NS_ASSUME_NONNULL_END
