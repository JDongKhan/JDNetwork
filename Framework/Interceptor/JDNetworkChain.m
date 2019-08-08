//
//  JDNetworkChain.m
//  JDNetwork
//
//  Created by JD on 2015/8/7.
//  Copyright © 201 JD. All rights reserved.
//

#import "JDNetworkChain.h"

@interface JDNetworkChain ()

@property (nonatomic, strong) JDNetworkOperation *operation;

@end

@implementation JDNetworkChain

- (instancetype)initWithOperation:(JDNetworkOperation *)operation {
    if (self = [super init]) {
        self.operation = operation;
    }
    return self;
}

- (void)send {
    [self.operation start];
}

- (void)dealloc {
//    NSLog(@"%@ dealloc",NSStringFromClass(self.class));
}

@end
