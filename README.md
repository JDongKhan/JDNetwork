# JDNetwork

基于AFNetworking封装的链式网络请求

PS:出于兴趣写点快速开发的组件。

## 优势

###  一、使用方便

    -- 链式调用
    
    -- 方法简洁

###  二、支持拦截器
    
    可以通过拦截器做很多工作，比如
    
    1、登陆拦截
    
    2、日志、统计
    
    3、缓存
    
    4、自定义解析
    
    5、等等
    
###  三、易扩展


###  四、等等

###  Demo

```objc

//最简单的写法
- (IBAction)requestAction1:(id)sender {
    JDNetwork
    .post(@"https://baidu.com")
    .parametersForKey(@"username",@"jd")
    .start();
}

//登录拦截器
- (IBAction)requestAction2:(id)sender {
    //因为url配置过了 我就不配置了
    JDNetwork
    .get(@"https://baidu.com")
    .addInterceptor([[LoginInterceptor alloc] init])
    .responseEncoding(JDNetworkResponseXMLParserEncoding)
    .successResponse(^(id  _Nonnull result) {
    })
    .errorResponse(^(NSError * _Nonnull error) {
    })
    .start();
}

//缓存拦截器
- (IBAction)requestAction3:(id)sender {
    JDNetwork
    .get(@"https://baidu.com")
    .cachePolicy(JDNetworkCachePolicyLoadCacheOnlyAtFirstTimeAndAlwaysRequest)
    .responseEncoding(JDNetworkResponseXMLParserEncoding)
    .successResponse(^(id  _Nonnull result) {
    })
    .errorResponse(^(NSError * _Nonnull error) {
    })
    .start();
}

//登录+缓存拦截器
- (IBAction)requestAction4:(UIButton *)sender {
    JDNetwork
    .get(@"https://baidu.com")
    .addInterceptor([[LoginInterceptor alloc] init])
    .addInterceptor([[HttpLoggingInterceptor alloc] init])
    .addInterceptor([[XMLInterceptor alloc] init])
    .cachePolicy(JDNetworkCachePolicyLoadCacheOnlyAtFirstTimeAndAlwaysRequest)
    .responseEncoding(JDNetworkResponseXMLParserEncoding)
    .successResponse(^(id  _Nonnull result) {
    })
    .errorResponse(^(NSError * _Nonnull error) {
    })
    .start();
}


- (IBAction)requestAction5:(id)sender {
    NSString *url = @"/api/openapi/BaikeLemmaCardApi";
    JDNetworkManager.baiduService
    .get(url)
    .parametersForKey(@"scope", @"103")
    .parametersForKey(@"format", @"json")
    .parametersForKey(@"appid", @"379020")
    .parametersForKey(@"bk_key", @"haha")
    .parametersForKey(@"bk_length", @"600")
    .cachePolicy(JDNetworkCachePolicyLoadCacheOnlyAtFirstTimeAndAlwaysRequest)
    .successResponse(^(id  _Nonnull result) {
    })
    .errorResponse(^(NSError * _Nonnull error) {
    })
    .start();
}

```
