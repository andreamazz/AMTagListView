//
//  AMTagListView.h
//  AMTagListView
//
//  Created by Andrea Mazzini on 20/01/14.
//  Copyright (c) 2014 Fancy Pixel. All rights reserved.
//

#import "AMTagView.h"

@interface AMTagListView : UIScrollView

@property (nonatomic, assign) float marginX;
@property (nonatomic, assign) float marginY;

- (void)addTag:(NSString*)text;
- (void)addTags:(NSArray*)array;

@end
