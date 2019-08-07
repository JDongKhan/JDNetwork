//
//  JDNetworkEntity.h
//  JDNetwork
//
//  Created by JD on 2015/6/7.
//  Copyright © 2015 JD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIView.h>
#import "JDRequest.h"
#import "JDResponse.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^JDNetworkCompletionBlock)(id result);
typedef void (^JDNetworkErrorBlock)(NSError* error);

@interface JDNetworkEntity : NSObject

@property (nonatomic, strong) JDRequest *request;

@property (nonatomic, strong) JDResponse *response;

/**
 拦截器
 */
@property (nonatomic, strong) NSMutableArray *interceptors;

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

@end

NS_ASSUME_NONNULL_END
