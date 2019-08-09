# JDNetwork

基于AFNetworking封装的链式网络请求

PS:出于兴趣写点快速开发的组件。

## 优势

### 一、使用方便

    -- 链式调用
    
    -- 方法简洁

### 二、支持拦截器
    
    可以通过拦截器做很多工作，比如
    
    1、登陆拦截
    
    2、日志、统计
    
    3、缓存
    
    4、自定义解析：拦截器也可以做数据处理的工作
    
    5、等等
    
### 三、性能高
    
    拦截器会在单独的队列里面运行，你可以做你想做的任何事，比如文件先压缩再解压这种没脑子的事情都可以。
    

### 四、支持Cache

    缓存策略分:
    
    JDNetworkCachePolicyIgnored:没有缓存
        
    JDNetworkCachePolicyUsesCacheWhenNetworkUnreachable：无网使用缓存
        
    JDNetworkCachePolicyLoadCacheOnlyAtFirstTimeAndAlwaysRequest:先加载缓存后请求
        
    JDNetworkCachePolicyDoesNotRequestWithinDuration:使用缓存不再请求
            
    
### 五、结构清晰

    该项目共分为五小模块（每个模块都很小，所以是小模块）
    
    1、Operation：核心网络请求逻辑都在这里
    
    2、Interceptor：拦截器
    
    3、Cache：基于拦截器实现的缓存模块
    
    4、Entity：自定义的request、response等，方便管理与使用，是网络使用配置的承载体
    
    5、JDNetwork：该类是一个语法糖类，里面包含了很多常用的功能。比如
    
        5.1、timeoutInterval：超时设置
        
        5.2、parameterEncoding：请求格式
        
        5.3、responseEncoding：响应格式
        
        5.4、parameters：参数设置
        
        5.5、get/post/delete/put/head：http请求方法
        
        5.6、successResponse/errorResponse:成功、失败回调
        
        5.7、其他


### 六、易扩展

    通过拦截器可以很容易扩展功能

    项目中的缓存、登录检测、日志、解析等模块就很容易实现



##   Demo

```objc

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
    })
    .error(^(NSError *error) {
    })
    .start();
}

//缓存拦截器
- (IBAction)requestAction3:(id)sender {
    JDNetwork
    .GET(@"https://baidu.com")
    .cachePolicy(JDNetworkCachePolicyLoadCacheOnlyAtFirstTimeAndAlwaysRequest)
    .responseEncoding(JDNetworkResponseXMLParserEncoding)
    .success(^(id result) {
    })
    .error(^(NSError *error) {
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
    .success(^(id result) {
    })
    .error(^(NSError *error) {
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
    .cachePolicy(JDNetworkCachePolicyLoadCacheOnlyAtFirstTimeAndAlwaysRequest)
    .success(^(id result) {
    })
    .error(^(NSError *error) {
    })
    .start();
}

```
