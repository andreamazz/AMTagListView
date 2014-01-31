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

@interface AMViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField	*textField;
@property (nonatomic, strong) AMTagListView			*tagListView;

@end

@implementation AMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[self.textField.layer setBorderColor:UIColorFromRGB(0xe06431).CGColor];
	[self.textField.layer setBorderWidth:2];
	[self.textField setDelegate:self];

	[[AMTagView appearance] setTagLength:10];
	[[AMTagView appearance] setTextPadding:14];
	[[AMTagView appearance] setTextFont:[UIFont fontWithName:@"Futura" size:14]];
	[[AMTagView appearance] setTagColor:UIColorFromRGB(0xe06431)];
	
	_tagListView = [[AMTagListView alloc] initWithFrame:(CGRect){0, 100, 320, 300}];
	[self.tagListView addTag:@"my tag"];
	[self.tagListView addTag:@"something"];
	[self.tagListView addTag:@"long tag is long"];
	[self.tagListView addTag:@"hi there"];
	
	[self.view addSubview:self.tagListView];
	
	__weak AMViewController* weakSelf = self;
	[self.tagListView setTapHandler:^(AMTagView *view) {
		[weakSelf.tagListView removeTag:view];
	}];
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
