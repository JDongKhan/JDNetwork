//
//  JDNetworkOperation.h
//  JDNetwork
//
//  Created by JD on 2015/6/7.
//  Copyright © 2015 王金东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JDNetworkConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface JDNetworkOperation : NSObject

@property (nonatomic, strong) JDNetworkConfig *config;

@property (nonatomic, readonly, assign) BOOL running;

- (void)start;

- (void)cancel;

@end

NS_ASSUME_NONNULL_END
