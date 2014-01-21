//
//  AMTagListView.m
//  AMTagListView
//
//  Created by Andrea Mazzini on 20/01/14.
//  Copyright (c) 2014 Fancy Pixel. All rights reserved.
//

#import "AMTagListView.h"

@interface AMTagListView ()

@end

@implementation AMTagListView

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		// Default margins
		_marginX = 4;
		_marginY = 4;
	}
	return self;
}

- (void)addTag:(NSString*)text
{
	UIFont* font = [[AMTagView appearance] textFont] ? [[AMTagView appearance] textFont] : kDefaultFont;
	CGSize size = [text sizeWithAttributes:@{NSFontAttributeName: font}];
	
	float padding = [[AMTagView appearance] textPadding] ? [[AMTagView appearance] textPadding] : kDefaultTextPadding;
	float tagLength = [[AMTagView appearance] tagLength] ? [[AMTagView appearance] tagLength] : kDefaultTagLength;
	
	size.width = (int)size.width + padding*2 + tagLength;
	size.height = (int)size.height + padding;
	
	__block float maxY = 0;
	__block float maxX = 0;
	[self.subviews enumerateObjectsUsingBlock:^(UIView* obj, NSUInteger idx, BOOL *stop) {
		maxY = MAX(maxY, obj.frame.origin.y);
	}];
	
	[self.subviews enumerateObjectsUsingBlock:^(UIView* obj, NSUInteger idx, BOOL *stop) {
		if (obj.frame.origin.y == maxY) {
			maxX = MAX(maxX, obj.frame.origin.x + obj.frame.size.width);
		}
	}];
	
	// Go to a new line if the tag won't fit
	if (size.width + maxX > (self.frame.size.width - self.marginX)) {
		maxY += size.height + self.marginY;
		maxX = 0;
	}
	
	AMTagView* tagView = [[AMTagView alloc] initWithFrame:(CGRect){maxX + self.marginX, maxY, size.width, size.height}];
	[tagView setupWithText:text];
	[self addSubview:tagView];
	
	[self setContentSize:(CGSize){self.frame.size.width, maxY + size.height +self.marginY}];
}

- (void)addTags:(NSArray*)array
{
	for (NSString* text in array) {
		[self addTag:text];
	}
}

@end
