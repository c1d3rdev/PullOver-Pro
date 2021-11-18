//
//  L360ConfettiView.h
//  L360ConfettiExample
//
//  Created by Mohammed Islam on 12/12/14.
//  Copyright (c) 2014 Life360. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, L360ConfettiFlutterType) {
    L360ConfettiFlutterTypeDiagonal1,
    L360ConfettiFlutterTypeDiagonal2,
    L360ConfettiFlutterTypeHorizontal,
    L360ConfettiFlutterTypeVertical,
    L360ConfettiFlutterTypeCount
};

@interface L360ConfettiView : UIView

/**
 *  Initialization method
 *
 *  @param frame
 *  @param flutterSpeed Rotations/sec speed of "flutter" of confetti
 *  @param flutterType They type of flutter for confetti
 */
- (instancetype)initWithFrame:(CGRect)frame
             withFlutterSpeed:(CGFloat)flutterSpeed
                  flutterType:(L360ConfettiFlutterType)flutterType;

@end
