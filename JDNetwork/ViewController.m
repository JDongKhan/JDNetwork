//
//  ViewController.m
//  JDNetwork
//
//  Created by JD on 2017/7/20.
//  Copyright © 2017年 JD. All rights reserved.
//

#import "ViewController.h"
#import "JDNetwork.h"
#import "JDNetwork+myproject.h"
#import "LoginInterceptor.h"
#import "JDNetwork+Cache.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)requestAction1:(id)sender {
    JDNetwork.post(@"")
    .parametersForKey(@"username",@"wjd")
    .execute();
}

//登录拦截器
- (IBAction)requestAction2:(id)sender {
    //因为url配置过了 我就不配置了
    JDNetwork
    .get(@"https://baidu.com")
    .addInterceptor([[LoginInterceptor alloc] init])
    .responseEncoding(JDNetworkResponseXMLParserEncoding)
    .successResponse(^(id  _Nonnull result) {
        NSLog(@"result :%@",result);
    }).errorResponse(^(NSError * _Nonnull error) {
        NSLog(@"error :%@",error.description);
    }).execute();
}

//缓存拦截器
- (IBAction)requestAction3:(id)sender {
    JDNetwork
    .get(@"https://baidu.com")
    .cachePolicy(JDNetworkCachePolicyLoadCacheOnlyAtFirstTimeAndAlwaysRequest)
    .responseEncoding(JDNetworkResponseXMLParserEncoding)
    .successResponse(^(id  _Nonnull result) {
        NSLog(@"result :%@",result);
    }).errorResponse(^(NSError * _Nonnull error) {
        NSLog(@"error :%@",error.description);
    }).execute();
}

//登录+缓存拦截器
- (IBAction)requestAction4:(UIButton *)sender {
    JDNetwork
    .get(@"https://baidu.com")
    .addInterceptor([[LoginInterceptor alloc] init])
    .cachePolicy(JDNetworkCachePolicyLoadCacheOnlyAtFirstTimeAndAlwaysRequest)
    .responseEncoding(JDNetworkResponseXMLParserEncoding)
    .successResponse(^(id  _Nonnull result) {
        NSLog(@"result :%@",result);
    }).errorResponse(^(NSError * _Nonnull error) {
        NSLog(@"error : %@",error.description);
    }).execute();
}


- (IBAction)requestAction5:(id)sender {
    
}

@end
