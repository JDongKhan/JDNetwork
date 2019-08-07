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
    JDNetworkResponseHTTPEncoding,
    JDNetworkResponseJSONEncoding,
    JDNetworkResponseXMLParserEncoding,
    JDNetworkResponsePropertyListEncoding,
    JDNetworkResponseImageEncoding,
};

@interface JDResponse : NSObject<NSCoding, NSCopying>

@property (nonatomic, strong) NSURLResponse *response;

@property (nonatomic, strong) id _Nullable responseObject;

@property (nonatomic, strong) NSError *_Nullable error;

/**
 响应的类型
 */
@property (nonatomic, assign) JDNetworkResponseEncoding responseEncoding;

@end

NS_ASSUME_NONNULL_END
