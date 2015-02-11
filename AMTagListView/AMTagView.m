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
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation AMTagView

#pragma mark - NSObject

+ (void)initialize
{
    [[AMTagView appearance] setRadius:kDefaultRadius];
    [[AMTagView appearance] setTagLength:kDefaultTagLength];
    [[AMTagView appearance] setHoleRadius:kDefaultHoleRadius];
    [[AMTagView appearance] setInnerTagPadding:kDefaultInnerPadding];
    [[AMTagView appearance] setTextPadding:kDefaultTextPadding];
    [[AMTagView appearance] setTextFont:kDefaultFont];
    [[AMTagView appearance] setTextColor:kDefaultTextColor];
    [[AMTagView appearance] setTagColor:kDefaultTagColor];
    [[AMTagView appearance] setInnerTagColor:kDefaultInnerTagColor];
    [[AMTagView appearance] setAccessoryImage:nil];
    [[AMTagView appearance] setImagePadding:kDefaultImagePadding];
}

#pragma mark - UIResponder

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        self.labelText = [[UILabel alloc] init];
        self.button = [[UIButton alloc] init];
        self.imageView = [[UIImageView alloc] init];
        self.labelText.textAlignment = NSTextAlignmentCenter;
        _radius = [[AMTagView appearance] radius];
        _tagLength = [[AMTagView appearance] tagLength];
        _holeRadius = [[AMTagView appearance] holeRadius];
        _innerTagPadding = [[AMTagView appearance] innerTagPadding];
        _textPadding = [[AMTagView appearance] textPadding];
        _textFont = [[AMTagView appearance] textFont];
        _textColor = [[AMTagView appearance] textColor];
        _tagColor = [[AMTagView appearance] tagColor];
        _innerTagColor = [[AMTagView appearance] innerTagColor];
        _accessoryImage = [[AMTagView appearance] accessoryImage];
        _imagePadding = [[AMTagView appearance] imagePadding];
        [self addSubview:self.labelText];
        [self addSubview:self.imageView];
        [self addSubview:self.button];
        [self.button addTarget:self action:@selector(actionButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat leftMargin = (int)(self.innerTagPadding + self.tagLength + (self.tagLength ? self.radius / 2 : 0));
    CGFloat rightMargin = self.innerTagPadding;
    CGRect buttonRect = self.labelText.frame;
    
    if (self.accessoryImage) {
        CGRect imageRect = self.imageView.bounds;
        rightMargin = (int)ceilf(rightMargin + imageRect.size.width + self.imagePadding);
        imageRect.origin.x = (int)(self.frame.size.width - rightMargin);
        imageRect.origin.y = (int)(self.frame.size.height - self.imageView.frame.size.height) / 2;
        self.imageView.frame = imageRect;
        buttonRect.size.width = buttonRect.size.width + imageRect.size.width + self.imagePadding * 2;
    }
    
    [self.labelText.layer setCornerRadius:self.radius / 2];
    [self.labelText setFrame:(CGRect){
        leftMargin,
        (int)(self.innerTagPadding),
        (int)(self.frame.size.width - rightMargin - leftMargin),
        (int)(self.frame.size.height - self.innerTagPadding * 2)
    }];
    
    [self.button setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self.labelText setTextColor:self.textColor];
    [self.labelText setFont:self.textFont];
}

- (void)drawRect:(CGRect)rect
{
    if (self.tagLength > 0) {
        [self drawWithTagForRect:rect];
    } else {
        [self drawWithoutTagForRect:rect];
    }
}

#pragma mark - Private Interface

- (void)actionButton:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotification:[[NSNotification alloc] initWithName:AMTagViewNotification object:self userInfo:@{@"superview": self.superview}]];
}

- (void)drawWithTagForRect:(CGRect)rect
{
    float padding = self.innerTagPadding;
    float tagLength = self.tagLength;
    float height = rect.size.height;
    float width = rect.size.width;
    float radius = self.radius;
    
    if (padding > 0) {
        UIBezierPath *aPath = [UIBezierPath bezierPath];
        
        [aPath moveToPoint:(CGPoint){width, height / 2}];
        [aPath addLineToPoint:CGPointMake(width, radius)];
        [aPath addArcWithCenter:(CGPoint){width - radius, radius} radius:radius startAngle:DEGREES_TO_RADIANS(0) endAngle:DEGREES_TO_RADIANS(270) clockwise:NO];
        [aPath addLineToPoint:(CGPoint){tagLength + radius, 0.0}];
        [aPath addArcWithCenter:(CGPoint){tagLength + radius, radius} radius:radius startAngle:DEGREES_TO_RADIANS(270) endAngle:DEGREES_TO_RADIANS(230) clockwise:NO];
        [aPath addLineToPoint:(CGPoint){0.0, height / 2}];
        
        [aPath moveToPoint:(CGPoint){tagLength / 2, height / 2}];
        [aPath addArcWithCenter:(CGPoint){tagLength / 2 + self.holeRadius, height / 2} radius:self.holeRadius startAngle:DEGREES_TO_RADIANS(180) endAngle:DEGREES_TO_RADIANS(0) clockwise:YES];
        
        UIBezierPath *p2 = [UIBezierPath bezierPathWithCGPath:aPath.CGPath];
        [p2 applyTransform:CGAffineTransformMakeScale(1, -1)];
        [p2 applyTransform:CGAffineTransformMakeTranslation(0, height)];
        [aPath appendPath:p2];
        
        // Set the render colors.
        [self.tagColor setFill];
        
        [aPath fill];
    }
    
    radius -= padding;
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

- (void)drawWithoutTagForRect:(CGRect)rect
{
    if (self.innerTagPadding > 0) {
        UIBezierPath* backgroundPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:self.radius];
        [self.tagColor setFill];
        [backgroundPath fill];
    }
    
    CGRect inset = CGRectInset(rect, self.innerTagPadding, self.innerTagPadding);
    UIBezierPath* insidePath = [UIBezierPath bezierPathWithRoundedRect:inset cornerRadius:self.radius - self.innerTagPadding];
    [self.innerTagColor setFill];
    [insidePath fill];
}

#pragma mark - Public Interface

- (void)setTagColor:(UIColor *)tagColor
{
    _tagColor = tagColor;
    [self setNeedsDisplay];
}

- (void)setInnerTagColor:(UIColor *)innerTagColor
{
    _innerTagColor = innerTagColor;
    [self setNeedsDisplay];
}

- (void)setupWithText:(NSString*)text
{
    UIFont* font = self.textFont;
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName: font}];
    
    float innerPadding = self.innerTagPadding;
    float padding = self.textPadding;
    float tagLength = self.tagLength;
    
    size.width = (int)size.width + padding * 2 + innerPadding * 2 + tagLength;
    if (self.accessoryImage) {
        self.imageView.image = self.accessoryImage;
        [self.imageView sizeToFit];
        size.width += self.imageView.frame.size.width + self.imagePadding;
    }
    size.height = (int)size.height + padding;
    
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
    
    [self.labelText setText:text];
}

- (NSString*)tagText
{
    return self.labelText.text;
}

@end
