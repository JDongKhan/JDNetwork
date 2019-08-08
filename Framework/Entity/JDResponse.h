//
//  JDResponse.h
//  JDNetwork
//
//  Created by JD on 2015/8/7.
//  Copyright © 2015 JD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, JDNetworkResponseEncoding) {
    JDNetworkResponseHTTPEncoding = 0,
    JDNetworkResponseJSONEncoding,
    JDNetworkResponseXMLParserEncoding,
    JDNetworkResponsePropertyListEncoding,
    JDNetworkResponseImageEncoding,
};

FOUNDATION_EXPORT NSString * const JDResponseNetworkSource;
FOUNDATION_EXPORT NSString * const JDResponseCacheSource;

typedef void (^JDNetworkCompletionBlock)(id _Nullable result);
typedef void (^JDNetworkErrorBlock)(NSError *_Nullable error);


@interface JDResponse : NSObject<NSCoding, NSCopying>

/**
 URLResponse 响应对象，里面包括很多有用的数据
 */
@property (nonatomic, strong) NSURLResponse *response;

/**
 请求的数据
 */
@property (nonatomic, strong) id _Nullable responseObject;

/**
 请求的错误
 */
@property (nonatomic, strong) NSError *_Nullable error;

/**
 数据来源
 */
@property (nonatomic, copy) NSString *_Nullable source;

/**
 响应的类型
 */
@property (nonatomic, assign) JDNetworkResponseEncoding responseEncoding;

/**
 请求成功block
 */
@property (nonatomic, copy) JDNetworkCompletionBlock successBlock;

/**
 请求失败block
 */
@property (nonatomic, copy) JDNetworkErrorBlock errorBlock;


@end

NS_ASSUME_NONNULL_END
