//
//  QuickSwitchTableView.h
//  PullOverPro
//
//  Created by Will Smillie on 4/8/19.
//

#import <UIKit/UIKit.h>

#import "POApplicationHelper.h"
#import "QuickSwitchTableViewCell.h"

@class QuickSwitchTableView;
@protocol QuickSwitchSelectionDelegate <NSObject>

-(void)quickSwitchTableViewWillAppear:(QuickSwitchTableView *)quickSwitchTableView;
-(void)quickSwitchTableView:(QuickSwitchTableView *)quickSwitchTableView didSelectBundleId:(NSString *)bundleId;
-(void)quickSwitchTableView:(QuickSwitchTableView *)quickSwitchTableView draggingDidChangeForQuickSwitchItem:(id)item withPoint:(CGPoint)point;
-(void)quickSwitchTableView:(QuickSwitchTableView *)quickSwitchTableView didDropApp:(SBApplication *)app atPoint:(CGPoint)point;
-(void)draggingDidEnterBoundsOfQuickSwitchTableView:(QuickSwitchTableView *)quickSwitchTableView;
-(void)quickSwitchTableViewDidDisappear:(QuickSwitchTableView *)quickSwitchTableView;

@end


@interface QuickSwitchTableView : UITableView <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) id <QuickSwitchSelectionDelegate> selectionDelegate;
@property (nonatomic) BOOL darkMode;
-(void)presentFromHandle:(UIView *)handle withRecognizer:(UILongPressGestureRecognizer *)recognizer;
-(instancetype)initWithDarkMode:(BOOL)darkMode;

@end

