//
//  LoginInterceptor.m
//  JDNetwork
//
//  Created by JD on 2018/8/7.
//  Copyright © 2018 JD. All rights reserved.
//

#import "LoginInterceptor.h"
#import "LoginManager.h"

@implementation LoginInterceptor

- (BOOL)intercept:(JDNetworkChain *)chain {
    //如果没有登录则拦截掉
    if (![LoginManager isLogin]) {
        //去登陆
        [LoginManager login:^(BOOL success) {
            //继续请求
            [chain send];
        }];
        return YES;
    }
    JDNetworkEntity *entity = chain.entity;
    JDRequest *request = entity.request;
    [request.parameters setObject:@"1" forKey:@"userID"];
    return NO;
}

@end
