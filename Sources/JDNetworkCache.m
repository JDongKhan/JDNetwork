//
//  JDNetworkCache.m
//  JDNetworkCacheExample
//
//  Created by wangjindong on 16/6/25.
//  Copyright © 2016年 wangjindong. All rights reserved.

#import "JDNetworkCache.h"
#import <CommonCrypto/CommonDigest.h>

#ifdef DEBUG
#define DebugLog(...) NSLog(__VA_ARGS__)
#else
#define DebugLog(...)
#endif

@implementation JDNetworkCache

+(BOOL)saveJsonResponseToCacheFile:(id)jsonResponse andURL:(NSString *)URL {
    return [JDNetworkCache saveJsonResponseToCacheFile:jsonResponse andURL:URL andVersion:nil];
}

+(BOOL)saveJsonResponseToCacheFile:(id)jsonResponse andURL:(NSString *)URL andVersion:(NSString *)version {
    if(jsonResponse!=nil) {
        BOOL state =[NSKeyedArchiver archiveRootObject:jsonResponse toFile:[self cacheFilePathWithURL:URL version:version]];
        if(state)  DebugLog(@"缓存写入/更新成功");
        return state;
    }
    return NO;
}

+(id )cacheJsonWithURL:(NSString *)URL {
    return [JDNetworkCache cacheJsonWithURL:URL andVersion:nil];
}
+(id )cacheJsonWithURL:(NSString *)URL andVersion:(NSString *)version {
    NSString *path = [self cacheFilePathWithURL:URL version:version];
    id cacheJson;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path isDirectory:nil] == YES) {
        cacheJson = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    }
    return cacheJson;
}

+ (NSString *)cacheFilePathWithURL:(NSString *)URL version:(NSString *)version {
    
    NSString *pathOfLibrary = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = pathOfLibrary;
    if(version){
        path = [path stringByAppendingPathComponent:version];
    }
    path = [path stringByAppendingPathComponent:@"JDNetworkCache"];
    
    [self checkDirectory:path];//check路径
    DebugLog(@"path = %@",path);
    
    //文件名
    NSString *cacheFileNameString = [NSString stringWithFormat:@"URL:%@ AppVersion:%@",URL,[self appVersionString]];
    NSString *cacheFileName = [self md5StringFromString:cacheFileNameString];
    path = [path stringByAppendingPathComponent:cacheFileName];
    return path;
}

+(void)checkDirectory:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if (![fileManager fileExistsAtPath:path isDirectory:&isDir]) {
        [self createBaseDirectoryAtPath:path];
    } else {
        if (!isDir) {
            NSError *error = nil;
            [fileManager removeItemAtPath:path error:&error];
            [self createBaseDirectoryAtPath:path];
        }
    }
}

+ (void)createBaseDirectoryAtPath:(NSString *)path {
    __autoreleasing NSError *error = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES
                                               attributes:nil error:&error];
    if (error) {
        DebugLog(@"create cache directory failed, error = %@", error);
    } else {
        
        [self addDoNotBackupAttribute:path];
    }
}
+ (void)addDoNotBackupAttribute:(NSString *)path {
    NSURL *url = [NSURL fileURLWithPath:path];
    NSError *error = nil;
    [url setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:&error];
    if (error) {
        DebugLog(@"error to set do not backup attribute, error = %@", error);
    }
}

+ (NSString *)md5StringFromString:(NSString *)string {
    
    if(string == nil || [string length] == 0)  return nil;
    
    const char *value = [string UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}
+ (NSString *)appVersionString {
    
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

@end
