//
//  JDCacheInterceptor.m
//  JDNetwork
//
//  Created by JD on 2018/8/7.
//  Copyright © 2018 JD. All rights reserved.
//

#import "JDCacheInterceptor.h"
#import "JDNetworkCache.h"
#import "JDRequest+Cache.h"
#import "JDNetwork+Cache.h"
#import "JDNetworkEntity+Cache.h"


@implementation JDCacheInterceptor {
    NSString *_keyForCaching;
}

- (NSInteger)priority {
    return -1;
}

- (BOOL)intercept:(JDNetworkChain *)chain {
    JDNetworkEntity *entity = chain.entity;
    JDRequest *request = entity.request;
    //加载缓存
    if ([self loadCacheData:request]) {
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

//处理缓存
- (BOOL)loadCacheData:(JDRequest *)request {
    if (request.shouldCache) {
        return YES;
    }
    return NO;
}

- (JDResponse *)response:(JDResponse *)response {
    if (response.error == nil) {
       // [JDNetworkCache saveResponseToCacheFile:response andURL:_keyForCaching];
    }
    return response;
}

@end
