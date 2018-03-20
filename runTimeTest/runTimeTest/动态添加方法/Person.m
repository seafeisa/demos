//
//  Person.m
//  runTimeTest
//
//  Created by admin on 2017/12/12.
//  Copyright © 2017年 Zhongshan Camry Electronic Company Limited. All rights reserved.
//

#import "Person.h"
#import <objc/message.h>

@implementation Person

void aaa(id self,SEL _cmd,NSNumber *meter){
    NSLog(@"我跑了%@米",meter);
}

void bbb(id self,SEL _cmd,NSString *meter){
    NSLog(@"我吃了%@个蛋糕",meter);
}

// 任何方法默认都有两个参数 ,self,_cmd
// 什么时候调用:只要一个对象调用了未实现的方法时,就会调用这个方法进行处理
// 作用:动态添加方法,处理未实现

+ (BOOL)resolveInstanceMethod:(SEL)sel{
    if (sel == NSSelectorFromString(@"run:")) {
        class_addMethod(self, sel, (IMP)aaa, "v@:@");
        return YES;
    }
    
    if (sel == NSSelectorFromString(@"eat:")) {
        class_addMethod(self, sel, (IMP)bbb, "v@:@");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

@end
