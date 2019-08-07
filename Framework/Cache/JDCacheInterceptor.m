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


@implementation JDCacheInterceptor {
    NSString *_keyForCaching;
    BOOL _shouldCache;
}

- (NSInteger)priority {
    return -1;
}

- (BOOL)intercept:(JDNetworkChain *)chain {
    JDNetworkEntity *entity = chain.entity;
    JDRequest *request = entity.request;
     _shouldCache = request.shouldCache;
    //加载缓存
    if (_shouldCache) {
        _keyForCaching = request.keyForCaching;
        id response = [JDNetworkCache cacheWithURL:_keyForCaching];
        if (response) {
            [entity reportCacheData:response];
        }
        if (![request shouldContinueRequestAfterLoaded]) {
            return YES;
        }
    }
    return NO;
}

- (void)disposeOfResponse:(JDResponse *)response {
    if (response.error == nil && _shouldCache) {
        [JDNetworkCache saveResponseToCacheFile:response andURL:_keyForCaching];
    }
}

@end
