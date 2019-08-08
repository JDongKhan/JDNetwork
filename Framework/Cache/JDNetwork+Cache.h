//
//  JDNetwork+Cache.h
//  JDNetwork
//
//  Created by JD on 2015/8/7.
//  Copyright © 2015 JD. All rights reserved.
//

#import "JDNetwork.h"
#import "JDRequest+Cache.h"

NS_ASSUME_NONNULL_BEGIN

@interface JDNetwork (Cache)

/**
 缓存
 */
@property (nonatomic, readonly, copy) JDNetwork *(^cachePolicy)(JDNetworkCachePolicy cachePolicy);

/**
 缓存响应
 */
@property (nonatomic, readonly, copy) JDNetwork *(^cache)(JDNetworkCompletionBlock cache);


@end

NS_ASSUME_NONNULL_END
