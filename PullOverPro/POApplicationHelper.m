//
//  POApplicationHelper.m
//  PullOverPro
//
//  Created by Will Smillie on 4/8/19.
//

#import "POApplicationHelper.h"

@implementation POApplicationHelper

+(NSArray *)recentAppsWithCount:(int)count{
    
    NSMutableArray *objects = [[NSMutableArray alloc] init];

    if (@available(iOS 13, *)){
        NSArray *switcherItems = [[[NSClassFromString(@"SBMainSwitcherViewController") sharedInstance] valueForKey:@"recentAppLayouts"] copy];
        NSLog(@"13 switcher item: %@", switcherItems);
        if (switcherItems.count >= count) {
            for (int i=0; i<count; i++) {
                [objects addObject:[[switcherItems[i] valueForKey:@"allItems"] valueForKey:@"bundleIdentifier"][0]];
            }
        }else{
            for (int i=0; i<switcherItems.count; i++) {
                [objects addObject:[[switcherItems[i] valueForKey:@"allItems"] valueForKey:@"bundleIdentifier"][0]];
            }
        }
    }else{
        NSArray *switcherItems = [[[NSClassFromString(@"SBMainSwitcherViewController") sharedInstance] valueForKey:@"appLayouts"] copy];
        NSLog(@"Pre 13 switcher item: %@", switcherItems);
        if (switcherItems.count >= count) {
            for (int i=0; i<count; i++) {
                [objects addObject:[[switcherItems[i] valueForKey:@"allItems"] valueForKey:@"displayIdentifier"][0]];
            }
        }else{
            for (int i=0; i<switcherItems.count; i++) {
                [objects addObject:[[switcherItems[i] valueForKey:@"allItems"] valueForKey:@"displayIdentifier"][0]];
            }
        }
    }
    
    return objects;
}

+(UIImage *)imageForBundleId:(NSString *)bundleId{
    if (@available(iOS 13, *)) {
        return [self iconImageForIdentifier:bundleId];
    } else {
        SBApplication *app = [[NSClassFromString(@"SBApplicationController") sharedInstance] applicationWithBundleIdentifier:bundleId];
        id appIcon = [[NSClassFromString(@"SBApplicationIcon") alloc] initWithApplication:app];
        UIImage *icon = [appIcon generateIconImage:1];
        return icon;
    }
}


+(NSString *)frontMostBundleId{
    SBApplication *frontMostApp = ((SpringBoard *)[UIApplication sharedApplication])._accessibilityFrontMostApplication;
    return frontMostApp.displayIdentifier;
}


+(NSString*)settingsPath{
    return [NSString stringWithFormat:@"%@/Library/Preferences/%@", NSHomeDirectory(), @"com.c1d3r.PullOverPro.plist"];
}
+(NSMutableDictionary *)settings{
    return [NSMutableDictionary dictionaryWithContentsOfFile:[self settingsPath]];
}

+(NSString*)authorizationPath{
    return [NSString stringWithFormat:@"%@/Library/Preferences/%@", NSHomeDirectory(), @"com.c1d3r.PullOverProAuthorization.plist"];
}
+(NSMutableDictionary *)authorization{
    return [NSMutableDictionary dictionaryWithContentsOfFile:[self authorizationPath]];
}




//13 icon gen
+ (UIImage *)iconImageForIdentifier:(NSString *)identifier {
    
    SBIconController *iconController = [NSClassFromString(@"SBIconController") sharedInstance];
    SBIcon *icon = [iconController.model expectedIconForDisplayIdentifier:identifier];
    
    struct CGSize imageSize;
    imageSize.height = 60;
    imageSize.width = 60;
    
    struct SBIconImageInfo imageInfo;
    imageInfo.size  = imageSize;
    imageInfo.scale = [UIScreen mainScreen].scale;
    imageInfo.continuousCornerRadius = 12;
    
    return [icon generateIconImageWithInfo:imageInfo];
}


@end
