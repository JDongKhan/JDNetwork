//
//  BaseRequest.h
//  JDNetwork
//
//  Created by 王金东 on 2017/7/21.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import "JDRequest.h"

@interface BaseRequest : JDRequest

@property (nonatomic,copy) NSString *baseUrl;

@property (nonatomic,copy) NSString *apiPath;

@end
