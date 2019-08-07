//
//  LoginManager.h
//  JDNetwork
//
//  Created by JD on 2015/8/7.
//  Copyright © 2015 JD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginManager : NSObject

@property (nonatomic, assign, class) BOOL isLogin;

+ (void)login:(void(^)(BOOL))loginBlock;

@end

NS_ASSUME_NONNULL_END
