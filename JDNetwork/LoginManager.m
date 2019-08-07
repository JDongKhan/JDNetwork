//
//  LoginManager.m
//  JDNetwork
//
//  Created by JD on 2015/8/7.
//  Copyright © 2015 JD. All rights reserved.
//

#import "LoginManager.h"

static BOOL isLogin = NO;

@implementation LoginManager

@dynamic isLogin;

+ (BOOL)isLogin {
    return isLogin;
}

+ (void)login:(void(^)(BOOL))loginBlock {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSLog(@"我去登陆了！！！！");
        sleep(5);
        NSLog(@"登陆成功！！！！");
        isLogin = YES;
        loginBlock(YES);
    });
}


@end
