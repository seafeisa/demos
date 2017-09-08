//
//  Dog.m
//  realmTest
//
//  Created by admin on 2017/8/17.
//  Copyright © 2017年 CAMRY. All rights reserved.
//

#import "Dog.h"
#import "Person.h"

@implementation Dog

//反向关系(Inverse Relationship)
/**
 *  person设置dogs 属性Dog 并不会自动设置 dog的owners属性为person
 *  Dog *dog1 = [[Dog alloc] init];
 *   person.dogs = dog1; 不会自动设置dog1.owners = person; 双向手动太麻烦  于是就有了下边的方法
 */

+ (NSDictionary<NSString *,RLMPropertyDescriptor *> *)linkingObjectsProperties{
    return @{
             @"owners":[RLMPropertyDescriptor descriptorWithClass:Person.class propertyName:@"dogs"]
             };
}


//设置忽略属性,即不存到realm数据库中
+ (NSArray<NSString *> *)ignoredProperties {
    return @[@"weight"];
}


@end
