//
//  JDCacheInterceptor.m
//  JDNetwork
//
//  Created by JD on 2015/8/7.
//  Copyright © 2015 JD. All rights reserved.
//

#import "JDCacheInterceptor.h"
#import "JDNetworkCache.h"
#import "JDRequest+Cache.h"
#import "JDNetwork+Cache.h"
#import "JDNetworkEntity+Cache.h"
#import "JDNetworkChain.h"


@implementation JDCacheInterceptor {
    NSString *_keyForCaching;
    BOOL _shouldCache;
}

- (NSInteger)priority {
    return -1;
}

- (void)request:(JDNetworkRequestChain *)chain {
    JDNetworkEntity *entity = chain.entity;
    JDRequest *request = entity.request;
     _shouldCache = request.shouldCache;
    //加载缓存
    if (_shouldCache) {
        _keyForCaching = request.keyForCaching;
        JDResponse *response = [JDNetworkCache cacheWithURL:_keyForCaching];
        if (response) {
            response.source = JDResponseCacheSource;
            entity.response = response;
            [entity reportCacheData:response.responseObject];
            
            //判断是否继续请求
            if (![request shouldContinueRequestAfterLoaded]) {
                [chain stop];
            }
        }
    }
}

- (void)response:(JDNetworkResponseChain *)chain {
    JDResponse *response = chain.response;
    if (response.error == nil && _shouldCache) {
        [JDNetworkCache saveResponseToCacheFile:response andURL:_keyForCaching];
    }
}

@end
