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
#import "JDResponse+Cache.h"
#import "JDNetworkChain.h"


@implementation JDCacheInterceptor {
    NSString *_keyForCaching;
    BOOL _shouldCache;
}

- (NSInteger)priority {
    return -999;
}

- (void)request:(JDNetworkChain *)chain {
    JDNetworkEntity *entity = chain.object;
    JDRequest *request = entity.request;
    JDResponse *response = entity.response;
     _shouldCache = request.shouldCache;
    //加载缓存
    if (_shouldCache) {
        _keyForCaching = request.keyForCaching;
        id responseObject = [JDNetworkCache cacheWithURL:_keyForCaching];
        if (responseObject) {
            response.source = JDResponseCacheSource;
            response.responseObject = responseObject;
            [response reportCacheData:responseObject];
            
            //判断是否继续请求
            if (![request shouldContinueRequestAfterLoaded]) {
                [chain stop];
            }
        }
    }
}

- (void)response:(JDNetworkChain *)chain {
    JDResponse *response = chain.object;
    if (response.error == nil && _shouldCache) {
        [JDNetworkCache saveResponseToCacheFile:response.responseObject andURL:_keyForCaching];
    }
}

@end
