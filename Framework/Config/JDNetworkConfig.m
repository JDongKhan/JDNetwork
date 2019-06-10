//
//  JDNetworkConfig.m
//  JDNetwork
//
//  Created by JD on 2015/6/7.
//  Copyright © 2015 王金东. All rights reserved.
//

#import "JDNetworkConfig.h"

@implementation JDNetworkConfig

- (instancetype)init {
    if(self = [super init]){
        _parameters = [NSMutableDictionary dictionary];
    }
    return self;
}

@end
