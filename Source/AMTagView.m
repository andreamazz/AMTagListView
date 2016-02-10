//
//  AMTagView.m
//  AMTagListView
//
//  Created by Andrea Mazzini on 20/01/14.
//  Copyright (c) 2014 Fancy Pixel. All rights reserved.
//

#import "AMTagView.h"

#define DEGREES_TO_RADIANS(degrees)  ((3.14159265359 * degrees)/ 180)

#define kDefaultInnerPadding	3
#define kDefaultHoleRadius		4
#define kDefaultTagLength		10
#define kDefaultTextPadding		CGPointMake(10, 10)
#define kDefaultRadius			8
#define kDefaultTextColor		[UIColor whiteColor]
#define kDefaultFont			[UIFont systemFontOfSize:14]
#define kDefaultTagColor		[UIColor redColor]
#define kDefaultInnerTagColor	[UIColor colorWithWhite:1 alpha:0.3]
#define kDefaultImagePadding	3

NSString * const AMTagViewNotification = @"AMTagViewNotification";

@interface AMTagView ()

@property (nonatomic, strong) UILabel *labelText;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) NSMutableArray *imageViews;
@property (nonatomic, strong) UIView *divider;

@end

@implementation AMTagView

#pragma mark - NSObject

+ (void)initialize {
    [[self appearance] setRadius:kDefaultRadius];
    [[self appearance] setTagLength:kDefaultTagLength];
    [[self appearance] setHoleRadius:kDefaultHoleRadius];
    [[self appearance] setInnerTagPadding:kDefaultInnerPadding];
    [[self appearance] setTextPadding:kDefaultTextPadding];
    [[self appearance] setTextFont:kDefaultFont];
    [[self appearance] setTextColor:kDefaultTextColor];
    [[self appearance] setTagColor:kDefaultTagColor];
    [[self appearance] setDividerColor:kDefaultTagColor];
    [[self appearance] setInnerTagColor:kDefaultInnerTagColor];
    [[self appearance] setImagePadding:kDefaultImagePadding];
}

#pragma mark - UIResponder

- (BOOL)canBecomeFirstResponder {
    return YES;
}

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        self.labelText = [[UILabel alloc] init];
        self.button = [[UIButton alloc] init];
        self.imageViews = [[NSMutableArray alloc] init];
        self.labelText.textAlignment = NSTextAlignmentCenter;
        _radius = [[[self class] appearance] radius];
        _tagLength = [[[self class] appearance] tagLength];
        _holeRadius = [[[self class] appearance] holeRadius];
        _innerTagPadding = [[[self class] appearance] innerTagPadding];
        _textPadding = [[[self class] appearance] textPadding];
        _textFont = [[[self class] appearance] textFont];
        _textColor = [[[self class] appearance] textColor];
        _tagColor = [[[self class] appearance] tagColor];
        _dividerColor = [[[self class] appearance] dividerColor];
        _innerTagColor = [[[self class] appearance] innerTagColor];
        _imagePadding = [[[self class] appearance] imagePadding];
        [self.button addTarget:self action:@selector(actionButton:) forControlEvents:UIControlEventTouchUpInside];
        self.divider = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat leftMargin = (int)(self.innerTagPadding + self.tagLength + (self.tagLength ? self.radius / 2 : 0));
    CGFloat rightMargin = self.innerTagPadding + self.textPadding.x;
    
    if (self.accessoryImages) {
        for (UIImageView *imageView in self.imageViews) {
            CGRect imageRect = imageView.bounds;
            rightMargin += imageRect.size.width + self.imagePadding;
            rightMargin = ceilf(rightMargin);
            imageRect.origin.x = (int)(self.frame.size.width - rightMargin);
            imageRect.origin.y = (int)(self.frame.size.height - imageView.frame.size.height) / 2;
            imageView.frame = imageRect;
        }
    }
    
    [self.labelText.layer setCornerRadius:self.radius / 2];
    [self.labelText setFrame:CGRectMake(
        leftMargin,
        (int)(self.innerTagPadding),
        (int)(self.frame.size.width - rightMargin - leftMargin),
        (int)(self.frame.size.height - self.innerTagPadding * 2)
    )];
    
    CGRect labelFrame = self.labelText.frame;
    
    [self.divider setBackgroundColor:self.dividerColor];
    [self.divider setFrame:CGRectMake(self.labelText.frame.origin.x + self.labelText.frame.size.width , self.labelText.frame.origin.y, 0.5, self.labelText.frame.size.height)];

    CGRect buttonRect = self.labelText.frame;
    if (self.accessoryImages) {
        for (UIImageView *imageView in self.imageViews) {
            buttonRect.size.width += imageView.bounds.size.width + self.imagePadding * 2;
        }
    }

    [self.button setFrame:buttonRect];
    [self.labelText setTextColor:self.textColor];
    [self.labelText setFont:self.textFont];
}

- (void)drawRect:(CGRect)rect {
    if (self.tagLength > 0) {
        [self drawWithTagForRect:rect];
    } else {
        [self drawWithoutTagForRect:rect];
    }
}

#pragma mark - Private Interface

- (void)actionButton:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotification:[[NSNotification alloc] initWithName:AMTagViewNotification object:self userInfo:@{@"superview": self.superview}]];
}

- (void)drawWithTagForRect:(CGRect)rect {
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

- (void)drawWithoutTagForRect:(CGRect)rect {
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

- (void)setupWithText:(NSString*)text {
    
    [self addSubview:self.labelText];
    for (UIImage *image in self.accessoryImages) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.imageViews addObject:imageView];
        [self addSubview:imageView];
    }
    [self addSubview:self.button];
    if ([self.accessoryImages count] > 0) {
        [self addSubview:self.divider];
    }

    UIFont* font = self.textFont;
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName: font}];

    float innerPadding = self.innerTagPadding;
    float tagLength = self.tagLength;

    size.width = size.width + self.textPadding.x * 2 + innerPadding * 2 + tagLength;
    size.height = (int)ceilf(size.height + self.textPadding.y);
    if (self.accessoryImages) {
        for (int i = 0; i < self.accessoryImages.count; i++) {
            ((UIImageView *)self.imageViews[i]).image = self.accessoryImages[i];
            ((UIImageView *)self.imageViews[i]).tintColor = [UIColor whiteColor];
            [((UIImageView *)self.imageViews[i]) sizeToFit];
            size.width += ((UIImageView *)self.imageViews[i]).frame.size.width + self.imagePadding;
        }
    }
    size.width = (int)ceilf(size.width);

    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
    
    [self.labelText setText:text];
}

- (NSString *)tagText {
    return self.labelText.text;
}

- (void)setTagText:(NSString *)tagText {
    [self setupWithText:tagText];
}

#pragma mark - Custom setters

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    [self setNeedsLayout];
}

- (void)setTagColor:(UIColor *)tagColor {
    _tagColor = tagColor;
    [self setNeedsDisplay];
}

- (void)setDividerColor:(UIColor *)dividerColor {
    _dividerColor = dividerColor;
    [self setNeedsDisplay];
}

- (void)setInnerTagColor:(UIColor *)innerTagColor {
    _innerTagColor = innerTagColor;
    [self setNeedsDisplay];
}

@end
