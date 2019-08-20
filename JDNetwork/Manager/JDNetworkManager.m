//
//  JDNetworkManager.m
//  JDNetwork
//
//  Created by JD on 2015/6/10.
//  Copyright © 2015 JD. All rights reserved.
//

#import "JDNetworkManager.h"
#import "HttpLoggingInterceptor.h"

@implementation JDNetworkManager

+ (JDNetwork *)baiduService {
    return JDNetwork
    .baseURLString(@"http://api.map.baidu.com/")
    .addInterceptor([[HttpLoggingInterceptor alloc] init])
    .responseEncoding(JDNetworkResponseJSONEncoding);
}

@end
