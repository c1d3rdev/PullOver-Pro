//
//  MHHandle.h
//  MessageHub
//
//  Created by Will Smillie on 1/18/19.
//

#import <UIKit/UIKit.h>

@class POHandle;
@protocol POHandleDelegate <NSObject>
- (void)handle:(POHandle *)handle didReceiveTap:(UIGestureRecognizer*)recognizer;
- (void)handle:(POHandle *)handle didLongPress:(UIGestureRecognizer*)recognizer;
@end


@interface POHandle : UIView

@property (nonatomic, weak) id <POHandleDelegate> delegate;
@property (nonatomic, strong) UIImageView *imageView;;
@property (nonatomic) BOOL isNubbed;
@property (nonatomic) BOOL darkMode;

-(instancetype)initWithController:(id)controller;


@end
