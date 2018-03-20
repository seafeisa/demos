//
//  UIImage+image.m
//  runTimeTest
//
//  Created by admin on 2017/12/11.
//  Copyright © 2017年 Zhongshan Camry Electronic Company Limited. All rights reserved.
//

#import "UIImage+image.h"
#import <objc/message.h>

@implementation UIImage (image)
// load 方法:把类加载进内存的时候调,只会调用一次,方法应先交换再调用
+ (void)load{
    // 获取 imageName 方法的地址
    Method imageNameMethod = class_getClassMethod(self, @selector(imageNamed:));
    // 后去 ln_imageName 方法的地址
    Method ln_imageNameMethod = class_getClassMethod(self, @selector(ln_imageName:));
    // 交换方法地址,相当于交换实现方法
    method_exchangeImplementations(imageNameMethod, ln_imageNameMethod);
    
    // 调用 imageName 时,实际上调用的是 ln_imageName
    // 调用 ln_imageName 时机调用的是 imageName
}

+ (UIImage *)ln_imageName:(NSString *)name{
    UIImage *image = [UIImage ln_imageName:name];
    if (image) {
        NSLog(@"加载成功");
    }else{
        NSLog(@"加载失败");
    }
    return image;
}

@end
