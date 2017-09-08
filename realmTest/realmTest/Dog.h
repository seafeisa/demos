//
//  Dog.h
//  realmTest
//
//  Created by admin on 2017/8/17.
//  Copyright © 2017年 CAMRY. All rights reserved.
//

#import <Realm/Realm.h>

@class Person;

@interface Dog : RLMObject
@property  NSString *name;
@property  NSString *color;
@property  float weight;
@property (readonly) RLMLinkingObjects *owners;

@end


