//
//  BaseScrollView.m
//  PullOverPro
//
//  Created by Will Smillie on 4/8/19.
//

#import "BaseScrollView.h"
#import "POHandle.h"

@implementation BaseScrollView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitTestResult = [super hitTest:point withEvent:event];
    
    if ([hitTestResult isKindOfClass:[POHandle class]]) {
        return hitTestResult;
    }
    return nil;
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    return YES;
}

@end
