//
//  NSObject+Model2.m
//  runTimeTest
//
//  Created by admin on 2017/12/11.
//  Copyright © 2017年 Zhongshan Camry Electronic Company Limited. All rights reserved.
//

#import "NSObject+Model2.h"
#import <objc/message.h>
@implementation NSObject (Model2)

+ (instancetype)modelWithDict2:(NSDictionary *)dict{
    id objc = [[self alloc] init];
    
    unsigned int count = 0;
    // 获取类中所有的成员变量
    Ivar *ivarlist = class_copyIvarList(self, &count);
    // 遍历成员变量
    for (int i = 0; i < count; i ++) {
        // 根据角标获取成员变量
        Ivar ivar = ivarlist[i];
        // 获取成员变量名称
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        //获取成员变量类型
        NSString *ivarType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        
        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"@" withString:@""];
        
        NSString *key = [ivarName substringFromIndex:1];
        
        // 根据成员属性名称 去 字典中取值
        id value = dict[key];
        
        // 二级转换:如果字典中还有字典,也需要把对应字典转化成模型
        // 判断下 value 是否为字典,并且是自定义对象才需要转换
        if ([value isKindOfClass:[NSDictionary class]] && ![ivarType hasPrefix:@"NS"]) {
            // 字典转化成模型 userDict --> User 模型,转化为哪个模型 根据字符串名生成类对象
            
            Class modelClass = NSClassFromString(ivarType);
            if (modelClass) { // 有对应的模型才需要转化
                // 把字典转化为模型
                value = [modelClass modelWithDict2:value];
            }
        }
        
        if (value) {
            [objc setValue:value forKey:key];
        }
    }
    
    
    return objc;
}

@end
