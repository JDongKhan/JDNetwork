//
//  JDNetWork.h
//  配置文件需要配置isHttpsRequest  0=http  1=https
//  defaultHttpMethod:"GET"?"POST"
//  Created by 王金东 on 14/12/10.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JDRequest.h"
#import <AFNetworking/AFNetworking.h>

#define response_fail_code -1

@class JDNetWork;

@protocol JDNetWorkDelegate <NSObject>

/**
 *  @author wangjindong
 *
 *  网络请求开始
 *
 */
- (void)urlRequestWillStart:(JDRequest *)request;

/**
*  @author wangjindong
*
*  开始处理数据
*
*/
- (NSDictionary *)urlRequestWillHandleParams:(JDRequest *)request;

/**
 *  @author wangjindong, 16-01-15 18:01:56
 *
 *  @brief 请求任务开始
 *
 *  @param task 任务
 *  @param request request
 *
 */
- (void)urlRequestDidStart:(JDRequest *)request task:(id)task ;

/**
 *  @author wangjindong
 *
 *  处理成功block
 *
 *  @param request request
 */
- (void)urlRequest:(JDRequest *)request sourceDic:(NSDictionary*)sourceDic;


/**
 *  @author wangjindong
 *
 *  处理失败
 *
 *  @param request      request
 *
 */
- (void)urlRequest:(JDRequest *)request error:(NSError*)error;


@end

@interface JDNetWork : NSObject


+ (id)urlRequestWithProgressView:(JDRequest *)request delegate:(id<JDNetWorkDelegate>)delegate;


/**
 *  @author wangjindong, 16-03-18 09:03:49
 *
 *  @brief 文件上传
 *
 *  @param url     url
 *  @param params  参数
 *  @param method  传输方式
 *  @param secure  是否加密
 *  @param ssl     是否椒https
 *  @param block   上传block
 *  @param success 成功block
 *  @param failure 失败block
 *
 *  @since 1.0
 */
+  (void)urlRequestWithUploadFile:(NSString *)url
                   params:(NSDictionary *)params
               httpMethod:(NSString*)method
                   secure:(BOOL)secure
                      ssl:(BOOL)ssl
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure;


/**
 *  @author wangjindong, 16-07-08 10:07:24
 *
 *  @brief 下载图片
 *
 *  @param url     url
 *  @param params  参数
 *  @param method  传输方式
 *  @param secure  是否加密
 *  @param ssl     是否椒https
 *  @param success 成功block
 *  @param failure 失败block
 *
 */
+  (void)urlRequestWithDownloadFile:(NSString *)url
                   params:(NSDictionary *)params
               httpMethod:(NSString*)method
                   secure:(BOOL)secure
                      ssl:(BOOL)ssl
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure;

@end



@interface JDRequest(params)
- (NSDictionary *)_requestParams;
@end

