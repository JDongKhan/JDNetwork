//
//  JDNetworkEntity+Cache.m
//  JDNetwork
//
//  Created by JD on 2015/8/7.
//  Copyright © 2015 JD. All rights reserved.
//

#import "JDNetworkEntity+Cache.h"
#import <objc/runtime.h>

@implementation JDNetworkEntity (Cache)

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
