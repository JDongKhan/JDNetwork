//
//  LoginInterceptor.m
//  JDNetwork
//
//  Created by JD on 2015/8/7.
//  Copyright © 2015 JD. All rights reserved.
//

#import "LoginInterceptor.h"
#import "LoginManager.h"
#import "JDNetworkChain.h"

@implementation LoginInterceptor

- (NSInteger)priority {
    return 999;
}

- (void)request:(JDNetworkRequestChain *)chain {
    //如果没有登录则拦截掉
    if (![LoginManager isLogin]) {
        //去登陆
        [LoginManager login:^(BOOL success) {
            //继续请求
            [chain restart];
        }];
        [chain stop];
        return;
    }
    JDNetworkEntity *entity = chain.entity;
    JDRequest *request = entity.request;
    [request addParameter:@"1" forKey:@"userID"];
}

@end
