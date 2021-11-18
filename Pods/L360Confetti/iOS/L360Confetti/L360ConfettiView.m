//
//  L360ConfettiView.m
//  L360ConfettiExample
//
//  Created by Mohammed Islam on 12/12/14.
//  Copyright (c) 2014 Life360. All rights reserved.
//

#import "L360ConfettiView.h"

@interface L360ConfettiView ()

@property (nonatomic, assign) CGFloat flutterSpeed;
@property (nonatomic, assign) L360ConfettiFlutterType flutterType;
@property (nonatomic, assign) BOOL animationAdded;

@end

@implementation L360ConfettiView

- (instancetype)initWithFrame:(CGRect)frame
             withFlutterSpeed:(CGFloat)flutterSpeed
                  flutterType:(L360ConfettiFlutterType)flutterType
{
    self = [super initWithFrame:frame];
    if (self) {
        self.flutterSpeed = flutterSpeed;
        self.flutterType = flutterType;
        self.animationAdded = NO;
    }
    return self;
}

- (void)didMoveToSuperview
{
    // No need to add the animation more than once
    if (self.animationAdded) {
        return;
    }
    
    self.animationAdded = YES;
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    rotationAnimation.duration = 1.0 / self.flutterSpeed;
    rotationAnimation.repeatCount = 500;
    
    CATransform3D rotationTransform;
    
    switch (self.flutterType) {
        default:
        case L360ConfettiFlutterTypeDiagonal1:
            rotationTransform = CATransform3DMakeRotation(M_PI, -1.0, 1.0, 0.0);
            break;
            
        case L360ConfettiFlutterTypeDiagonal2:
            rotationTransform = CATransform3DMakeRotation(M_PI, 1.0, 1.0, 0.0);
            break;
            
        case L360ConfettiFlutterTypeVertical:
            rotationTransform = CATransform3DMakeRotation(M_PI, 0.0, 1.0, 0.0);
            break;
            
        case L360ConfettiFlutterTypeHorizontal:
            rotationTransform = CATransform3DMakeRotation(M_PI, 1.0, 0.0, 0.0);
            break;
    }
    
    // set the animation's "toValue" which MUST be wrapped in an NSValue instance (except special cases such as colors)
    rotationAnimation.toValue = [NSValue valueWithCATransform3D:rotationTransform];
    
    // finally, apply the animation
    [self.layer addAnimation:rotationAnimation forKey:@"L360ConfettiRotationAnimation"];
}

@end
