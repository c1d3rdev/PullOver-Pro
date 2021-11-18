#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSControlTableCell.h>

@interface POScaleStepperTableCell : PSControlTableCell {
	NSString *title;
}
@property (nonatomic, retain) UIStepper *control;
@end

@implementation POScaleStepperTableCell

@dynamic control;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier]) {
		self.accessoryView = self.control;
        [self.detailTextLabel setHidden:YES];
	}
	return self;
}

- (void)refreshCellContentsWithSpecifier:(PSSpecifier *)specifier {
	[super refreshCellContentsWithSpecifier:specifier];
	title = [specifier propertyForKey:@"label"];
	[self _updateLabel];
}

- (UIStepper *)newControl {
	UIStepper *stepper = [[UIStepper alloc] initWithFrame:CGRectZero];
	stepper.continuous = NO;
    stepper.stepValue = 0.25;
	stepper.value = 1.75;
	stepper.minimumValue = 1;
	stepper.maximumValue = 3;
	return stepper;
}

- (NSNumber *)controlValue {
	return @(self.control.value);
}

- (void)setValue:(NSNumber *)value {
	[super setValue:value];
    self.control.value = value.doubleValue;
}

- (void)controlChanged:(UIStepper *)stepper {
	[super controlChanged:stepper];
	[self _updateLabel];
}

- (void)_updateLabel {
	if (!self.control) {
		return;
	}

	float value = self.control.value;
    NSString *valString = [NSString stringWithFormat:@"%.2f%%", value];
	self.textLabel.text = [NSString stringWithFormat:@"QuickSwitch Item Scale %@", valString];

	[self setNeedsLayout];
}

@end
