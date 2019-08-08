//
//  XMLInterceptor.m
//  JDNetwork
//
//  Created by JD on 2019/8/7.
//  Copyright © 2019 JD. All rights reserved.
//

#import "XMLInterceptor.h"
#import "JDResponse.h"
#import "JDNetworkChain.h"

@implementation XMLInterceptor

- (void)request:(JDNetworkRequestChain *)chain {
}

- (NSInteger)priority {
    return 1;
}

- (void)response:(JDNetworkResponseChain *)chain {
    JDResponse *response = chain.response;
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
