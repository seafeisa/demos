//
//  ViewController.m
//  realmTest
//
//  Created by admin on 2017/8/10.
//  Copyright © 2017年 CAMRY. All rights reserved.
//

#import "ViewController.h"
#import <Realm/Realm.h>
#import "Company.h"
#import "Person.h"
#import "Dog.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addInitDataToRealm];
    
    NSLog(@"path == %@",[RLMRealm defaultRealm].configuration.fileURL);
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.frame = CGRectMake(0, 100, 80, 40);
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    deleteBtn.backgroundColor = [UIColor blackColor];
    [deleteBtn addTarget:self action:@selector(deleteAct) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteBtn];
    
    UIButton *cxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cxBtn.frame = CGRectMake(120, 100, 80, 40);
    [cxBtn setTitle:@"查询" forState:UIControlStateNormal];
    cxBtn.backgroundColor = [UIColor blackColor];
    [cxBtn addTarget:self action:@selector(cxBtnAct) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cxBtn];
    
    UIButton *updateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    updateBtn.frame = CGRectMake(250, 100, 80, 40);
    [updateBtn setTitle:@"更新" forState:UIControlStateNormal];
    updateBtn.backgroundColor = [UIColor blackColor];
    [updateBtn addTarget:self action:@selector(updateBtnAct) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:updateBtn];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(0, 200, 80, 40);
    [addBtn setTitle:@"添加" forState:UIControlStateNormal];
    addBtn.backgroundColor = [UIColor blackColor];
    [addBtn addTarget:self action:@selector(addBtnAct) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
}

- (void)addInitDataToRealm {
    Company *company = [[Company alloc] init];
    company.name = @"Senssun";
    
    Person *person = [[Person alloc] init];
//    person.name = @"张三";
    person.age = @22;
    person.company = company;
    
    Dog *dog1 = [[Dog alloc] init];
    dog1.name = @"小黑";
    dog1.color = @"黑色";
    
    Dog *dog2 = [[Dog alloc] init];
    dog2.name = @"小狗子";
    dog2.color = @"黑色";
    
    Dog *dog3 = [[Dog alloc] init];
    dog3.name = @"大白";
    dog3.color = @"白色";
    
    [person.dogs addObject:dog1];
    [person.dogs addObject:dog2];
    [person.dogs addObject:dog3];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addObject:person];
    }];
}




- (void)cxBtnAct {
    RLMResults<Dog *> *dogs = [[Dog objectsWhere:@"color = '黑色' AND name BEGINSWITH '小'"] sortedResultsUsingProperty:@"name" ascending:YES];
    for (Dog *dog in dogs) {
        NSLog(@"dog:%@,owner:%@",dog,dog.owners);
    }
}




- (void)updateBtnAct{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"color = %@ AND name BEGINSWITH %@",@"白色",@"大"];
   
    RLMResults *dogs = [Dog objectsWithPredicate:pred];
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        for (Dog *dog in dogs) {
            dog.color = @"改后的颜色";
        }
    }];
}

- (void)deleteAct {
    RLMResults *result = [Dog objectsWhere:@"color = %@",@"黑色"];
    Dog *dog = result.firstObject;
     RLMRealm *realm = [RLMRealm defaultRealm] ;
    [realm transactionWithBlock:^{
        [realm deleteObject:dog];
    }];
}

- (void)addBtnAct {
    
    Person *per1 = [[Person alloc] init];
    per1.name = @"李四";
    per1.age = @13;
    Dog *dog = [[Dog alloc] init];
    dog.name = @"虎子";
    dog.color = @"绿色";
    
    Company *comp = [[Company alloc] init];
    comp.name = @"camry";
    per1.company = comp;
    [per1.dogs addObject:dog];
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addObject:per1];
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
