#import "FileOperator.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCrypto.h>
#import <sys/xattr.h>


@implementation FileOperator

#pragma mark Random
+ (NSInteger)randomInt {
    int value = arc4random() % 999999;
    if (value < 100000) {
        value += 100000;
    }
    return value;
}

+ (NSString *)guid {
    CFUUIDRef uuidObj = CFUUIDCreate(nil);
    NSString *uuidString = (NSString *)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
    CFRelease(uuidObj);
    return uuidString;
}

+ (NSString *)md5WithString:(NSString *)string {
    const void *cStr = [[string lowercaseString] UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],	result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
}

+ (NSData *)md5WithData:(NSData *)data {
    const void *cStr = [data bytes];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)data.length, result);
    return [[NSData alloc] initWithBytes:result length:CC_MD5_DIGEST_LENGTH];
}

+ (NSString *)sha512WithValue:(NSString *)value withSalt:(NSString *)salt {
    const char *cSalt = [salt cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cValue = [value cStringUsingEncoding:NSUTF8StringEncoding];
    unsigned char digest[CC_SHA512_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA512, cSalt, strlen(cSalt), cValue, strlen(cValue), digest);
    
    NSString *hash;
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA512_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    hash = output;
    
    return hash;
}

+ (NSString *)getHexStringFromData:(NSData *)data {
    const unsigned char *dataBytes = (const unsigned char *)[data bytes];
    
    if (!dataBytes) {
        return [NSString string];
    }
    
    NSUInteger dataLength = [data length];
    NSMutableString *hexString = [NSMutableString stringWithCapacity:(dataLength * 2)];
    
    for (int i = 0; i < dataLength; i++) {
        [hexString appendString:[NSString stringWithFormat:@"%02lX", (unsigned long)dataBytes[i]]];
    }
    
    return [NSString stringWithString:hexString];
}

#pragma mark Save Load File
+ (NSString *)getValueAtResource:(NSString *)resource key:(NSString*)key {
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:resource];
    NSString *object = [dictionary objectForKey:key];
    if (!object || [object isEqualToString:@""]) {
        object = @"";
    }
    return object;
}

+ (NSString *)getFilePathAtDirectory:(NSString *)directory fileName:(NSString *)fileName {
    return [directory stringByAppendingPathComponent:fileName];;
}

+ (BOOL)createDirectory:(NSString*)directory {
    return [[NSFileManager defaultManager] createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:nil];
}

+ (NSData *)loadFileAtPath:(NSString*)path {
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return [NSData dataWithContentsOfFile:path];
    }
    return nil;
}

+ (BOOL)appendFileAtPath:(NSString *)path data:(NSData *)data isExcludedFromBackup:(BOOL)isExcludedFromBackup {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:path];
        [fileHandle seekToEndOfFile];
        [fileHandle writeData:data];
        [fileHandle closeFile];
        return YES;
    } else {
        return [FileOperator saveFileAtPath:path data:data isExcludedFromBackup:isExcludedFromBackup];
    }
}

+ (BOOL)saveFileAtPath:(NSString*)path data:(NSData *)data isExcludedFromBackup:(BOOL)isExcludedFromBackup {
    BOOL result = [data writeToFile:path atomically:YES];
    if (result && isExcludedFromBackup) {
        [FileOperator addSkipBackupAttributeAtPath:path];
    }
    return result;
}

+ (BOOL)copyFileFromPath:(NSString*)fromPath toPath:(NSString *)toPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager copyItemAtPath:fromPath toPath:toPath error:nil];
    return result;
}

+ (BOOL)moveFileFromPath:(NSString*)fromPath toPath:(NSString *)toPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager moveItemAtPath:fromPath toPath:toPath error:nil];
    return result;
}

