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
 *  @param jsonResponse 要写入的数据(JSON)
 *  @param URL    请求URL
 *
 *  @return 是否写入成功
 */
+(BOOL)saveJsonResponseToCacheFile:(id)jsonResponse andURL:(NSString *)URL;
+(BOOL)saveJsonResponseToCacheFile:(id)jsonResponse andURL:(NSString *)URL andVersion:(NSString *)version;
/**
 *  获取缓存的对象
 *
 *  @param URL 请求URL
 *
 *  @return 缓存对象
 */
+(id )cacheJsonWithURL:(NSString *)URL;
+(id )cacheJsonWithURL:(NSString *)URL andVersion:(NSString *)version;
@end
