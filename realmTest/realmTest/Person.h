//
//  Person.h
//  realmTest
//
//  Created by admin on 2017/8/17.
//  Copyright © 2017年 CAMRY. All rights reserved.
//

#import <Realm/Realm.h>
#import "Company.h"
#import "Dog.h"
RLM_ARRAY_TYPE(Dog)
@interface Person : RLMObject
@property  NSString *name;
//@property (nonatomic) NSInteger age;
@property NSNumber<RLMInt> *age;
@property  Company *company;
@property  RLMArray<Dog *><Dog> *dogs;
@end
