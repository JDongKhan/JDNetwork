//
//  JDNetwork+myproject.m
//  JDNetwork
//
//  Created by JD on 2018/6/10.
//  Copyright © 2018 JD. All rights reserved.
//

#import "JDNetwork+myproject.h"

@implementation JDNetwork (myproject)

+ (JDNetwork *)userService {
    return JDNetwork.baseURLString(@"https://www.baidu.com").responseEncoding(JDNetworkResponseXMLParserEncoding);
}

@end
