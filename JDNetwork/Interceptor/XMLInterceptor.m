//
//  XMLInterceptor.m
//  JDNetwork
//
//  Created by JD on 2019/8/7.
//  Copyright © 2019 JD. All rights reserved.
//

#import "XMLInterceptor.h"

@implementation XMLInterceptor

- (BOOL)intercept:(JDNetworkChain *)chain {
    return NO;
}

- (NSInteger)priority {
    return 1;
}

- (void)disposeOfResponse:(JDResponse *)response {
    if ([response.responseObject isKindOfClass:[NSXMLParser class]]) {
//        NSXMLParser *parser = response.responseObject;
        //开始解析
        response.responseObject = @{
                                    @"title" : @"模拟解析过的数据"
                                    };
        //解析完成
    }
}


@end
