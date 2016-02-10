//
//  AMTagView.h
//  AMTagListView
//
//  Created by Andrea Mazzini on 20/01/14.
//  Copyright (c) 2014 Fancy Pixel. All rights reserved.
//

@import UIKit;

/** Constant for the tag notification */
extern NSString * const AMTagViewNotification;

/**-----------------------------------------------------------------------------
 * @name AMTagView
 * -----------------------------------------------------------------------------
 */
@interface AMTagView : UIView

/** Radius
 *
 * The tag's corner radius
 */
@property (nonatomic, assign) float		radius UI_APPEARANCE_SELECTOR;

/** Tag Length
 *
 * The Length of the tag's tail
 */
@property (nonatomic, assign) float		tagLength UI_APPEARANCE_SELECTOR;

/** Inner tag padding
 *
 * The padding of the tag's inner background
 */
@property (nonatomic, assign) float		innerTagPadding UI_APPEARANCE_SELECTOR;

/** Tag hole radius
 *
 * The radius of the punch-hole of the tag
 */
@property (nonatomic, assign) float		holeRadius UI_APPEARANCE_SELECTOR;

/** Text padding
 *
 * The padding (horizontal and vertical) of the text inside the tag
 */
@property (nonatomic, assign) CGPoint	textPadding UI_APPEARANCE_SELECTOR;

/** Text font
 *
 * The font of the text inside the tag
 */
@property (nonatomic, strong) UIFont	*textFont UI_APPEARANCE_SELECTOR;

/** Text color
 *
 * The color of the text inside the tag
 */
@property (nonatomic, strong) UIColor	*textColor UI_APPEARANCE_SELECTOR;

/** Tag outer background color
 *
 * The tag's inner background color
 */
@property (nonatomic, strong) UIColor	*tagColor UI_APPEARANCE_SELECTOR;

/** Tag inner background color
 *
 * The tag's outer background color
 */
@property (nonatomic, strong) UIColor	*innerTagColor UI_APPEARANCE_SELECTOR;

/** Accessory images
 *
 * An array of UIImages to be displayed inside the tag
 */
@property (nonatomic, strong) NSArray	*accessoryImages;

/** Accessory image padding
 *
 * The padding of the accessory images within the tag
 */
@property (nonatomic, assign) float     imagePadding UI_APPEARANCE_SELECTOR;

/** Accessory image divider color
 *
 * The color to divide the text from the images
 */
@property (nonatomic, strong) UIColor    *dividerColor UI_APPEARANCE_SELECTOR;


/**
 * Text displayed
 */
@property (nonatomic, weak) NSString *tagText;

/**
 * Optional client-specific data to store with/identify each tag
 */
@property (nonatomic, strong) NSDictionary *userInfo;


/** Setup a new tag
 *
 * Sets up the tag with a given string
 *
 * @param text The text to display
 */
- (void)setupWithText:(NSString *)text;

@end
