//
//  JDNetworkInterceptor.h
//  JDNetwork
//
//  Created by JD on 2018/8/7.
//  Copyright © 2018 JD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JDNetworkChain.h"

NS_ASSUME_NONNULL_BEGIN

@protocol JDNetworkInterceptor <NSObject>

- (BOOL)intercept:(JDNetworkChain *)chain;

@optional

- (NSInteger)priority;

- (JDResponse *)response:(JDResponse *)response;


@end

NS_ASSUME_NONNULL_END
