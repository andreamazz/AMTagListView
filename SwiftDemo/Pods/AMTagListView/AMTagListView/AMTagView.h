//
//  AMTagView.h
//  AMTagListView
//
//  Created by Andrea Mazzini on 20/01/14.
//  Copyright (c) 2014 Fancy Pixel. All rights reserved.
//

#define DEGREES_TO_RADIANS(degrees)  ((3.14159265359 * degrees)/ 180)

#define kDefaultInnerPadding	3
#define kDefaultHoleRadius		4
#define kDefaultTagLength		10
#define kDefaultTextPadding		10
#define kDefaultRadius			8
#define kDefaultTextColor		[UIColor whiteColor]
#define kDefaultFont			[UIFont systemFontOfSize:14]
#define kDefaultTagColor		[UIColor redColor]
#define kDefaultInnerTagColor	[UIColor colorWithWhite:1 alpha:0.3]

extern NSString * const AMTagViewNotification;

@interface AMTagView : UIView

@property (nonatomic, assign) float		radius UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) float		tagLength UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) float		innerTagPadding UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) float		holeRadius UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) float		textPadding UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont	*textFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor	*textColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor	*tagColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor	*innerTagColor UI_APPEARANCE_SELECTOR;

- (void)setupWithText:(NSString*)text;
- (NSString*)tagText;

@end
