//
//  HttpLoggingInterceptor.m
//  JDNetwork
//
//  Created by JD on 2019/8/7.
//  Copyright © 2019 JD. All rights reserved.
//

#import "HttpLoggingInterceptor.h"
#import "JDNetworkChain.h"

@implementation HttpLoggingInterceptor

- (NSInteger)priority {
    return -2;
}

- (void)request:(JDNetworkRequestChain *)chain {
    NSLog(@"request : %@",chain.entity.request.fullURLString);
    NSLog(@"parameters : %@",chain.entity.request.parameters);
}

- (void)response:(JDNetworkResponseChain *)chain  {
    NSLog(@"response : %@",chain.response.responseObject);
}

@end
