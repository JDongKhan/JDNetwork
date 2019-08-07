//
//  JDNetworkEntity+Cache.m
//  JDNetwork
//
//  Created by JD on 2015/8/7.
//  Copyright © 2015 JD. All rights reserved.
//

#import "JDNetworkEntity+Cache.h"

@implementation JDNetworkEntity (Cache)

- (void)reportCacheData:(id)responseObject {
    if (self.cachedDataResponse != nil) {
        self.cachedDataResponse(responseObject);
    }
}

@end
