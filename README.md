# JDNetwork

基于AFNetworking封装的链式网络请求

PS:出于兴趣写点快速开发的组件，但是没有线上使用过，就这么个人。

使用效果是
```c
- (IBAction)requestAction4:(UIButton *)sender {
    //因为url配置过了 我就不配置了
    [JDNetwork userService]
    .get(@"user/1.htm")
    .parametersForKey(@"username",@"wjd")
    .execute();
}

- (IBAction)requestAction2:(id)sender {
    JDNetwork
    .get(@"https://www.baidu.com")
    .responseEncoding(JDNetworkResponseXMLParserEncoding)
    .successResponse(^(id  _Nonnull result) {
        NSLog(@"%@",result);
    }).errorResponse(^(NSError * _Nonnull error) {
        NSLog(@"%@",error.description);
    }).execute();
}

- (IBAction)requestAction1:(id)sender {
    JDNetwork
    .post(@"")
    .parametersForKey(@"username",@"wjd")
    .execute();
}

```
