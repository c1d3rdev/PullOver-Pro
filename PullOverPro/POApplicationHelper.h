//
//  POApplicationHelper.h
//  PullOverPro
//
//  Created by Will Smillie on 4/8/19.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#include <sys/types.h>
#include <sys/sysctl.h>
#import <CommonCrypto/CommonDigest.h>
#import <objc/runtime.h>
#include <stdio.h>

#import "headers.h"


@implementation NSString (MyAdditions)
- (NSString *)md5{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (int)strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
@end

@implementation NSData (MyAdditions)
- (NSString*)md5{
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( self.bytes, (int)self.length, result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
@end


@interface POApplicationHelper : NSObject

+(NSArray *)recentAppsWithCount:(int)count;
+(UIImage *)imageForBundleId:(NSString *)bundleId;
+(NSString *)frontMostBundleId;

+(NSString*)settingsPath;
+(NSMutableDictionary *)settings;

+(NSString*)authorizationPath;
+(NSMutableDictionary *)authorization;

+(UIImage *)imageForBundleId:(NSString *)bundleId;
+(UIImage *)iconImageForIdentifier:(NSString *)identifier;

@end
