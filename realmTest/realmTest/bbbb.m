//
//  bbbb.m
//  realmTest
//
//  Created by admin on 2017/8/18.
//  Copyright © 2017年 CAMRY. All rights reserved.
//

#import "bbbb.h"
#import <Realm/Realm.h>
#import "BaseSetting.h"

@implementation bbbb
// 创建数据库
- (void)creatDataBaseWithName:(id)class1
{
    NSString *filePath = [BaseSetting getDatabasePath];
    NSLog(@"数据库目录 = %@",filePath);
    
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    config.fileURL = [NSURL URLWithString:filePath];
    
    [(NSMutableArray *)config.objectClasses addObject:class1];
    config.readOnly = NO;
    int currentVersion = 1.0;
    config.schemaVersion = currentVersion;
    
    config.migrationBlock = ^(RLMMigration *migration , uint64_t oldSchemaVersion) {       // 这里是设置数据迁移的block
        if (oldSchemaVersion < currentVersion) {
            
        }
    };
    
    [RLMRealmConfiguration setDefaultConfiguration:config];
    
}

@end
