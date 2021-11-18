//
//  PullOverProPreferencesController.h
//  PullOverProPreferences
//
//  Created by Will Smillie on 4/9/19.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Preferences/Preferences.h>
#import <L360Confetti/L360ConfettiArea.h>
#import "POApplicationHelper.h"

@interface PullOverProPreferencesController : PSListController <L360ConfettiAreaDelegate, PaywallViewControllerDelegate>

@property(nonatomic, strong) L360ConfettiArea *confettiArea;
-(void)burst;

- (id)getValueForSpecifier:(PSSpecifier*)specifier;
- (void)setValue:(id)value forSpecifier:(PSSpecifier*)specifier;
- (void)followOnTwitter:(PSSpecifier*)specifier;
- (void)visitWebSite:(PSSpecifier*)specifier;
- (void)makeDonation:(PSSpecifier*)specifier;

@end
