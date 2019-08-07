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
@property (nonatomic, strong) NSDictionary<NSString*, id> *parameters;

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

- (void)addParameter:(id)parameter forKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
