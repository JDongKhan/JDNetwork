//
//  JDResponse+Cache.m
//  AFNetworking
//
//  Created by JD on 2019/8/9.
//

#import "JDResponse+Cache.h"
#import <objc/runtime.h>

@implementation JDResponse (Cache)

- (void)setCache:(JDNetworkCompletionBlock)cache {
    objc_setAssociatedObject(self, @selector(cache),cache, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (JDNetworkCompletionBlock)cache {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)reportCacheData:(id)responseObject {
    if (self.cache != nil) {
        self.cache(responseObject);
    }
}

@end
