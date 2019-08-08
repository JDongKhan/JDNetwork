//
//  JDRequest+Cache.h
//  JDNetwork
//
//  Created by JD on 2015/8/7.
//  Copyright © 2015 JD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JDNetwork+Cache.h"

NS_ASSUME_NONNULL_BEGIN

@interface JDRequest (Cache)

/**
 缓存策略
 */
@property (nonatomic, assign) JDNetworkCachePolicy cachePolicy;

/**
 是否缓存
 */
@property (nonatomic, readonly, assign) BOOL shouldCache;

/**
 keyForCaching
 */
@property (nonatomic, readonly, copy) NSString *keyForCaching;

/**
 shouldContinueRequestAfterLoaded
 */
@property (nonatomic, readonly) BOOL shouldContinueRequestAfterLoaded;

@end

NS_ASSUME_NONNULL_END
