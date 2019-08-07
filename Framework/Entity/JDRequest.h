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

typedef NS_ENUM(NSInteger, JDNetworkResponseEncoding) {
    JDNetworkResponseHTTPEncoding,
    JDNetworkResponseJSONEncoding,
    JDNetworkResponseXMLParserEncoding,
    JDNetworkResponsePropertyListEncoding,
    JDNetworkResponseImageEncoding,
};


@interface JDRequest : NSObject

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
 文件上传
 */
@property (nonatomic, assign) BOOL usedMultipartFormData;

/**
 请求方式 GET、POST、DELETE、PUT
 */
@property (nonatomic, copy) NSString *HTTPMethod;

/**
 超时
 */
@property (nonatomic, assign) CGFloat timeoutInterval;

/**
 响应的类型
 */
@property (nonatomic, assign) JDNetworkResponseEncoding responseEncoding;


@end

NS_ASSUME_NONNULL_END
