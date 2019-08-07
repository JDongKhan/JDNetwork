//
//  HttpLoggingInterceptor.m
//  JDNetwork
//
//  Created by JD on 2019/8/7.
//  Copyright © 2019 JD. All rights reserved.
//

#import "HttpLoggingInterceptor.h"

@implementation HttpLoggingInterceptor

- (BOOL)intercept:(JDNetworkChain *)chain {
    NSLog(@"request : %@",chain.entity.request.pathOrFullURLString);
    return NO;
}

- (void)disposeOfResponse:(JDResponse *)response {
    NSLog(@"response : %@",response.responseObject);
}

@end
