//
//  JDResponse.m
//  JDNetwork
//
//  Created by JD on 2015/8/7.
//  Copyright © 2015 JD. All rights reserved.
//

#import "JDResponse.h"

@implementation JDResponse

- (void)encodeWithCoder:(NSCoder *)coder {
//    [coder encodeObject:self.response forKey:@"response"];
    [coder encodeObject:self.responseObject forKey:@"responseObject"];
}

- (id)initWithCoder:(NSCoder *)coder {
//    self.response = [coder decodeObjectForKey:@"response"];
    self.responseObject = [coder decodeObjectForKey:@"responseObject"];
    return self;
}

- (void)dealloc {
    NSLog(@"%@ dealloc",NSStringFromClass(self.class));
}

@end
