//
//  JDRequest+Cache.m
//  JDNetwork
//
//  Created by JD on 2015/8/7.
//  Copyright © 2015 JD. All rights reserved.
//

#import "JDRequest+Cache.h"
#import <AFNetworking/AFNetworking.h>
#import <objc/runtime.h>


@implementation JDRequest (Cache)

- (void)setCachePolicy:(JDNetworkCachePolicy)cachePolicy {
    objc_setAssociatedObject(self, @selector(cachePolicy), @(cachePolicy), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (JDNetworkCachePolicy)cachePolicy {
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (BOOL)shouldCache {
    return self.cachePolicy != JDNetworkCachePolicyIgnored;
}

- (BOOL)shouldContinueRequestAfterLoaded {
    switch (self.cachePolicy) {
            case JDNetworkCachePolicyUsesCacheWhenNetworkUnreachable:
            case JDNetworkCachePolicyDoesNotRequestWithinDuration:
            return NO;
        default:
            break;
    }
    return YES;
}

- (NSString *)keyForCaching {
    
    NSString *fullURLString = [NSURL URLWithString:self.pathOrFullURLString relativeToURL:[NSURL URLWithString:self.baseURLString]].absoluteString;
    
    NSString *urlString = fullURLString;
    NSURL *url = [NSURL URLWithString:urlString];
    NSAssert(url != nil, @"The url is nil of %@", fullURLString);
    NSString *query = AFQueryStringFromParameters(self.parameters);
    if (query.length > 0) {
        NSString *queryToAppend = [NSString stringWithFormat:url.query ? @"&%@" : @"?%@", query];
        urlString = [urlString stringByAppendingString:queryToAppend];
    }
    return urlString;
}

@end
