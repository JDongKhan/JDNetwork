//
//  JDNetworkInterceptor.h
//  JDNetwork
//
//  Created by JD on 2015/8/7.
//  Copyright © 2015 JD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JDNetworkChain.h"

NS_ASSUME_NONNULL_BEGIN

@protocol JDNetworkInterceptor <NSObject>

- (BOOL)intercept:(JDNetworkChain *)chain;

@optional

- (NSInteger)priority;

- (void)disposeOfResponse:(JDResponse *)response;

@end

NS_ASSUME_NONNULL_END
