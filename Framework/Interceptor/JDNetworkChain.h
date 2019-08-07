//
//  JDNetworkChain.h
//  JDNetwork
//
//  Created by JD on 2018/8/7.
//  Copyright © 2018 JD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JDNetworkEntity.h"
#import "JDNetworkOperation.h"

NS_ASSUME_NONNULL_BEGIN

@interface JDNetworkChain : NSObject

- (instancetype)initWithOperation:(JDNetworkOperation *)operation;

@property (nonatomic, strong) JDNetworkEntity *entity;

- (void)send;

@end

NS_ASSUME_NONNULL_END
