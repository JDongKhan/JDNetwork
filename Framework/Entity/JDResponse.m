//
//  JDResponse.m
//  JDNetwork
//
//  Created by JD on 2015/8/7.
//  Copyright © 2015 JD. All rights reserved.
//

#import "JDResponse.h"

NSString *const JDResponseNetworkSource = @"Network";
NSString *const JDResponseCacheSource = @"Cache";

@implementation JDResponse

- (id)copyWithZone:(NSZone *)zone {
    JDResponse *response = [[[self class] allocWithZone:zone] init];
    response.responseEncoding = self.responseEncoding;
    response.responseEncoding = self.responseEncoding;
    response.successBlock = [self.successBlock copy];
    response.errorBlock = [self.errorBlock copy];
    return response;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    if ([self.responseObject respondsToSelector:@selector(encodeWithCoder:)]) {
        [coder encodeObject:self.responseObject forKey:@"responseObject"];
    }
    [coder encodeInteger:self.responseEncoding forKey:@"responseEncoding"];
}

- (id)initWithCoder:(NSCoder *)coder {
    self.responseObject = [coder decodeObjectForKey:@"responseObject"];
    self.responseEncoding = [coder decodeIntegerForKey:@"responseEncoding"];
    return self;
}

- (void)dealloc {
    //NSLog(@"%@ dealloc",NSStringFromClass(self.class));
}

@end


@implementation JDResponse (Report)


- (void)reportResponse:(JDResponse *)response {
    if (response.error != nil) {
        [self reportError:response.error];
        return;
    }
    [self reportSuccess:response.responseObject];
}

- (void)reportSuccess:(id)responseObject {
    if (self.successBlock != nil) {
        self.successBlock(responseObject);
    }
}

- (void)reportError:(NSError *)error {
    if (self.errorBlock != nil) {
        self.errorBlock(error);
    }
}


@end
