//
//  JDResponse.h
//  JDNetwork
//
//  Created by JD on 2015/8/7.
//  Copyright © 2015 JD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JDResponse : NSObject<NSCoding>

@property (nonatomic, strong) NSURLResponse *response;

@property (nonatomic, strong) id _Nullable responseObject;

@property (nonatomic, strong) NSError *_Nullable error;


@end

NS_ASSUME_NONNULL_END
