//
//  NSObject+Model3.h
//  runTimeTest
//
//  Created by admin on 2017/12/11.
//  Copyright © 2017年 Zhongshan Camry Electronic Company Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol modelDelgate <NSObject>

@optional

+ (NSDictionary *)arrayContainModelClass;

@end

@interface NSObject (Model3)
+ (instancetype)modelWithDict3:(NSDictionary *)dict;

@end
