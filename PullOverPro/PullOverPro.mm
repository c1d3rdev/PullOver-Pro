#line 1 "/Users/willsmillie/Desktop/Dev/iOS/Jailbreak/PullOverPro/PullOverPro/PullOverPro.xm"

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "headers.h"
#import "PullOverWindow.h"
#import "POApplicationHelper.h"

static PullOverWindow *window;
static SBUserNotificationAlert *startupAlert;

#define tweakName @"PullOver Pro"
#define changelog [NSString stringWithFormat:@"/Library/Application Support/PullOverPro/changelog.plist"]



#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class SBFluidSwitcherGestureManager; @class SBLockScreenViewControllerBase; @class SBHomeHardwareButton; @class SBLockStateAggregator; @class SBLockHardwareButton; @class SBAlertItemsController; @class SBHomeScreenViewController; @class SBUserNotificationAlert; @class SpringBoard; 
static void (*_logos_orig$_ungrouped$SBHomeScreenViewController$viewDidAppear$)(_LOGOS_SELF_TYPE_NORMAL SBHomeScreenViewController* _LOGOS_SELF_CONST, SEL, BOOL); static void _logos_method$_ungrouped$SBHomeScreenViewController$viewDidAppear$(_LOGOS_SELF_TYPE_NORMAL SBHomeScreenViewController* _LOGOS_SELF_CONST, SEL, BOOL); static void (*_logos_orig$_ungrouped$SpringBoard$applicationDidFinishLaunching$)(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST, SEL, UIApplication *); static void _logos_method$_ungrouped$SpringBoard$applicationDidFinishLaunching$(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST, SEL, UIApplication *); static void (*_logos_orig$_ungrouped$SpringBoard$noteInterfaceOrientationChanged$duration$updateMirroredDisplays$force$logMessage$)(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST, SEL, long long, double, BOOL, BOOL, id); static void _logos_method$_ungrouped$SpringBoard$noteInterfaceOrientationChanged$duration$updateMirroredDisplays$force$logMessage$(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST, SEL, long long, double, BOOL, BOOL, id); static void (*_logos_orig$_ungrouped$SBLockScreenViewControllerBase$finishUIUnlockFromSource$)(_LOGOS_SELF_TYPE_NORMAL SBLockScreenViewControllerBase* _LOGOS_SELF_CONST, SEL, int); static void _logos_method$_ungrouped$SBLockScreenViewControllerBase$finishUIUnlockFromSource$(_LOGOS_SELF_TYPE_NORMAL SBLockScreenViewControllerBase* _LOGOS_SELF_CONST, SEL, int); static void (*_logos_orig$_ungrouped$SBFluidSwitcherGestureManager$grabberTongueBeganPulling$withDistance$andVelocity$)(_LOGOS_SELF_TYPE_NORMAL SBFluidSwitcherGestureManager* _LOGOS_SELF_CONST, SEL, id, double, double); static void _logos_method$_ungrouped$SBFluidSwitcherGestureManager$grabberTongueBeganPulling$withDistance$andVelocity$(_LOGOS_SELF_TYPE_NORMAL SBFluidSwitcherGestureManager* _LOGOS_SELF_CONST, SEL, id, double, double); static void (*_logos_orig$_ungrouped$SBHomeHardwareButton$singlePressUp$)(_LOGOS_SELF_TYPE_NORMAL SBHomeHardwareButton* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$SBHomeHardwareButton$singlePressUp$(_LOGOS_SELF_TYPE_NORMAL SBHomeHardwareButton* _LOGOS_SELF_CONST, SEL, id); static void (*_logos_orig$_ungrouped$SBLockHardwareButton$singlePress$)(_LOGOS_SELF_TYPE_NORMAL SBLockHardwareButton* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$SBLockHardwareButton$singlePress$(_LOGOS_SELF_TYPE_NORMAL SBLockHardwareButton* _LOGOS_SELF_CONST, SEL, id); static void (*_logos_orig$_ungrouped$SBLockStateAggregator$_updateLockState)(_LOGOS_SELF_TYPE_NORMAL SBLockStateAggregator* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SBLockStateAggregator$_updateLockState(_LOGOS_SELF_TYPE_NORMAL SBLockStateAggregator* _LOGOS_SELF_CONST, SEL); 
static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$SBUserNotificationAlert(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("SBUserNotificationAlert"); } return _klass; }static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$SBAlertItemsController(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("SBAlertItemsController"); } return _klass; }
#line 19 "/Users/willsmillie/Desktop/Dev/iOS/Jailbreak/PullOverPro/PullOverPro/PullOverPro.xm"

static void _logos_method$_ungrouped$SBHomeScreenViewController$viewDidAppear$(_LOGOS_SELF_TYPE_NORMAL SBHomeScreenViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, BOOL arg1){
    _logos_orig$_ungrouped$SBHomeScreenViewController$viewDidAppear$(self, _cmd, arg1);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        NSString *name = tweakName;
        
        
        WhatsNewViewController *whatsNew = enclave.whatsNewViewController;
        whatsNew.changelogPath = changelog;
        whatsNew.title = tweakName;
        if (@available(iOS 13.0, *)) {
            whatsNew.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
        }

        BOOL hasShownAlert = [[NSUserDefaults standardUserDefaults] boolForKey:[NSString stringWithFormat:@"%@-%@", name, whatsNew.currentVersion]];
        if (!hasShownAlert) {
            UIViewController *vc = self;
            while (vc.presentedViewController) {vc = vc.presentedViewController;}
            [vc presentViewController:whatsNew animated:YES completion:nil];
        }
    });
}





