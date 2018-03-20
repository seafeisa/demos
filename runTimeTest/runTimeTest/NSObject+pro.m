//
//  NSObject+pro.m
//  runTimeTest
//
//  Created by admin on 2017/12/11.
//  Copyright © 2017年 Zhongshan Camry Electronic Company Limited. All rights reserved.
//

#import "NSObject+pro.h"
#import <objc/message.h>
@implementation NSObject (pro)

- (void)setName:(NSString *)name{
    // objc_setAssociatedObject 将某个值跟某个对象关联起来,将某个值存到某个对象中
    // object: 给哪个对象添加属性
    // key: 属性名称
    // value: 属性值
    // policy:保存策略
    objc_setAssociatedObject(self, @"name", name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    NSLog(@"name ---- %@",name);
}

- (void)setHeight:(NSString *)height{
    objc_setAssociatedObject(self, @"height", height, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    NSLog(@"height ---- %@",height);
}

- (NSString *)name{
    return objc_getAssociatedObject(self, @"name");
}

-(NSString *)height{
    return objc_getAssociatedObject(self, @"height");
}
@end
