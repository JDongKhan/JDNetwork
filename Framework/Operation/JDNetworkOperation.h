//
//  JDNetworkOperation.h
//  JDNetwork
//
//  Created by JD on 2015/6/7.
//  Copyright © 2015 JD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JDNetworkEntity.h"


NS_ASSUME_NONNULL_BEGIN

@interface JDNetworkOperation : NSObject

@property (nonatomic, strong) JDNetworkEntity *entity;

@property (nonatomic, readonly, assign) BOOL running;

- (void)start;

- (void)cancel;

@end

NS_ASSUME_NONNULL_END