static void _logos_method$_ungrouped$SpringBoard$applicationDidFinishLaunching$(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UIApplication * arg1){
    _logos_orig$_ungrouped$SpringBoard$applicationDidFinishLaunching$(self, _cmd, arg1);
    
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

    
    [enclave isAuthenticated:^(NSError *error, BOOL validAuth) {
        if (validAuth) {
            if ([[POApplicationHelper settings][@"enabled"] boolValue]){
                window = [PullOverWindow sharedWindow];
                window.alpha = 0;
                [window makeKeyAndVisible];
                
                if ([[POApplicationHelper settings][@"leftHanded"] boolValue]){
                    window.transform = CGAffineTransformMakeScale(-1.0, 1.0);
                }
            }
        }else{
            if (startupAlert){
                return;
            }
            if (error.code == 1) {
                startupAlert = [[_logos_static_class_lookup$SBUserNotificationAlert() alloc] init];
                [startupAlert setAlertHeader:tweakName];
                [startupAlert setAlertMessage:@"Please activate in Settings > PullOver Pro"];
                [startupAlert setDefaultButtonTitle:@"Ok!"];
                [(SBAlertItemsController *)[_logos_static_class_lookup$SBAlertItemsController() sharedInstance] activateAlertItem:startupAlert];

            }else if (error.code == 2){
                startupAlert = [[_logos_static_class_lookup$SBUserNotificationAlert() alloc] init];
                [startupAlert setAlertHeader:tweakName];
                [startupAlert setAlertMessage:error.localizedDescription];
                [startupAlert setDefaultButtonTitle:@"Ok"];
                [(SBAlertItemsController *)[_logos_static_class_lookup$SBAlertItemsController() sharedInstance] activateAlertItem:startupAlert];
            }
        }
    }];
}

static void _logos_method$_ungrouped$SpringBoard$noteInterfaceOrientationChanged$duration$updateMirroredDisplays$force$logMessage$(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, long long arg1, double arg2, BOOL arg3, BOOL arg4, id arg5){
    
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
    
    _logos_orig$_ungrouped$SpringBoard$noteInterfaceOrientationChanged$duration$updateMirroredDisplays$force$logMessage$(self, _cmd, arg1, arg2, arg3, arg4, arg5);
}



static void _logos_method$_ungrouped$SBLockScreenViewControllerBase$finishUIUnlockFromSource$(_LOGOS_SELF_TYPE_NORMAL SBLockScreenViewControllerBase* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, int arg1){
    _logos_orig$_ungrouped$SBLockScreenViewControllerBase$finishUIUnlockFromSource$(self, _cmd, arg1);
}




static void _logos_method$_ungrouped$SBFluidSwitcherGestureManager$grabberTongueBeganPulling$withDistance$andVelocity$(_LOGOS_SELF_TYPE_NORMAL SBFluidSwitcherGestureManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, double arg2, double arg3) {
    if ([window.controller isOpened]){
        [window.controller close];
        [self grabberTongueCanceledPulling:arg1 withDistance:arg2 andVelocity:arg3];
    }else{
        _logos_orig$_ungrouped$SBFluidSwitcherGestureManager$grabberTongueBeganPulling$withDistance$andVelocity$(self, _cmd, arg1, arg2, arg3);
    }
}



static void _logos_method$_ungrouped$SBHomeHardwareButton$singlePressUp$(_LOGOS_SELF_TYPE_NORMAL SBHomeHardwareButton* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1){
    if ([window.controller isOpened]){
        [window.controller close];
    }else{
        _logos_orig$_ungrouped$SBHomeHardwareButton$singlePressUp$(self, _cmd, arg1);
    }
}



