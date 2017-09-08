#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


enum LangType {
    LangTypeNone = 0,
    LangTypeCN = 1,//中文🇨🇳
    LangTypeTW = 2,//繁体🇭🇰🇲🇴
    LangTypeEN = 3,//英文🇬🇧🇺🇸
    LangTypeAR = 4,//阿拉伯
    LangTypeDE = 5,//德文🇩🇪
    LangTypeES = 6,//西班牙文🇪🇸
    LangTypeIT = 7,//意大利文🇮🇹
    LangTypeJA = 8,//日文🇯🇵
    LangTypeKO = 9,//韩文🇰🇷
    LangTypePT = 10,//葡萄牙文🇵🇹
    LangTypeRU = 11,//俄文🇷🇺
    LangTypeTR = 12,//土耳其🇹🇷
    LangTypeFR = 13,//法文🇫🇷
    LangTypePL = 14,//波兰文🇵🇱
    LangTypeUK = 15,//乌克兰🇺🇦
    LangTypeRO = 16,//罗马尼亚🇷🇴
    LangTypeHU = 17,//匈牙利🇭🇺
    LangTypeNE = 18,//荷兰🇳🇱
};


@interface FileOperator : NSObject



#pragma mark Random & Hash
+ (NSInteger)randomInt;
+ (NSString *)guid;
+ (NSString *)md5WithString:(NSString *)string;
+ (NSData *)md5WithData:(NSData *)data;
+ (NSString *)sha512WithValue:(NSString *)value withSalt:(NSString *)salt;
+ (NSString *)getHexStringFromData:(NSData *)data;

#pragma mark Save Load File
+ (NSString *)getValueAtResource:(NSString *)resource key:(NSString*)key;
+ (NSString *)getFilePathAtDirectory:(NSString *)directory fileName:(NSString *)fileName;
+ (BOOL)createDirectory:(NSString*)directory;
+ (NSData *)loadFileAtPath:(NSString*)path;
+ (BOOL)appendFileAtPath:(NSString *)path data:(NSData *)data isExcludedFromBackup:(BOOL)isExcludedFromBackup;
+ (BOOL)saveFileAtPath:(NSString*)path data:(NSData *)data isExcludedFromBackup:(BOOL)isExcludedFromBackup;
+ (BOOL)copyFileFromPath:(NSString*)fromPath toPath:(NSString *)toPath;
+ (BOOL)moveFileFromPath:(NSString*)fromPath toPath:(NSString *)toPath;
+ (BOOL)removeFileAtPath:(NSString*)path;
+ (void)removeFileAtDirectory:(NSString*)directory;

#pragma mark directory
+ (NSString *)getDocDirectory;
+ (NSString *)getTempDirectory;

#pragma mark Add SkipBackupAttribute
+ (BOOL)addSkipBackupAttributeAtPath:(NSString *)path;
+ (void)addSkipBackupAttributeAtDirectory:(NSString *)directory isExcludedFromBackup:(BOOL)isExcludedFromBackup;

#pragma mark Image Function
+ (UIImage *)getThumbImage:(UIImage *)image thumbWidth:(CGFloat)thumbWidth thumbHeight:(CGFloat)thumbHeight;
+ (UIImage *)getScaleTopImage:(UIImage *)image viewWidth:(CGFloat)width viewHeight:(CGFloat)height;
+ (UIImage *)getScaleCenterImage:(UIImage *)image viewWidth:(CGFloat)width viewHeight:(CGFloat)height;

#pragma mark view shot
//+ (UIImage *)getShotAtView:(UIView *)view bgColor:(UIColor *)bgColor;

@end
