//
//  dictModelController.m
//  runTimeTest
//
//  Created by admin on 2017/12/11.
//  Copyright © 2017年 Zhongshan Camry Electronic Company Limited. All rights reserved.
//

#import "dictModelController.h"
#import "FirstModel.h"
#import "NSObject+Model1.h"
#import "SecondModel.h"
#import "NSObject+Model2.h"
#import "User.h"
#import "thirdModel.h"
#import "NSObject+Model3.h"
#import "Array.h"

@interface dictModelController ()

@end

@implementation dictModelController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *dict = [self getDictFromFile:@"status1.plist"];
   FirstModel *firstM = [FirstModel modelWithDict:dict];
    NSLog(@"firstM ----- attitudes_count:%ld\ncreated_at:%@\nsource:%@\ntext:%@\nage:%ld",(long)firstM.attitudes_count,firstM.created_at,firstM.source,firstM.text,(long)firstM.age);
    
    NSDictionary *dict2 = [self getDictFromFile:@"status2.plist"];
    SecondModel *secondM = [SecondModel modelWithDict2:dict2];
    User *user = secondM.user;
    NSLog(@"firstM ----- attitudes_count:%ld\ncreated_at:%@\nsource:%@\ntext:%@\nage:%ld\nmbrank:%ld\nname:%@\nvip:%d",(long)secondM.attitudes_count,secondM.created_at,secondM.source,secondM.text,(long)secondM.age,user.mbrank,user.name,user.vip);
    
    NSDictionary *dict3 = [self getDictFromFile:@"status3.plist"];
    thirdModel *thirdM = [thirdModel modelWithDict3:dict3];
    for (Array *arrData in thirdM.pic_urls) {
        NSLog(@"Array === Janes:%@\nbook:%@",arrData.Janes,arrData.book);
    }
    NSLog(@"firstM ----- attitudes_count:%ld\ncreated_at:%@\nsource:%@\ntext:%@\nage:%ld\npic_urls:%@",(long)thirdM.attitudes_count,thirdM.created_at,thirdM.source,thirdM.text,(long)thirdM.age,thirdM.pic_urls);
}

- (NSDictionary *)getDictFromFile:(NSString *)str{
    NSString *path = [[NSBundle mainBundle] pathForResource:str ofType:nil];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    return dict;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
