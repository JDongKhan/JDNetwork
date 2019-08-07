//
//  JDRequest.m
//  JDNetwork
//
//  Created by JD on 2018/8/7.
//  Copyright © 2018 JD. All rights reserved.
//

#import "JDRequest.h"

@implementation JDRequest

- (instancetype)init {
    if(self = [super init]){
        _parameters = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"%@ dealloc",NSStringFromClass(self.class));
}

@end
