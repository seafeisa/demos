//
//  NSObject+pro.h
//  runTimeTest
//
//  Created by admin on 2017/12/11.
//  Copyright © 2017年 Zhongshan Camry Electronic Company Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (pro)
// @property 只会生成 get,set方法声明,不会生成实现,也不会生成下划线成员属性
@property NSString *name;
@property NSString *height;
@end