static void _logos_method$_ungrouped$SBLockHardwareButton$singlePress$(_LOGOS_SELF_TYPE_NORMAL SBLockHardwareButton* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
    if ([window.controller isOpened]){
        [window.controller close];
    }
    _logos_orig$_ungrouped$SBLockHardwareButton$singlePress$(self, _cmd, arg1);
}




static void _logos_method$_ungrouped$SBLockStateAggregator$_updateLockState(_LOGOS_SELF_TYPE_NORMAL SBLockStateAggregator* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    _logos_orig$_ungrouped$SBLockStateAggregator$_updateLockState(self, _cmd);
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


static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SBHomeScreenViewController = objc_getClass("SBHomeScreenViewController"); MSHookMessageEx(_logos_class$_ungrouped$SBHomeScreenViewController, @selector(viewDidAppear:), (IMP)&_logos_method$_ungrouped$SBHomeScreenViewController$viewDidAppear$, (IMP*)&_logos_orig$_ungrouped$SBHomeScreenViewController$viewDidAppear$);Class _logos_class$_ungrouped$SpringBoard = objc_getClass("SpringBoard"); MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(applicationDidFinishLaunching:), (IMP)&_logos_method$_ungrouped$SpringBoard$applicationDidFinishLaunching$, (IMP*)&_logos_orig$_ungrouped$SpringBoard$applicationDidFinishLaunching$);MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(noteInterfaceOrientationChanged:duration:updateMirroredDisplays:force:logMessage:), (IMP)&_logos_method$_ungrouped$SpringBoard$noteInterfaceOrientationChanged$duration$updateMirroredDisplays$force$logMessage$, (IMP*)&_logos_orig$_ungrouped$SpringBoard$noteInterfaceOrientationChanged$duration$updateMirroredDisplays$force$logMessage$);Class _logos_class$_ungrouped$SBLockScreenViewControllerBase = objc_getClass("SBLockScreenViewControllerBase"); MSHookMessageEx(_logos_class$_ungrouped$SBLockScreenViewControllerBase, @selector(finishUIUnlockFromSource:), (IMP)&_logos_method$_ungrouped$SBLockScreenViewControllerBase$finishUIUnlockFromSource$, (IMP*)&_logos_orig$_ungrouped$SBLockScreenViewControllerBase$finishUIUnlockFromSource$);Class _logos_class$_ungrouped$SBFluidSwitcherGestureManager = objc_getClass("SBFluidSwitcherGestureManager"); MSHookMessageEx(_logos_class$_ungrouped$SBFluidSwitcherGestureManager, @selector(grabberTongueBeganPulling:withDistance:andVelocity:), (IMP)&_logos_method$_ungrouped$SBFluidSwitcherGestureManager$grabberTongueBeganPulling$withDistance$andVelocity$, (IMP*)&_logos_orig$_ungrouped$SBFluidSwitcherGestureManager$grabberTongueBeganPulling$withDistance$andVelocity$);Class _logos_class$_ungrouped$SBHomeHardwareButton = objc_getClass("SBHomeHardwareButton"); MSHookMessageEx(_logos_class$_ungrouped$SBHomeHardwareButton, @selector(singlePressUp:), (IMP)&_logos_method$_ungrouped$SBHomeHardwareButton$singlePressUp$, (IMP*)&_logos_orig$_ungrouped$SBHomeHardwareButton$singlePressUp$);Class _logos_class$_ungrouped$SBLockHardwareButton = objc_getClass("SBLockHardwareButton"); MSHookMessageEx(_logos_class$_ungrouped$SBLockHardwareButton, @selector(singlePress:), (IMP)&_logos_method$_ungrouped$SBLockHardwareButton$singlePress$, (IMP*)&_logos_orig$_ungrouped$SBLockHardwareButton$singlePress$);Class _logos_class$_ungrouped$SBLockStateAggregator = objc_getClass("SBLockStateAggregator"); MSHookMessageEx(_logos_class$_ungrouped$SBLockStateAggregator, @selector(_updateLockState), (IMP)&_logos_method$_ungrouped$SBLockStateAggregator$_updateLockState, (IMP*)&_logos_orig$_ungrouped$SBLockStateAggregator$_updateLockState);} }
#line 188 "/Users/willsmillie/Desktop/Dev/iOS/Jailbreak/PullOverPro/PullOverPro/PullOverPro.xm"
