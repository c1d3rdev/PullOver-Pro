//
//  L360ConfettiObject.m
//  L360ConfettiExample
//
//  Created by Mohammed Islam on 12/11/14.
//  Copyright (c) 2014 Life360. All rights reserved.
//

#import "L360ConfettiObject.h"

typedef NS_ENUM(NSInteger, L360ConfettiObjectSwayType) {
    L360ConfettiObjectSwayTypeNone,
    L360ConfettiObjectSwayTypeLeft,
    L360ConfettiObjectSwayTypeRight
};

@interface L360ConfettiObject ()
{
    UIDynamicItemBehavior *_fallingBehavior;
    L360ConfettiObjectSwayType _swayType;
    CGFloat _swayFocalPointX;
}

@property (nonatomic, strong) UIView *confettiView;
@property (nonatomic, assign) CGRect confettiAreaBounds;

@property (nonatomic, weak) UIDynamicAnimator *animator;
@property (nonatomic, weak) UIGravityBehavior *gravityBehavior;

@end

@implementation L360ConfettiObject

@synthesize
fallingBehavior = _fallingBehavior;

- (instancetype)initWithConfettiView:(UIView *)confettiView
                    keepWithinBounds:(CGRect)bounds
                            animator:(UIDynamicAnimator *)animator
                             gravity:(UIGravityBehavior *)gravity
{
    self = [super init];
    if (self) {
        self.linearVelocity = CGPointMake(0.0, 0.0);
        self.swayLength = 0.0;
        self.density = 1.0;
        self.confettiView = confettiView;
        self.confettiAreaBounds = bounds;
        self.animator = animator;
        self.gravityBehavior = gravity;
        _swayType = L360ConfettiObjectSwayTypeNone;
    }
    
    return self;
}

- (UIDynamicItemBehavior *)fallingBehavior
{
    if (!_fallingBehavior) {
        _fallingBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.confettiView]];
        [_fallingBehavior addLinearVelocity:_linearVelocity forItem:self.confettiView];
        
        __weak L360ConfettiObject *weakSelf = self;
        __weak UIDynamicItemBehavior *weakBehavior = _fallingBehavior;
        _fallingBehavior.action = ^{
            // Need to simulate paper falling with a terminal velocity
            CGPoint linearVelocity = [weakBehavior linearVelocityForItem:weakSelf.confettiView];
            // Don't kick in the acceleration limiter till the items start to fall
            if (linearVelocity.y > 50.0) {
                [weakSelf handleSway];
                
                // The calculation for terminal velocity is simple:
                // divide the linear velocity by gravity magnitude and density of the object
                // Then divide by a magic number for good measure.
                weakBehavior.resistance = linearVelocity.y / weakSelf.gravityBehavior.magnitude / weakSelf.density / 100.0;
            }
            
            // Garbage collect the confetti once it's fallen outside the confettiAreaBounds
            if (weakSelf.confettiView.center.y > weakSelf.confettiAreaBounds.size.height) {
                [weakSelf cleanupObject];
            }
        };
    }
    
    return _fallingBehavior;
}

- (void)handleSway
{
    switch (_swayType) {
        case L360ConfettiObjectSwayTypeNone:
            _swayFocalPointX = self.confettiView.center.x;
            _swayType = [self flipCoinIsHeads] ? L360ConfettiObjectSwayTypeLeft : L360ConfettiObjectSwayTypeRight;
            
            break;
            
        case L360ConfettiObjectSwayTypeLeft:
            [_fallingBehavior addLinearVelocity:CGPointMake(-10.0, 0.0) forItem:self.confettiView];
            
            if (self.confettiView.center.x < (_swayFocalPointX - (self.swayLength / 2.0))) {
                // Switch to the other direction
                _swayType = L360ConfettiObjectSwayTypeRight;
            }
            break;
            
        case L360ConfettiObjectSwayTypeRight:
            [_fallingBehavior addLinearVelocity:CGPointMake(10.0, 0.0) forItem:self.confettiView];
            
            if (self.confettiView.center.x > (_swayFocalPointX + (self.swayLength / 2.0))) {
                // Switch to the other direction
                _swayType = L360ConfettiObjectSwayTypeLeft;
            }
            break;
            
        default:
            break;
    }
}

- (void)cleanupObject
{
    // Remove the behavior items
    [_fallingBehavior removeItem:self.confettiView];
    _fallingBehavior.action = nil;
    
    // Remove behavior from parent animator and remove view from gravity
    [self.animator removeBehavior:_fallingBehavior];
    [self.gravityBehavior removeItem:self.confettiView];
    
    // Remove confetti from superview
    [self.confettiView removeFromSuperview];
    
    // Nil it all out
    _fallingBehavior = nil;
    self.confettiView = nil;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(needToDeallocateConfettiObject:)]) {
        [self.delegate needToDeallocateConfettiObject:self];
    }
}

- (BOOL)flipCoinIsHeads
{
    return arc4random_uniform(1);
}

@end
