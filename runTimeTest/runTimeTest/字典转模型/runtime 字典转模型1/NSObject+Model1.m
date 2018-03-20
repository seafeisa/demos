//
//  NSObject+Model1.m
//  runTimeTest
//
//  Created by admin on 2017/12/11.
//  Copyright © 2017年 Zhongshan Camry Electronic Company Limited. All rights reserved.
//

#import "NSObject+Model1.h"
#import <objc/message.h>

@implementation NSObject (Model1)
+ (instancetype)modelWithDict:(NSDictionary *)dict{
    id obj = [[self alloc] init];
    
    // 利用 runtime 给对象中的属性赋值
    
    unsigned int conut = 0;
    
    // 获取类中的所有成员变量
    Ivar *ivarList = class_copyIvarList(self, &conut);
    // 遍历所有成员变量
    for (int i = 0; i < conut; i ++) {
        Ivar ivar = ivarList[i];
        // 获取成员变量名字
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        NSLog(@"ivarName === %@",ivarName);
        // 处理成员变量名 --> 字典中的 key(去掉成员变量中 "_")
        NSString *key = [ivarName substringFromIndex:1];
        // 根据成员变量名称 到字典中取 value
        id value = dict[key];
        // 如果模型属性数量大于字典键值对数,或者模型属性与字典 key 不对照,模型属性值会被赋空
        // 而报错(could not set nil as the value for the key age.)
        if (value) {
            [obj setValue:value forKey:key];
        }
    }
    
    return obj;
}
@end
