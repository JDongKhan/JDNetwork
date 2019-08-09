//
//  JDResponse+Cache.h
//  AFNetworking
//
//  Created by JD on 2019/8/9.
//

#import "JDResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface JDResponse (Cache)

/**
 缓存数据
 */
@property (nonatomic, copy) JDNetworkCompletionBlock cache;

- (void)reportCacheData:(id)responseObject;


@end

NS_ASSUME_NONNULL_END
