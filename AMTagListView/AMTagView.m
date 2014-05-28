//
//  AMTagView.m
//  AMTagListView
//
//  Created by Andrea Mazzini on 20/01/14.
//  Copyright (c) 2014 Fancy Pixel. All rights reserved.
//

#import "AMTagView.h"

NSString * const AMTagViewNotification = @"AMTagViewNotification";

@interface AMTagView ()

@property (nonatomic, strong) UILabel	*labelText;
@property (nonatomic, strong) UIButton	*button;

@end

@implementation AMTagView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		self.opaque = NO;
		self.backgroundColor = [UIColor clearColor];
		self.labelText = [[UILabel alloc] init];
		self.button = [[UIButton alloc] init];
		_radius = kDefaultRadius;
		_tagLength = kDefaultTagLength;
		_holeRadius = kDefaultHoleRadius;
		_innerTagPadding = kDefaultInnerPadding;
		_textPadding = kDefaultTextPadding;
		_textFont = kDefaultFont;
		_textColor = kDefaultTextColor;
		_tagColor = kDefaultTagColor;
		_innerTagColor = kDefaultInnerTagColor;
		[self addSubview:self.labelText];
		[self addSubview:self.button];
		[self.button addTarget:self action:@selector(actionButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)actionButton:(id)sender
{
	[[NSNotificationCenter defaultCenter] postNotification:[[NSNotification alloc] initWithName:AMTagViewNotification object:self userInfo:nil]];
}

- (void)setupWithText:(NSString*)text
{
	[self.labelText setText:text];
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	[self.labelText.layer setCornerRadius:self.radius / 2];
    [self.labelText setFrame:(CGRect){
		(int)(self.tagLength + self.radius * 3 / 2),
		(int)(self.radius / 2),
		(int)(self.frame.size.width - self.radius * 2 - self.radius / 2),
		(int)(self.frame.size.height - self.radius)
	}];
	[self.button setFrame:self.labelText.frame];
	[self.labelText setTextColor:self.textColor];
	[self.labelText setFont:self.textFont];
}

- (void)drawRect:(CGRect)rect
{
	float tagLength = self.tagLength;
	float height = floorf(rect.size.height);
	float width = rect.size.width;
	float radius = self.radius;
	
	UIBezierPath *aPath = [UIBezierPath bezierPath];
	
	[aPath moveToPoint:(CGPoint){width, height / 2}];
	[aPath addLineToPoint:CGPointMake(width, radius)];
	[aPath addArcWithCenter:(CGPoint){width - radius, radius} radius:radius startAngle:DEGREES_TO_RADIANS(0) endAngle:DEGREES_TO_RADIANS(270) clockwise:NO];
	[aPath addLineToPoint:(CGPoint){tagLength + radius, 0.0}];
	[aPath addArcWithCenter:(CGPoint){tagLength + radius, radius} radius:radius startAngle:DEGREES_TO_RADIANS(270) endAngle:DEGREES_TO_RADIANS(230) clockwise:NO];
	[aPath addLineToPoint:(CGPoint){0.0, height / 2}];
	
	[aPath moveToPoint:(CGPoint){width, height / 2}];
	[aPath addLineToPoint:CGPointMake(width, height - radius)];
	[aPath addArcWithCenter:(CGPoint){width - radius, height - radius} radius:radius startAngle:DEGREES_TO_RADIANS(0) endAngle:DEGREES_TO_RADIANS(90) clockwise:YES];
	[aPath addLineToPoint:(CGPoint){tagLength + radius, height}];
	[aPath addArcWithCenter:(CGPoint){tagLength + radius, height - radius} radius:radius startAngle:DEGREES_TO_RADIANS(90) endAngle:DEGREES_TO_RADIANS(140) clockwise:YES];
	[aPath addLineToPoint:(CGPoint){0.0, height / 2}];
	
	[aPath closePath];
	
	[aPath addArcWithCenter:(CGPoint){tagLength / 2 + self.holeRadius, height / 2} radius:self.holeRadius startAngle:DEGREES_TO_RADIANS(0) endAngle:DEGREES_TO_RADIANS(180) clockwise:YES];
	[aPath addArcWithCenter:(CGPoint){tagLength / 2 + self.holeRadius, height / 2} radius:self.holeRadius startAngle:DEGREES_TO_RADIANS(180) endAngle:DEGREES_TO_RADIANS(0) clockwise:YES];
	
    // Set the render colors.
    [self.tagColor setFill];
	
    [aPath fill];
	
	CAShapeLayer *maskWithHole = [CAShapeLayer layer];
	[maskWithHole setPath:[aPath CGPath]];
	[maskWithHole setFillRule:kCAFillRuleEvenOdd];
	
	self.layer.mask = maskWithHole;
	
	radius = radius / 2;
	float padding = self.innerTagPadding;
	float left = padding * 2;
	UIBezierPath *background = [UIBezierPath bezierPath];
	[background moveToPoint:(CGPoint){tagLength + left + radius, padding}];
	[background addLineToPoint:(CGPoint){width - padding, padding}];
	[background addArcWithCenter:(CGPoint){width - padding - radius, padding + radius} radius:radius startAngle:DEGREES_TO_RADIANS(270) endAngle:DEGREES_TO_RADIANS(0) clockwise:YES];
	[background addLineToPoint:(CGPoint){width - padding, height - padding}];
	[background addArcWithCenter:(CGPoint){width - padding - radius, height - padding - radius} radius:radius startAngle:DEGREES_TO_RADIANS(0) endAngle:DEGREES_TO_RADIANS(90) clockwise:YES];
	[background addLineToPoint:(CGPoint){tagLength + left + radius, height - padding}];
	[background addArcWithCenter:(CGPoint){tagLength + left + radius, height - padding - radius} radius:radius startAngle:DEGREES_TO_RADIANS(90) endAngle:DEGREES_TO_RADIANS(180) clockwise:YES];
	[background addLineToPoint:(CGPoint){tagLength + left, padding + radius}];
	[background addArcWithCenter:(CGPoint){tagLength + left + radius, padding + radius} radius:radius startAngle:DEGREES_TO_RADIANS(180) endAngle:DEGREES_TO_RADIANS(270) clockwise:YES];
	[background closePath];
	
	[self.innerTagColor setFill];
    [background fill];
}

- (NSString*)tagText
{
	return self.labelText.text;
}

@end
