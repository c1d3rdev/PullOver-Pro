//
//  QuickSwitchTableViewCell.m
//  PullOverPro
//
//  Created by Will Smillie on 4/8/19.
//

#import "QuickSwitchTableViewCell.h"
#import "POApplicationHelper.h"

@implementation QuickSwitchTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 18, 18)];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.imgView];
        
        if (@available(iOS 13, *)){
            self.backgroundColor = [UIColor performSelector:@selector(secondarySystemBackgroundColor)];
        }else{
            self.backgroundColor = [[POApplicationHelper settings][@"darkHandle"] boolValue] ? [UIColor darkGrayColor] : [UIColor whiteColor];
        }

        
        if ([[POApplicationHelper settings][@"leftHanded"] boolValue]){
            self.imgView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        }
    }
    return self;
}

@end
