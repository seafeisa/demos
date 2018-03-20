//
//  User.h
//  runTimeTest
//
//  Created by admin on 2017/12/11.
//  Copyright © 2017年 Zhongshan Camry Electronic Company Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
//mbrank
//name
//vip
@property (nonatomic, assign) NSInteger mbrank;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) BOOL vip;
@end
