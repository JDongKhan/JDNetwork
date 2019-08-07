//
//  JDNetworkCache.m
//  JDNetworkCache
//
//  Created by JD on 16/6/25.
//  Copyright © 2016年 JD. All rights reserved.

#import "JDNetworkCache.h"
#import <CommonCrypto/CommonDigest.h>

#ifdef DEBUG
#define JDNetworkDebugLog(...) NSLog(__VA_ARGS__)
#else
#define JDNetworkDebugLog(...)
#endif

@implementation JDNetworkCache

+ (BOOL)saveResponseToCacheFile:(id)response andURL:(NSString *)keyForCaching {
    return [JDNetworkCache saveResponseToCacheFile:response andURL:keyForCaching andVersion:nil];
}

+ (BOOL)saveResponseToCacheFile:(id)response andURL:(NSString *)keyForCaching andVersion:(NSString *)version {
    if(response!=nil) {
        BOOL state =[NSKeyedArchiver archiveRootObject:response toFile:[self cacheFilePathWithURL:keyForCaching version:version]];
        if(state) {
            JDNetworkDebugLog(@"缓存写入/更新成功");
        }
        return state;
    }
    return NO;
}

+ (id )cacheWithURL:(NSString *)keyForCaching {
    return [JDNetworkCache cacheWithURL:keyForCaching andVersion:nil];
}

+ (id )cacheWithURL:(NSString *)keyForCaching andVersion:(NSString *)version {
    NSString *path = [self cacheFilePathWithURL:keyForCaching version:version];
    id cacheObject;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path isDirectory:nil] == YES) {
        cacheObject = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    }
    return cacheObject;
}

+ (NSString *)cacheFilePathWithURL:(NSString *)keyForCaching version:(NSString *)version {
    
    NSString *pathOfLibrary = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = pathOfLibrary;
    if(version){
        path = [path stringByAppendingPathComponent:version];
    }
    path = [path stringByAppendingPathComponent:@"JDNetworkCache"];
    
    [self checkDirectory:path];//check路径
    JDNetworkDebugLog(@"path = %@",path);
    
    //文件名
    NSString *cacheFileNameString = [NSString stringWithFormat:@"URL:%@ AppVersion:%@",keyForCaching,[self appVersionString]];
    NSString *cacheFileName = [self md5StringFromString:cacheFileNameString];
    path = [path stringByAppendingPathComponent:cacheFileName];
    return path;
}

+ (void)checkDirectory:(NSString *)path {
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
        JDNetworkDebugLog(@"create cache directory failed, error = %@", error);
    } else {
        
        [self addDoNotBackupAttribute:path];
    }
}

+ (void)addDoNotBackupAttribute:(NSString *)path {
    NSURL *url = [NSURL fileURLWithPath:path];
    NSError *error = nil;
    [url setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:&error];
    if (error) {
        JDNetworkDebugLog(@"error to set do not backup attribute, error = %@", error);
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
