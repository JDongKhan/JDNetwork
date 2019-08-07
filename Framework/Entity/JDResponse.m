//
//  JDResponse.m
//  JDNetwork
//
//  Created by JD on 2015/8/7.
//  Copyright © 2015 JD. All rights reserved.
//

#import "JDResponse.h"

@implementation JDResponse

- (id)copyWithZone:(NSZone *)zone {
    JDResponse *response = [[[self class] allocWithZone:zone] init];
    response.responseEncoding = self.responseEncoding;
    return response;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.responseObject forKey:@"responseObject"];
}

- (id)initWithCoder:(NSCoder *)coder {
    self.responseObject = [coder decodeObjectForKey:@"responseObject"];
    return self;
}

- (void)dealloc {
    NSLog(@"%@ dealloc",NSStringFromClass(self.class));
}

@end
