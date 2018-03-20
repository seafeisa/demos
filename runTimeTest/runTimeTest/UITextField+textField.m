//
//  UITextField+textField.m
//  runTimeTest
//
//  Created by admin on 2017/12/11.
//  Copyright © 2017年 Zhongshan Camry Electronic Company Limited. All rights reserved.
//

#import "UITextField+textField.h"
#import <objc/message.h>

@implementation UITextField (textField)

+ (void)load{
    
    Method setPlaceholder = class_getClassMethod(self, @selector(setPlaceholder:));
    Method setLn_placeholder = class_getClassMethod(self, @selector(set_LnPlaceholder:));
    method_exchangeImplementations(setPlaceholder, setLn_placeholder);

}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor{
    
    objc_setAssociatedObject(self, @"placeHolderColor", placeHolderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    UILabel *placeholderLab = [self valueForKey:@"placeholderLabel"];
    placeholderLab.textColor = placeHolderColor;
}

- (UIColor *)placeHolderColor{
    // 获取成员属性
    return objc_getAssociatedObject(self, @"placeHolderColor");
}



- (void)set_LnPlaceholder:(NSString *)placeholder{
    
    [self set_LnPlaceholder:placeholder];
    
    self.placeHolderColor = self.placeHolderColor;
}

@end
