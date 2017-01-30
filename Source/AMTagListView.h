//
//  AMTagListView.h
//  AMTagListView
//
//  Created by Andrea Mazzini on 20/01/14.
//  Copyright (c) 2014 Fancy Pixel. All rights reserved.
//

@import UIKit;
#import "AMTagView.h"
#import "AMTag.h"

@class AMTagView;
@class AMTagListView;

/** @enum AMTagAlignment
 *
 * Enum that specifies the alignment of the tags inside the list
 */
typedef NS_ENUM(NSInteger, AMTagAlignment) {
    /** Align from left to right */
    AMTagAlignmentLeft,
    /** Align from right to left */
    AMTagAlignmentRight
};

/** @enum AMScrollDirection
 *
 * Enum that specifies the scroll direction of the view
 */
typedef NS_ENUM(NSInteger, AMScrollDirection) {
    /** vertical */
    AMScrollDirectionVertical,
    /** horizontal */
    AMScrollDirectionHorizontal
};



/**-----------------------------------------------------------------------------
 * @name AMTagListDelegate
 * -----------------------------------------------------------------------------
 */
@protocol AMTagListDelegate <NSObject>

@optional

/** Should add a new tag with text
 *
 * Determines if the list should add a new tag given its text and resulting size
 *
 * @param tagListView The tag list view
 * @param text The tag's text
 * @param size The resulting content size
 */
- (BOOL)tagList:(AMTagListView *)tagListView shouldAddTagWithText:(NSString *)text resultingContentSize:(CGSize)size;

/** Should add a new tags with text
 *
 * Determines if the list should add a batch of new tags given the resulting content size
 *
 * @param tagListView The tag list view
 * @param text The tag's text
 * @param size The resulting content size
 */
- (BOOL)tagList:(AMTagListView *)tagListView shouldAddTagsWithText:(NSArray *)tags resultingContentSize:(CGSize)size;

/** Did remove a tag
 *
 * Called when a tag is removed
 *
 * @param tagListView The tag list view
 * @param tag The tag that will be removed
 */
- (void)tagList:(AMTagListView *)tagListView didRemoveTag:(UIView<AMTag> *)tag;

@end

typedef void (^AMTagListViewTapHandler)(AMTagView*);

@interface AMTagListView : UIScrollView

/**-----------------------------------------------------------------------------
 * @name AMTagListView
 * -----------------------------------------------------------------------------
 */

/** Add a new tag
 *
 * Adds a new tag to the scroll view.
 *
 * @param text The text that the tag will display
 * @returns AMTagView
 */
- (AMTagView *)addTag:(NSString *)text;

/** Add a new tag
 *
 * Adds a new tag to the scroll view.
 *
 * @param text The text that the tag will display
 * @param userInfo Data the client wishes to store with this tag
 * @returns AMTagView
 */
 - (AMTagView *)addTag:(NSString *)text withUserInfo:(NSDictionary *)userInfo;

/** Add a new tag
 *
 * Adds a new tag to the scroll view.
 * You can choose to avoid rearranging the tags when adding a big batch of tags. Remember to
 * call the rearrangeTags method if you do so.
 *
 * @param text The text that the tag will display
 * @returns AMTagView
 */
- (AMTagView *)addTag:(NSString *)text andRearrange:(BOOL)rearrange;

/** Add a multiple tags
 *
 * Adds multiple tags to the scroll view.
 *
 * @param array An array of strings
 */
- (void)addTags:(NSArray *)array;

/** Add a multiple tags
 *
 * Adds multiple tags to the scroll view.
 * You can choose to avoid rearranging the tags when adding a big batch of tags. Remember to
 * call the rearrangeTags method if you do so.
 *
 * @param array An array of strings
 */
- (void)addTags:(NSArray *)array andRearrange:(BOOL)rearrange;

/** Add a specific tag to the tag list
 *
 * @param tagView An UIView instance conforming to `AMTag`
 * @returns UIView<AMTag>
 */
- (UIView<AMTag> *)addTagView:(UIView<AMTag> *)tagView;

/** Add a specific tag to the tag list
 *
 * You can choose to avoid rearranging the tags when adding a big batch of tags. Remember to
 * call the rearrangeTags method if you do so.
 *
 * @param tagView An UIView instance conforming to `AMTag`
 * @returns UIView<AMTag>
 */
- (UIView<AMTag> *)addTagView:(UIView<AMTag> *)tagView andRearrange:(BOOL)rearrange;

/** Remove a tag
 *
 * Removes a given tag.
 *
 * @param view A AMTagView instance
 */
- (void)removeTag:(UIView<AMTag> *)view;

/** Remove all tags
 *
 * Removes all tags from the tag view.
 */
- (void)removeAllTags;

/** Set a tap handler for the tags
 *
 * Sets a tap block that will be fired on each tap on a tag
 *
 * @param tapHandler The handler block
 */
- (void)setTapHandler:(AMTagListViewTapHandler)tapHandler;

/** Rearrange the tags
 *
 * Manually rearrange all the tags in the view
 */
- (void)rearrangeTags;

/**-----------------------------------------------------------------------------
 * @name AMScrollingNavbarViewController Properties
 * -----------------------------------------------------------------------------
 */

/** Horizontal margin
 *
 * Holds the horizontal inner margin of the view.
 */
@property (nonatomic, assign) float marginX;

/** Vertical margin
 *
 * Holds the vertical inner margin of the view.
 */
@property (nonatomic, assign) float marginY;

/** Tags list
 *
 * An array holding the current tag view objects
 */
@property (nonatomic, strong, readonly) NSMutableArray<UIView<AMTag> *> *tags;

/** Tag list delegate
 *
 * The tag list view's delegate
 */
@property (nonatomic, assign) id<AMTagListDelegate> tagListDelegate;

/** Tag list alignment
 *
 * The tag list alignment. The tags can be aligned to the left or the right.
 */
@property (nonatomic, assign) AMTagAlignment tagAlignment;

/** Scroll direction
 *
 * The direction in which the view scrolls (horizontal or vertical)
 */
@property (nonatomic, assign) AMScrollDirection scrollDirection;

@end
