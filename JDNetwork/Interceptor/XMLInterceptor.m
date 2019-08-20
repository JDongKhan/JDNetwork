//
//  XMLInterceptor.m
//  JDNetwork
//
//  Created by JD on 2017/8/7.
//  Copyright © 2017 JD. All rights reserved.
//

#import "XMLInterceptor.h"
#import "JDResponse.h"

@implementation XMLInterceptor

- (void)request:(JDNetworkChain *)chain {
}

- (NSInteger)priority {
    return 1;
}


//这里是拦截用的，不过也可以做解析器使用去更新chain里面的数据

- (void)response:(JDNetworkChain *)chain {
    JDResponse *response = (JDResponse *)chain.object;
    if ([response.responseObject isKindOfClass:[NSXMLParser class]]) {
//        NSXMLParser *parser = response.responseObject;
        //开始解析
        response.responseObject = @{
                                    @"title" : @"xml parser"
                                    };
        //解析完成
    }
}


@end
