//
//  PullOverWindow.h
//  PullOverPro
//
//  Created by Will Smillie on 4/8/19.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "PullOverViewController.h"

@interface PullOverWindow : UIWindow

@property (nonatomic, strong) PullOverViewController *controller;

+ (id)sharedWindow;
- (id)distribute;

@end
