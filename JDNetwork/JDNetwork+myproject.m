//
//  JDNetwork+myproject.m
//  JDNetwork
//
//  Created by JD on 2019/6/10.
//  Copyright © 2019 王金东. All rights reserved.
//

#import "JDNetwork+myproject.h"

@implementation JDNetwork (myproject)

+ (JDNetwork *)userService {
    return JDNetwork.baseURLString(@"https://www.baidu.com").responseEncoding(JDNetworkResponseXMLParserEncoding);
}

@end
