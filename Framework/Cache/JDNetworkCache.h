//
//  JDNetworkCache.h
//  JDNetworkCacheExample
//
//  Created by wangjindong on 16/6/25.
//  Copyright © 2016年 wangjindong. All rights reserved.

#import <Foundation/Foundation.h>

@interface JDNetworkCache : NSObject

/**
 *  写入/更新缓存
 *
 *  @param response 要写入的数据(JSON)
 *  @param keyForCaching    请求URLString
 *
 *  @return 是否写入成功
 */
+ (BOOL)saveResponseToCacheFile:(id)response andURL:(NSString *)keyForCaching;
+ (BOOL)saveResponseToCacheFile:(id)response andURL:(NSString *)keyForCaching andVersion:(NSString *)version;
/**
 *  获取缓存的对象
 *
 *  @param keyForCaching 请求URL
 *
 *  @return 缓存对象
 */
+ (id)cacheWithURL:(NSString *)keyForCaching;
+ (id)cacheWithURL:(NSString *)keyForCaching andVersion:(NSString *)version;

@end
