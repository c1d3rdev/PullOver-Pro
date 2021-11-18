Life360 Confetti
========
Why Confetti? Because here at Life360 we like to celebrate our users and their accomplishments. We believe products should celebrate users and give them a gift when they've accomplished something. 

That's why we've created L360Confetti.

##iOS

<img src="/iOS/ConfettiGif.gif" alt="Confetti!! Gif thanks to gfycat.com" width="320px" />

**[Get Example Project](https://github.com/life360/confetti/tree/master/iOS/L360ConfettiExample)**

###Installation 
Requirement: iOS 7.0 or above because this class relies heavily on [UIDynamics](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIDynamicAnimator_Class)

####Cocoapods Installation
Add the following line to your podfile:

`pod 'L360Confetti', :git => 'https://github.com/life360/confetti.git'`

And then run `pod install`

####..Or Manual Installation
Copy the contents of [L360Confetti](https://github.com/life360/confetti/tree/master/iOS/L360Confetti) folder located in iOS/L360Confetti

###Using L360Confetti
`L360ConfettiArea` is a view that you add to your view controller in which the confetti will display.

**Note:** The L360ConfettiArea is a UIView that retains the default settings of UIViews where `userInteractionEnabled` is `YES` (so no click-through) and `layer.masksToBounds` is `NO` (So confetti can pop up anywhere<sup>1</sup>) by default.

**<sup>1</sup>** The confetti disappears at the bottom of the frame for the L360ConfettiArea. The confetti are garbage collected so that you can explode as much confetti into the area as you want.

####Initialization
```smalltalk
#import "L360ConfettiArea.h"

// Wherever youre going to initialize it
L360ConfettiArea *confettiArea = [[L360ConfettiArea alloc] initWithFrame:confettiFrame];
```

####Burst Confetti
L360Confetti is currently designed to burst confetti from a single point on the view. Use the following to accomplish this.

```smalltalk
// Signature
- (void)burstAt:(CGPoint)point confettiWidth:(CGFloat)confettiWidth numberOfConfetti:(NSInteger)numberConfetti

// Use
[confettiArea burstAt:[self.view convertPoint:tapPoint toView:self.confettiView] confettiWidth:10.0 numberOfConfetti:15];
```

**Note for Confetti Width:**
Currently to give the confetti some nice fluttering effect, using layer animations for rotations along different axis, thus the confetti has to be a square.

####Confetti Colors
To control the colors of the confetti, you need to provide the L360ConfettiArea's delegate method an array of colors.

```smalltalk
confettiArea.delegate = self;

// ...
- (NSArray *)colorsForConfettiArea:(L360ConfettiArea *)confettiArea
{
    return @[[UIColor blueColor], [UIColor redColor], [UIColor purpleColor]];
}
```

###Issues and Help
If the community could help us figure out a few of the problems with the L360Confetti that would be great. Following is a list of the issues we're currently facing:
* [Having to use square ConfettiViews](https://github.com/life360/confetti/issues/2) because of the layer rotations for fluttering
* [Have different kinds of confetti](https://github.com/life360/confetti/issues/4), ones that swirl or loop down.

## License

L360Confetti is available under the [Apache License Version 2.0](https://github.com/life360/confetti/blob/master/iOS/LICENSE.md)
