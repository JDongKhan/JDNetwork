# JDNetwork

基于AFNetworking封装的链式网络请求，并且支持view进行网络请求

```c
    为啥给view加入网络功能呢？
    有以下优势：
    1、view removeFromSuperview后就会取消网络，然而你什么都不需要做
    2、有时候会需要在view上显示提示，比如在tableview中间显示/隐藏加载动画，比如在button上显示/隐藏菊花转，比如在出现错误，需要在view上显示错误信息等等。
    3、还有... 暂时没有想到
 
    4、view 显示网络 一般都是线程安全的，也不会有人给view开几个线程并发请求网络吧，如果这样，我怀疑产品需求（相信开发是无辜的^_^），所以本工程没有加线程锁！！！！！！
 
```

使用效果是
```c
- (IBAction)requestAction4:(UIButton *)sender {
        sender.jd_request(BaseRequest.class).jd_param(@"username",@"wjd").jd_send();
}

- (IBAction)requestAction2:(id)sender {
    //因为url配置过了 我就不配置了
    FirstRequest.jd_request().jd_send();
}

- (IBAction)requestAction1:(id)sender {
    JDRequest.jd_request().jd_param(@"username",@"wjd").jd_url(@"www.baidu.com").jd_send();
}
- (IBAction)requestAction3:(id)sender {
    FirstRequest *fq = [[FirstRequest alloc] init];
    fq.userName = @"wjd";
    fq.sex = @"1";
    fq.jd_method(@"POST").jd_send();
}

- (IBAction)requestAction:(id)sender {
    FirstRequest *fq = [[FirstRequest alloc] init];
    fq.userName = @"wjd";
    fq.sex = @"1";
    [fq sendRequest];
}

```
