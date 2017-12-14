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
    [[AMTagView appearance] setTextPadding:CGPointMake(14, 14)];
    [[AMTagView appearance] setTextFont:[UIFont fontWithName:@"Futura" size:14]];
    [[AMTagView appearance] setTagColor:UIColorFromRGB(0x1f8dd6)];
    [[AMTagView appearance] setAccessoryImage:[UIImage imageNamed:@"close"]];
    
    [self.tagListView addTag:@"my tag"];
    [self.tagListView addTag:@"something"];
    [self.tagListView addTag:@"long tag is long"];
    [self.tagListView addTag:@"hi there"];
    AMTagView *tag = [self.tagListView addTag:@"No image accessory"];
    tag.accessoryImage = nil;
    
    self.tagListView.tagListDelegate = self;
    
    [self.tagListView setTapHandler:^(AMTagView *view) {
        view.tag++;
        NSString *text = [[view.tagText componentsSeparatedByString:@" +"] firstObject];
        [view setTagText:[NSString stringWithFormat:@"%@ +%ld", text, view.tag]];
    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Remove"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(removeLast)];
}

- (void)removeLast {
    UIView<AMTag> *tag = self.tagListView.tags.lastObject;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete"
                                                    message:[NSString stringWithFormat:@"Delete %@?", [tag tagText]]
                                                   delegate:self
                                          cancelButtonTitle:@"Nope"
                                          otherButtonTitles:@"Sure!", nil];
    [alert show];
}

- (BOOL)tagList:(AMTagListView *)tagListView shouldAddTagWithText:(NSString *)text resultingContentSize:(CGSize)size {
    // Don't add a 'bad' tag
    return ![text isEqualToString:@"bad"];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex > 0) {
        UIView<AMTag> *tag = self.tagListView.tags.lastObject;
        [self.tagListView removeTag:tag];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.tagListView addTag:textField.text];
    [self.textField setText:@""];
    return YES;
}

// Close the keyboard when the user taps away from a textfield
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.textField resignFirstResponder];
}

@end
