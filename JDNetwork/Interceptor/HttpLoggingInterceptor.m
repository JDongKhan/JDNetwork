//
//  HttpLoggingInterceptor.m
//  JDNetwork
//
//  Created by JD on 2017/8/7.
//  Copyright © 2017 JD. All rights reserved.
//

#import "HttpLoggingInterceptor.h"
#import "JDNetworkEntity.h"

@implementation HttpLoggingInterceptor

- (NSInteger)priority {
    return -2;
}

- (void)request:(JDNetworkChain *)chain {
    JDNetworkEntity *entity = (JDNetworkEntity *)chain.object;
    NSLog(@"request : %@",entity.request.fullURLString);
    NSLog(@"parameters : %@",entity.request.parameters);
}

- (void)response:(JDNetworkChain *)chain  {
    JDResponse *response = (JDResponse *)chain.object;
    NSLog(@"response : %@",response.responseObject);
}

@end
