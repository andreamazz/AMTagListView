//
//  AMViewController.m
//  TagListViewDemo
//
//  Created by Andrea Mazzini on 20/01/14.
//  Copyright (c) 2014 Fancy Pixel. All rights reserved.
//

#import "AMViewController.h"
#import "AMTagListView.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface AMViewController () <UITextFieldDelegate, UIAlertViewDelegate, AMTagListDelegate>

@property (weak, nonatomic) IBOutlet UITextField    *textField;
@property (weak, nonatomic) IBOutlet AMTagListView	*tagListView;
@property (nonatomic, strong) AMTagView             *selection;

@end

@implementation AMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[self setTitle:@"Demo"];
	
	[self.textField.layer setBorderColor:UIColorFromRGB(0x1f8dd6).CGColor];
	[self.textField.layer setBorderWidth:2];
	[self.textField setDelegate:self];
    
	[[AMTagView appearance] setTagLength:10];
	[[AMTagView appearance] setTextPadding:14];
	[[AMTagView appearance] setTextFont:[UIFont fontWithName:@"Futura" size:14]];
	[[AMTagView appearance] setTagColor:UIColorFromRGB(0x1f8dd6)];
	
	[self.tagListView addTag:@"my tag"];
    [self.tagListView addTag:@"something"];
    [[AMTagView appearance] setAccessoryImage:[UIImage imageNamed:@"remove_icon"]];
    [self.tagListView addTag:@"long tag is long"];
	[self.tagListView addTag:@"hi there"];
    
    self.tagListView.tagListDelegate = self;
	
	__weak AMViewController* weakSelf = self;
	[self.tagListView setTapHandler:^(AMTagView *view) {
		weakSelf.selection = view;
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete"
														message:[NSString stringWithFormat:@"Delete %@?", [view tagText]]
													   delegate:weakSelf
											  cancelButtonTitle:@"Nope"
											  otherButtonTitles:@"Sure!", nil];
		[alert show];
	}];
}

- (BOOL)tagList:(AMTagListView *)tagListView shouldAddTagWithText:(NSString *)text resultingContentSize:(CGSize)size
{
    // Don't add a 'bad' tag
    return ![text isEqualToString:@"bad"];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex > 0) {
		[self.tagListView removeTag:self.selection];
	}
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[self.tagListView addTag:textField.text];
	[self.textField setText:@""];
	return YES;
}

// Close the keyboard when the user taps away froma  textfield
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UIView* view in self.view.subviews) {
        if ([view isKindOfClass:[UITextField class]])
			[view resignFirstResponder];
    }
}

@end
