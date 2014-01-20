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

@interface AMViewController ()

@end

@implementation AMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

	[[AMTagView appearance] setTagLength:10];
	[[AMTagView appearance] setTextPadding:14];
	[[AMTagView appearance] setTextFont:[UIFont fontWithName:@"Futura" size:14]];
	[[AMTagView appearance] setTagColor:UIColorFromRGB(0xe06431)];
	
	AMTagListView* tagListView = [[AMTagListView alloc] initWithFrame:(CGRect){0, 100, 320, 300}];
	[tagListView addTag:@"my tag"];
	[tagListView addTag:@"something"];
	[tagListView addTag:@"long tag is long"];
	[tagListView addTag:@"hi there"];
	
	[self.view addSubview:tagListView];
}

@end
