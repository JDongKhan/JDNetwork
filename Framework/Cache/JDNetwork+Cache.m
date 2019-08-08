//
//  JDNetwork+Cache.m
//  JDNetwork
//
//  Created by JD on 2015/8/7.
//  Copyright © 2015 JD. All rights reserved.
//

#import "JDNetwork+Cache.h"
#import "JDCacheInterceptor.h"
#import "JDNetworkEntity+Cache.h"

@implementation JDNetwork (Cache)

- (JDNetwork *(^)(JDNetworkCachePolicy))cachePolicy {
    return ^(JDNetworkCachePolicy cachePolicy){
        self->entity.request.cachePolicy = cachePolicy;
        self.addInterceptor([[JDCacheInterceptor alloc] init]);
        return self;
    };
}

- (JDNetwork *(^)(JDNetworkCompletionBlock cachedDataResponse))cachedDataResponse {
    return ^(JDNetworkCompletionBlock cachedDataResponse){
        self->entity.cache = cachedDataResponse ;
        return self;
    };
}


@end
