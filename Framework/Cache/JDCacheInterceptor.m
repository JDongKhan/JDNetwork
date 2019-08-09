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
#import "JDNetworkEntity+Private.h"
#import "JDNetworkChain+Private.h"


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
            //判断是否继续请求
            if (![request shouldContinueRequestAfterLoaded]) {
                //请求链停止
                [chain stop];
                //响应链开始
                JDNetworkChain<JDResponse *> *responseChain = [JDNetworkChain responseChain];
                responseChain.object = response;
                [responseChain addInterceptors:[entity sortInterceptorsArrayByPriority]];
                [responseChain addInterceptors:[entity sortFinallyInterceptorsArrayByPriority]];
                [responseChain complete:^(BOOL complete, JDResponse *response) {
                    if (complete) {
                        [response reportCacheData:responseObject];
                    }
                }];
                [responseChain run];
            } else {
                [response reportCacheData:responseObject];
            }
        }
    }
}

- (void)response:(JDNetworkChain *)chain {
    JDResponse *response = chain.object;
    if (response.error == nil && _shouldCache && ![response.source isEqualToString:JDResponseCacheSource]) {
        [JDNetworkCache saveResponseToCacheFile:response.responseObject andURL:_keyForCaching];
    }
}

@end
