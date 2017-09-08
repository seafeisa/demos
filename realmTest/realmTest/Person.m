//
//  Person.m
//  realmTest
//
//  Created by admin on 2017/8/17.
//  Copyright © 2017年 CAMRY. All rights reserved.
//

#import "Person.h"

@implementation Person
// 给属性设置默认值
+ (NSDictionary *)defaultPropertyValues{
    return @{@"gae":@11};
}
// 主键设置
+ (NSString *)primaryKey{
    return @"name";
}
//一般来说,realm允许属性为nil,但是如果实现了这个方法的话,就只有name为nil会抛出异常,也就是说现在其他属性可以为空了
+ (NSArray<NSString *> *)requiredProperties{
    return @[@"name"];
}

//设置索引
+ (NSArray<NSString *> *)indexedProperties{
    return @[@"name"];
}

/**
 *如果想存储图片的话,可以把UIImage转为NSData存储,当然Realm限制了单个图片大小为16M,所以最好的测试是手动把图片存储到磁盘,然后Realm只尺寸图片的url,url可以是远程url或者本地的路径.
 */
@end
