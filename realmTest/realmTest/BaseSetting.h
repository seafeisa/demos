//
//  BaseSetting.h
//  newPro
//
//  Created by admin on 2017/8/1.
//  Copyright © 2017年 CAMRY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseSetting : NSObject


#pragma mark Local Directory
+ (NSString *)getDatabasePath;
+ (NSString *)getUserDirectory;

#pragma mark - NSUserDefaults
+ (void)setValue:(id)value forKey:(NSString *)key;
+ (id)getValueFromKey:(NSString *)key;
@end
