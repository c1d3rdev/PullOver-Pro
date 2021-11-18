//
//  L360ConfettiAble.h
//  L360ConfettiExample
//
//  Created by Joshua Archer on 3/31/17.
//  Copyright © 2017 Life360. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "L360ConfettiView.h"

@protocol L360ConfettiAble <NSObject>

- (instancetype _Nonnull)initWithStartingPoint:(CGPoint)point
                                 confettiColor:(UIColor * _Nullable)color
                              withFlutterSpeed:(CGFloat)flutterSpeed
                                   flutterType:(L360ConfettiFlutterType)flutterType;

@end
