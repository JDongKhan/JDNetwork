//
//  HttpLoggingInterceptor.m
//  JDNetwork
//
//  Created by JD on 2019/8/7.
//  Copyright © 2019 JD. All rights reserved.
//

#import "HttpLoggingInterceptor.h"

@implementation HttpLoggingInterceptor

- (NSInteger)priority {
    return -2;
}

- (BOOL)intercept:(JDNetworkChain *)chain {
    NSLog(@"request : %@",chain.entity.request.fullURLString);
    NSLog(@"parameters : %@",chain.entity.request.parameters);
    return NO;
}

- (void)disposeOfResponse:(JDResponse *)response {
    NSLog(@"response : %@",response.responseObject);
}

@end
