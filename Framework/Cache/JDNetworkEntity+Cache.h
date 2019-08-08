//
//  JDNetworkEntity+Cache.h
//  JDNetwork
//
//  Created by JD on 2015/8/7.
//  Copyright © 2015 JD. All rights reserved.
//

#import "JDNetworkEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface JDNetworkEntity (Cache)

/**
 缓存数据
 */
@property (nonatomic, copy) JDNetworkCompletionBlock cache;


- (void)reportCacheData:(id)responseObject;

@end

NS_ASSUME_NONNULL_END