+ (BOOL)removeFileAtPath:(NSString*)path {
    return [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}

+ (void)removeFileAtDirectory:(NSString*)directory {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    NSArray *fileList = [fileManager contentsOfDirectoryAtPath:directory error:&error];
    if (!error) {
        for (NSString *file in fileList) {
            NSString *path = [directory stringByAppendingPathComponent:file];
            [fileManager removeItemAtPath:path error:nil];
        }
    }
}

#pragma mark directory
+ (NSString *)getDocDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

+ (NSString *)getTempDirectory {
    return NSTemporaryDirectory();
}

#pragma mark Add SkipBackupAttribute
+ (BOOL)addSkipBackupAttributeAtPath:(NSString *)path {
    return [[NSURL fileURLWithPath:path] setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:nil];
}

+ (void)addSkipBackupAttributeAtDirectory:(NSString *)directory isExcludedFromBackup:(BOOL)isExcludedFromBackup {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    NSArray *fileList = [fileManager contentsOfDirectoryAtPath:directory error:&error];
    if (!error) {
        BOOL isDir = NO;
        for (NSString *file in fileList) {
            NSString *path = [directory stringByAppendingPathComponent:file];
            [fileManager fileExistsAtPath:path isDirectory:(&isDir)];
            if (isDir) {
                if (isExcludedFromBackup) {
                    [FileOperator addSkipBackupAttributeAtDirectory:path isExcludedFromBackup:isExcludedFromBackup];
                }
                isDir = NO;
            } else {
                if (isExcludedFromBackup) {
                    [FileOperator addSkipBackupAttributeAtPath:path];
                }
            }
        }
    }
}

#pragma mark Image Function
+ (UIImage *)getThumbImage:(UIImage *)image thumbWidth:(CGFloat)thumbWidth thumbHeight:(CGFloat)thumbHeight {
    @try {
        CGFloat imgWidth = image.size.width;
        CGFloat imgHeight = image.size.height;
        if (imgWidth / imgHeight > thumbWidth / thumbHeight) {
            CGFloat realWidth = imgWidth * thumbHeight / imgHeight;
            UIGraphicsBeginImageContext(CGSizeMake(thumbWidth, thumbHeight));
            [image drawInRect:CGRectMake(-(realWidth - thumbWidth) / 2.0, 0.0f, realWidth, thumbHeight)];
            image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        } else {
            CGFloat realHeight = imgHeight * thumbWidth / imgWidth;
            UIGraphicsBeginImageContext(CGSizeMake(thumbWidth, thumbHeight));
            [image drawInRect:CGRectMake(0.0f, -(realHeight - thumbHeight) / 2.0, thumbWidth, realHeight)];
            image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
        return image;
    }
    @catch (NSException* e) {
        return image;
    }
}

+ (UIImage *)getScaleTopImage:(UIImage *)image viewWidth:(CGFloat)width viewHeight:(CGFloat)height {
    @try {
        CGFloat imgWidth = image.size.width;
        CGFloat imgHeight = image.size.height;
        if (imgWidth / imgHeight > width / height) {
            CGFloat realWidth = imgWidth * height / imgHeight;
            UIGraphicsBeginImageContext(CGSizeMake(width, height));
            [image drawInRect:CGRectMake(-(realWidth - width) / 2.0, 0.0f, realWidth, height)];
            image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        } else {
            CGFloat realHeight = imgHeight * width / imgWidth;
            UIGraphicsBeginImageContext(CGSizeMake(width, height));
            [image drawInRect:CGRectMake(0.0f, 0.0f, width, realHeight)];
            image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
        return image;
    }
    @catch (NSException* e) {
        return image;
    }
}

+ (UIImage *)getScaleCenterImage:(UIImage *)image viewWidth:(CGFloat)width viewHeight:(CGFloat)height {
    @try {
        CGFloat imgWidth = image.size.width;
        CGFloat imgHeight = image.size.height;
        if (imgWidth / imgHeight > width / height) {
            CGFloat realWidth = imgWidth * height / imgHeight;
            UIGraphicsBeginImageContext(CGSizeMake(width, height));
            [image drawInRect:CGRectMake(-(realWidth - width) / 2.0, 0.0f, realWidth, height)];
            image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        } else {
            CGFloat realHeight = imgHeight * width / imgWidth;
            UIGraphicsBeginImageContext(CGSizeMake(width, height));
            [image drawInRect:CGRectMake(0.0f, -(realHeight - height) / 2.0, width, realHeight)];
            image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
        return image;
    }
    @catch (NSException* e) {
        return image;
    }
}

#pragma mark view shot
+ (UIImage *)getShotAtView:(UIView *)view bgColor:(UIColor *)bgColor {
    UIImage *image = nil;
    
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize size = view.frame.size;
    UIScrollView *scrollView = nil;
    if ([view isKindOfClass:[UIScrollView class]]) {
        scrollView = (UIScrollView *)view;
        size = scrollView.contentSize;
    }
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        CGFloat red;
        CGFloat green;
        CGFloat blue;
        CGFloat alpha;
        [bgColor getRed:&red green:&green blue:&blue alpha:&alpha];
        CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
        CGContextSetRGBFillColor(ctx, red, green, blue, alpha);
        CGContextFillRect(ctx, rect);
        CGContextStrokePath(ctx);
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            CGPoint savedContentOffset = scrollView.contentOffset;
            CGRect savedFrame = scrollView.frame;
            
            scrollView.contentOffset = CGPointZero;
            scrollView.frame = CGRectMake(0.0f, 0.0f, size.width, size.height);
            
            [scrollView.layer renderInContext:ctx];
            image = UIGraphicsGetImageFromCurrentImageContext();
            
            scrollView.contentOffset = savedContentOffset;
            scrollView.frame = savedFrame;
        } else {
            [view.layer renderInContext:ctx];
            image = UIGraphicsGetImageFromCurrentImageContext();
        }
    }
    UIGraphicsEndImageContext();
    
    return image;
}

@end
