//
//  PullOverProPreferencesController.m
//  PullOverProPreferences
//
//  Created by Will Smillie on 4/9/19.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//

#import "PullOverProPreferencesController.h"
#import <Preferences/PSSpecifier.h>
#import <spawn.h>
#import "QSFavoritesPickerController.h"


#define kSetting_Example_Name @"NameOfAnExampleSetting"
#define kSetting_Example_Value @"ValueOfAnExampleSetting"

#define kSetting_TemplateVersion_Name @"TemplateVersionExample"
#define kSetting_TemplateVersion_Value @"1.0"


#define kUrl_FollowOnTwitter @"https://twitter.com/c1d3rdev"
#define kUrl_MakeDonation @"https://paypal.me/willsmillie"

#define kPrefs_Path @"/var/mobile/Library/Preferences"
#define kPrefs_KeyName_Key @"key"
#define kPrefs_KeyName_Defaults @"defaults"

@implementation PullOverProPreferencesController
@synthesize confettiArea;

static id favoritesCell;
static id recentsCell;

-(void)viewDidLoad{
    [super viewDidLoad];

    UIBarButtonItem* respringButton = [[UIBarButtonItem alloc] initWithTitle:@"Respring" style:UIBarButtonItemStylePlain target:self action:@selector(confirmRespring:)];
    self.navigationItem.rightBarButtonItem = respringButton;
    
    _table.separatorStyle = UITableViewScrollPositionNone;
}

-(void)viewWillAppear:(BOOL)view{
    [super viewWillAppear:view];
    
//    [self updateStyle];
}



-(void)viewDidAppear:(BOOL)view{
    [super viewDidAppear:view];
    
    if (!confettiArea) {
        confettiArea = [[L360ConfettiArea alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        confettiArea.userInteractionEnabled = NO;
        confettiArea.delegate = self;
        [self.splitViewController.view addSubview:confettiArea];
    }
    
}

-(void)burst{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Please Respring!" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Later" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Respring" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self respring];
    }]];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:YES completion:nil];
    });
    
    
    [confettiArea burstAt:confettiArea.center confettiWidth:10.0f numberOfConfetti:60];
}

-(void)paywallViewControllerDidCompleteAuthorization:(PaywallViewController *)paywallViewController{
    [self burst];
}

-(void)paywallViewControllerDidCancel:(PaywallViewController *)paywallViewController{
//    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(IBAction)confirmRespring:(id)sender{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Are you sure you want to respring?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Respring" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        [self respring];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)respring{
    pid_t pid;
    const char* args[] = {"killall", "backboardd", NULL};
    posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
}


- (id)getValueForSpecifier:(PSSpecifier*)specifier
{
	id value = nil;
	
	NSDictionary *specifierProperties = [specifier properties];
	NSString *specifierKey = [specifierProperties objectForKey:kPrefs_KeyName_Key];
	
	// get 'value' with code only
	if ([specifierKey isEqual:kSetting_TemplateVersion_Name])
	{
		value = kSetting_TemplateVersion_Value;
	}
    

		// get 'value' from 'defaults' plist (if 'defaults' key and file exists)
    NSMutableString *plistPath = [[NSMutableString alloc] initWithString:[specifierProperties objectForKey:kPrefs_KeyName_Defaults]];
    if (plistPath)
    {
        NSDictionary *dict = (NSDictionary*)[self initDictionaryWithFile:&plistPath asMutable:NO];
        
        id objectValue = [dict objectForKey:specifierKey];
        
        if (objectValue)
        {
            value = [NSString stringWithFormat:@"%@", objectValue];
            NSLog(@"read key '%@' with value '%@' from plist '%@'", specifierKey, value, plistPath);
        }
        else
        {
            NSLog(@"key '%@' not found in plist '%@'", specifierKey, plistPath);
        }
        
    }
	
	return value;
}

- (void)setValue:(id)value forSpecifier:(PSSpecifier*)specifier;
{
	NSDictionary *specifierProperties = [specifier properties];
	NSString *specifierKey = [specifierProperties objectForKey:kPrefs_KeyName_Key];
	
		NSMutableString *plistPath = [[NSMutableString alloc] initWithString:[specifierProperties objectForKey:kPrefs_KeyName_Defaults]];
		if (plistPath){
			NSMutableDictionary *dict = (NSMutableDictionary*)[self initDictionaryWithFile:&plistPath asMutable:YES];
			[dict setObject:value forKey:specifierKey];
			[dict writeToFile:plistPath atomically:YES];

			NSLog(@"[PO] saved key '%@' with value '%@' to plist '%@'", specifier.identifier, value, plistPath);
		}
		
		// use 'value' with code
    
    
		if ([specifier.identifier isEqual:@"Style"]){
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//                _specifiers = nil;
                [self reloadSpecifiers];
//                [self updateStyle];
            });

        }
}

-(void)updateStyle{
    if ([[POApplicationHelper settings][@"style"] isEqualToString:@"Recent Apps"]) {
        if ([self specifierForID:@"favoriteApps"]) {
            [self removeSpecifier:[self specifierForID:@"favoriteApps"] animated:NO];
        }
    }else{
        if ([self specifierForID:@"recentAppsCount"]) {
            [self removeSpecifier:[self specifierForID:@"recentAppsCount"] animated:NO];
        }
    }
}

- (id)initDictionaryWithFile:(NSMutableString**)plistPath asMutable:(BOOL)asMutable
{
	if ([*plistPath hasPrefix:@"/"])
		*plistPath = [NSString stringWithFormat:@"%@.plist", *plistPath];
	else
		*plistPath = [NSString stringWithFormat:@"%@/%@.plist", kPrefs_Path, *plistPath];
	
	Class class;
	if (asMutable)
		class = [NSMutableDictionary class];
	else
		class = [NSDictionary class];
	
	id dict;	
	if ([[NSFileManager defaultManager] fileExistsAtPath:*plistPath])
		dict = [[class alloc] initWithContentsOfFile:*plistPath];	
	else
		dict = [[class alloc] init];
	
	return dict;
}

- (void)followOnTwitter:(PSSpecifier*)specifier
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:kUrl_FollowOnTwitter]];
}

- (void)followAskusio_rrOnTwitter:(PSSpecifier*)specifier
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/akusio_RR"]];
}


//- (void)visitWebSite:(PSSpecifier*)specifier
//{
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kUrl_VisitWebSite]];
//}

- (void)makeDonation:(PSSpecifier *)specifier
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:kUrl_MakeDonation]];
}

- (id)specifiers
{
	if (_specifiers == nil) {
		_specifiers = [self loadSpecifiersFromPlistName:@"PullOverProPreferences" target:self];
	}
    
    return _specifiers;
}

- (id)init
{
	if ((self = [super init]))
	{
	}
	
	return self;
}


-(NSArray *)stylesDataSource{
    return @[@"Recent Apps", @"Favorite Apps"];
}

-(void)styleChanged:(PSSpecifier *)specifier{
}

-(void)selectFavorites:(PSSpecifier *)specifier{
    QSFavoritesPickerController *c = [[QSFavoritesPickerController alloc] init];
    [self pushController:c];
}

@end
