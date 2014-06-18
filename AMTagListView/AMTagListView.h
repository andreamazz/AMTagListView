//
//  AMTagListView.h
//  AMTagListView
//
//  Created by Andrea Mazzini on 20/01/14.
//  Copyright (c) 2014 Fancy Pixel. All rights reserved.
//

#import "AMTagView.h"

@class AMTagView;

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
 */
- (void)addTag:(NSString*)text;

- (void)addTagIndex:(NSInteger)index;

- (void)addTags:(NSArray*)array setIndexs:(NSArray *)indexs;

/** Add a multiple tags
 *
 * Adds multiple tags to the scroll view.
 *
 * @param array An array of strings
 */
- (void)addTags:(NSArray*)array;

/** Add a specific tag to the tag scroll view
 *
 * @param tagView An AMTagView instance
 *
 */
- (void)addTagView:(AMTagView *)tagView;

/** Remove a tag
 *
 * Removes a given tag.
 *
 * @param view A AMTagView instance
 */
- (void)removeTag:(AMTagView*)view;

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
@property (nonatomic, strong, readonly) NSMutableArray* tags;


@end
