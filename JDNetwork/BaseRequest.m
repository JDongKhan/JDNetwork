//
//  BaseRequest.m
//  JDNetwork
//
//  Created by 王金东 on 2017/7/21.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import "BaseRequest.h"

@implementation BaseRequest

- (instancetype)init {
    if(self = [super init]) {
        self.baseUrl = @"http://www.baidu.com";
    }
    return self;
}

- (NSString *)url {
    if (self.apiPath) {
        return [NSString stringWithFormat:@"%@/%@",self.baseUrl,self.apiPath];
    }
    return self.baseUrl;
}


#pragma mark----------------------需要你重写的方法------------
#pragma mark 在这里定制你的逻辑
- (void)urlRequestWillStart:(JDRequest *)request {
    if(request.view){
        //在view上显示酷酷的动画
        NSLog(@"在view上显示酷酷的动画...");
    }else{
        //显示等待框
        if(request.isProgress){
            NSLog(@"显示等待框...");
        }else{
            NSLog(@"看不到我，看不到我...(你不开启显示等待框，你啥也看不到)");
        }
    }
}
- (NSDictionary *)urlRequestWillHandleParams:(JDRequest *)request {
    if (request.secure) {
        //开始加密
        return request.params;
    }
    return request.params;
}
/**
 *  @author wangjindong, 16-01-15 18:01:56
 *
 *  @brief 请求任务开始
 *
 *  @param task 任务
 *  @param request request
 *
 */
- (void)urlRequestDidStart:(JDRequest *)request task:(id)task {
    
}

/**
 *  @author wangjindong
 *
 *  处理成功block
 *
 *  @param request request
 */
- (void)urlRequest:(JDRequest *)request sourceDic:(NSDictionary*)sourceDic {
   
    if(request.view){
        //在view上隐藏酷酷的动画
        NSLog(@"在view上隐藏酷酷的动画...");
    }else{
        //显示等待框
        if(request.isProgress){
            NSLog(@"隐藏等待框...");
        }
        NSLog(@"请求成功...");
    }
    
    //开始逻辑处理数据啦
    if(sourceDic && request.success){
        request.success(sourceDic);
    }else if(request.error){
        request.error([NSError errorWithDomain:@"error" code:-1 userInfo:@{@"msg":@"我错了"}]);
    }
}


/**
 *  @author wangjindong
 *
 *  处理失败
 *
 *  @param request      request
 *
 */
- (void)urlRequest:(JDRequest *)request error:(NSError*)error {
   //假装在请求 我知道会阻塞线程，故意的
   //[NSThread sleepForTimeInterval:10];
    if(request.view){
        //在view上隐藏酷酷的动画
         NSLog(@"在view上隐藏酷酷的动画...");
    }else{
        //显示等待框
        if(request.isProgress){
            NSLog(@"隐藏等待框...");
        }
        NSLog(@"请求失败...");
    }
    if(request.error){
        request.error(error);
    }
}



@end
