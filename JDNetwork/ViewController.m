//
//  ViewController.m
//  JDNetwork
//
//  Created by JD on 2015/7/20.
//  Copyright © 2015年 JD. All rights reserved.
//

#import "ViewController.h"
#import <JDNetwork/JDNetwork.h>
#import <JDNetwork/JDNetwork+Cache.h>
#import "JDNetworkManager.h"
#import "LoginInterceptor.h"
#import "HttpLoggingInterceptor.h"
#import "XMLInterceptor.h"

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

//最简单的写法
- (IBAction)requestAction1:(id)sender {
    JDNetwork
    .POST(@"https://baidu.com")
    .parameters(@{
                  @"username" : @"jd"
                  })
    .start();
}

//登录拦截器
- (IBAction)requestAction2:(id)sender {
    JDNetwork
    .GET(@"https://baidu.com")
    .addInterceptor([[LoginInterceptor alloc] init])
    .responseEncoding(JDNetworkResponseXMLParserEncoding)
    .success(^(id result) {
        NSLog(@"success : %@",result);
    })
    .error(^(NSError *error) {
        NSLog(@"error : %@",error);
    })
    .start();
}

//缓存拦截器
- (IBAction)requestAction3:(id)sender {
    NSString *url = @"/api/openapi/BaikeLemmaCardApi";
    JDNetworkManager.baiduService
    .GET(url)
    .parametersForKey(@"scope", @"103")
    .parametersForKey(@"format", @"json")
    .parametersForKey(@"appid", @"379020")
    .parametersForKey(@"bk_key", @"haha")
    .parametersForKey(@"bk_length", @"600")
    .cachePolicy(JDNetworkCachePolicyLoadCacheOnlyAtFirstTimeAndAlwaysRequest)
    .success(^(id result) {
        NSLog(@"success : %@",result);
    })
    .cache(^(id  result) {
        NSLog(@"cache : %@",result);
    })
    .error(^(NSError *error) {
        NSLog(@"error : %@",error);
    })
    .start();
}

//登录+缓存拦截器
- (IBAction)requestAction4:(UIButton *)sender {
    JDNetwork
    .GET(@"https://baidu.com")
    .addInterceptor([[LoginInterceptor alloc] init])
    .addInterceptor([[HttpLoggingInterceptor alloc] init])
    .addInterceptor([[XMLInterceptor alloc] init])
    .cachePolicy(JDNetworkCachePolicyLoadCacheOnlyAtFirstTimeAndAlwaysRequest)
    .responseEncoding(JDNetworkResponseXMLParserEncoding)
    .success(^(id  result) {
        NSLog(@"success : %@",result);
    })
    .cache(^(id  result) {
        NSLog(@"cache : %@",result);
    })
    .error(^(NSError *error) {
        NSLog(@"error : %@",error);
    })
    .start();
}


- (IBAction)requestAction5:(id)sender {
    NSString *url = @"/api/openapi/BaikeLemmaCardApi";
    JDNetworkManager.baiduService
    .GET(url)
    .parametersForKey(@"scope", @"103")
    .parametersForKey(@"format", @"json")
    .parametersForKey(@"appid", @"379020")
    .parametersForKey(@"bk_key", @"haha")
    .parametersForKey(@"bk_length", @"600")
    .cachePolicy(JDNetworkCachePolicyLoadCacheDoesNotRequestWithinDuration)
    .success(^(id  result) {
        NSLog(@"success : %@",result);
    })
    .cache(^(id  result) {
        NSLog(@"cache : %@",result);
    })
    .error(^(NSError *error) {
        NSLog(@"error : %@",error);
    })
    .start();
}

@end
