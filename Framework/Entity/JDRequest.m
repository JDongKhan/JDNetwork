//
//  JDRequest.m
//  JDNetwork
//
//  Created by JD on 2015/8/7.
//  Copyright © 2015 JD. All rights reserved.
//

#import "JDRequest.h"

@implementation JDRequest

- (instancetype)init {
    if(self = [super init]){
        _parameters = [NSMutableDictionary dictionary];
    }
    return self;
}

- (NSString *)fullURLString {
    NSString *fullURLString = [NSURL URLWithString:self.pathOrFullURLString relativeToURL:[NSURL URLWithString:self.baseURLString]].absoluteString;
    return fullURLString;
}

- (void)addParameter:(id)parameter forKey:(NSString *)key {
    NSMutableDictionary *parameters = (NSMutableDictionary *)self.parameters;
    [parameters setObject:parameter forKey:key];
}

- (id)copyWithZone:(NSZone *)zone {
    JDRequest *request = [[[self class] allocWithZone:zone] init];
    request.baseURLString = self.baseURLString;
    request.pathOrFullURLString = self.pathOrFullURLString;
    request.parameters = [self.parameters mutableCopy];
    request.parameterEncoding = self.parameterEncoding;
    request.usedMultipartFormData = self.usedMultipartFormData;
    request.HTTPMethod = self.HTTPMethod;
    request.timeoutInterval = self.timeoutInterval;
    return request;
}

- (void)dealloc {
//    NSLog(@"%@ dealloc",NSStringFromClass(self.class));
}


@end
