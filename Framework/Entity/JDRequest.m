//
//  JDRequest.m
//  JDNetwork
//
//  Created by JD on 2015/8/7.
//  Copyright © 2015 JD. All rights reserved.
//

#import "JDRequest.h"

@implementation JDRequest

- (instancetype)init {
    if(self = [super init]){
        _parameters = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)addParameter:(id)parameter forKey:(NSString *)key {
    NSMutableDictionary *parameters = (NSMutableDictionary *)self.parameters;
    [parameters setObject:parameter forKey:key];
}

- (void)dealloc {
    NSLog(@"%@ dealloc",NSStringFromClass(self.class));
}

@end
