//
//  JDNetwork+Cache.h
//  JDNetwork
//
//  Created by JD on 2018/8/7.
//  Copyright © 2018 JD. All rights reserved.
//

#import "JDNetwork.h"
#import "JDRequest+Cache.h"

NS_ASSUME_NONNULL_BEGIN

@interface JDNetwork (Cache)

/**
 缓存
 */
@property (nonatomic, readonly, copy) JDNetwork *(^cachePolicy)(JDNetworkCachePolicy cachePolicy);

@end

NS_ASSUME_NONNULL_END
