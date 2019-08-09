//
//  JDNetwork+Cache.m
//  JDNetwork
//
//  Created by JD on 2015/8/7.
//  Copyright © 2015 JD. All rights reserved.
//

#import "JDNetwork+Cache.h"
#import "JDCacheInterceptor.h"
#import "JDResponse+Cache.h"
#import "JDRequest+Cache.h"

@implementation JDNetwork (Cache)

- (JDNetwork *(^)(JDNetworkCachePolicy))cachePolicy {
    return ^(JDNetworkCachePolicy cachePolicy){
        self->entity.request.cachePolicy = cachePolicy;
        self.addInterceptor([[JDCacheInterceptor alloc] init]);
        return self;
    };
}

- (JDNetwork *(^)(JDNetworkCompletionBlock cache))cache {
    return ^(JDNetworkCompletionBlock cache){
        self->entity.response.cache = cache;
        return self;
    };
}


@end
