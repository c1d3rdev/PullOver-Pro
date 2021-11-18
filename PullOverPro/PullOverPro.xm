
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "headers.h"
#import "PullOverWindow.h"
#import "POApplicationHelper.h"

static PullOverWindow *window;
static SBUserNotificationAlert *startupAlert;

#define tweakName @"PullOver Pro"
#define changelog [NSString stringWithFormat:@"/Library/Application Support/PullOverPro/changelog.plist"]



%hook SpringBoard

- (void)applicationDidFinishLaunching:(UIApplication *)arg1{
    %orig();
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:[POApplicationHelper settingsPath]]){
        [@{} writeToFile:[POApplicationHelper settingsPath] atomically:NO];
        
        NSMutableDictionary *settings = [POApplicationHelper settings];
        [settings setObject:@(YES) forKey:@"enabled"];
        [settings setObject:@(YES) forKey:@"hideInLandscape"];
        [settings setObject:[NSArray new] forKey:@"favorites"];
        [settings setObject:[NSNumber numberWithInt:5] forKey:@"recentAppsCount"];
        [settings setObject:[NSNumber numberWithFloat:1.75] forKey:@"quickswitchScale"];
        [settings setObject:@"Recent Apps" forKey:@"style"];
        [settings writeToFile:[POApplicationHelper settingsPath] atomically:NO];
    }
    
    NSMutableDictionary *settings = [POApplicationHelper settings];
    if (![settings objectForKey:@"favorites"]){
        [settings setObject:[NSArray new] forKey:@"favorites"];
        [settings writeToFile:[POApplicationHelper settingsPath] atomically:NO];
    }
    

    
  window = [PullOverWindow sharedWindow];
  window.alpha = 0;
  [window makeKeyAndVisible];

  if ([[POApplicationHelper settings][@"leftHanded"] boolValue]){
      window.transform = CGAffineTransformMakeScale(-1.0, 1.0);
  }
}

-(void)noteInterfaceOrientationChanged:(long long)arg1 duration:(double)arg2 updateMirroredDisplays:(BOOL)arg3 force:(BOOL)arg4 logMessage:(id)arg5{
    
    if ([[POApplicationHelper settings][@"hideInLandscape"] boolValue]){
        if (arg1 == 1){
            [UIView animateWithDuration:0.2 animations:^{
                window.rootViewController.view.alpha = 1;
            }];
        }else{
            if ([window.controller isOpened]){
                [window.controller endHosting];
                [window.controller close];
            }
            [UIView animateWithDuration:0.2 animations:^{
                window.rootViewController.view.alpha = 0;
            }];
        }
    }
    
    %orig;
}
%end

%hook SBLockScreenViewControllerBase
-(void)finishUIUnlockFromSource:(int)arg1{
    %orig;
}

%end

%hook SBFluidSwitcherGestureManager
-(void)grabberTongueBeganPulling:(id)arg1 withDistance:(double)arg2 andVelocity:(double)arg3 {
    if ([window.controller isOpened]){
        [window.controller close];
        [self grabberTongueCanceledPulling:arg1 withDistance:arg2 andVelocity:arg3];
    }else{
        %orig;
    }
}
%end

%hook SBHomeHardwareButton
-(void)singlePressUp:(id)arg1{
    if ([window.controller isOpened]){
        [window.controller close];
    }else{
        %orig;
    }
}
%end

%hook SBLockHardwareButton
-(void)singlePress:(id)arg1 {
    if ([window.controller isOpened]){
        [window.controller close];
    }
    %orig;
}
%end


%hook SBLockStateAggregator
-(void)_updateLockState{
    %orig;
    if ([self valueForKey:@"_lockState"]){
        unsigned long long o = [[self valueForKey:@"_lockState"] longLongValue];
        if (o == 0){
            [UIView animateWithDuration:0.2 animations:^{
                if (window){
                    window.alpha = 1;
                }
            }];
        }else{
            [UIView animateWithDuration:0.2 animations:^{
                if (window){
                    window.alpha = 0;
                }
            }];
        }
    }
}
%end

