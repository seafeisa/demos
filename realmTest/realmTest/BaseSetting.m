//
//  BaseSetting.m
//  newPro
//
//  Created by admin on 2017/8/1.
//  Copyright © 2017年 CAMRY. All rights reserved.
//

#import "BaseSetting.h"
#import "FileOperator.h"
@implementation BaseSetting
#pragma mark Local Directory
static NSString *_dbName = @"xxxxx.sqlite";

+ (NSString *)getDatabasePath {
    return [FileOperator getFilePathAtDirectory:[BaseSetting getUserDirectory] fileName:_dbName];
}

+ (NSString *)getUserDirectory {
    return [FileOperator getDocDirectory];
}

+ (void)setValue:(id)value forKey:(NSString *)key{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setValue:value forKey:key];
    [def synchronize];
}

+ (id)getValueFromKey:(NSString *)key{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    return [def objectForKey:key];
}
@end
