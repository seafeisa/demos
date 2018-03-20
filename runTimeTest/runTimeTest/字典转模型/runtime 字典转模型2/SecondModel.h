//
//  SecondModel.h
//  runTimeTest
//
//  Created by admin on 2017/12/11.
//  Copyright © 2017年 Zhongshan Camry Electronic Company Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
@class User;
@interface SecondModel : NSObject
/**
 runtime 字典转模型-->
 模型中嵌套模型「模型属性是另外一个模型对象」，这种情况处理如下：
 */
@property (nonatomic, assign) NSInteger attitudes_count; // 属性
@property (nonatomic, strong) NSString *created_at;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSString *text;

@property (nonatomic, assign) NSInteger age;
@property (nonatomic, strong) User *user;
@end
