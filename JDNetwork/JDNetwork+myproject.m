//
//  JDNetwork+myproject.m
//  JDNetwork
//
//  Created by JD on 2015/6/10.
//  Copyright © 2015 JD. All rights reserved.
//

#import "JDNetwork+myproject.h"

@implementation JDNetwork (myproject)

+ (JDNetwork *)userService {
    return JDNetwork.baseURLString(@"https://www.baidu.com").responseEncoding(JDNetworkResponseXMLParserEncoding);
}

@end
