//
//  AMTagListView.m
//  AMTagListView
//
//  Created by Andrea Mazzini on 20/01/14.
//  Copyright (c) 2014 Fancy Pixel. All rights reserved.
//

#import "AMTagListView.h"

@interface AMTagListView ()

@property (nonatomic, copy) AMTagListViewTapHandler tapHandler;
@property (nonatomic, strong) id orientationNotification;
@property (nonatomic, strong) id tagNotification;

@end

@implementation AMTagListView

#pragma mark - Setup

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    // Default margins
    _marginX = 4;
    _marginY = 4;
    _tagAlignment = AMTagAlignmentLeft;
    _scrollDirection = AMScrollDirectionVertical;
    self.clipsToBounds = YES;
    _tags = [@[] mutableCopy];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    __weak AMTagListView *weakSelf = self;
    self.orientationNotification = [center addObserverForName:UIDeviceOrientationDidChangeNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        [weakSelf rearrangeTags];
    }];
    self.tagNotification = [center addObserverForName:AMTagViewNotification object:nil queue:nil usingBlock:^(NSNotification *notification) {
        if (weakSelf == notification.userInfo[@"superview"]) {
            if (weakSelf.tapHandler) {
                weakSelf.tapHandler(notification.object);
            }
        }
    }];
}

- (void)setTapHandler:(AMTagListViewTapHandler)tapHandler {
    _tapHandler = tapHandler;
}

#pragma mark - Tag insertion

- (AMTagView *)addTag:(NSString *)text {
    return [self addTag:text andRearrange:YES];
}

- (AMTagView *)addTag:(NSString *)text withUserInfo:(NSDictionary *)userInfo {
    return [self addTag:text andRearrange:YES withUserInfo:userInfo];
}

- (AMTagView *)addTag:(NSString *)text andRearrange:(BOOL)rearrange {
    return [self addTag:text andRearrange:rearrange withUserInfo:nil];
}

- (AMTagView *)addTag:(NSString *)text andRearrange:(BOOL)rearrange withUserInfo:(NSDictionary *)userInfo {
    AMTagView* tagView = [[AMTagView alloc] initWithFrame:CGRectZero];
    [tagView setupWithText:text];
    tagView.userInfo = userInfo;

    CGRect frame = tagView.frame;
    frame.size.width = MIN(frame.size.width, self.frame.size.width - self.marginX * 2);
    tagView.frame = frame;

    [self.tags addObject:tagView];

    if (rearrange) {
        [self rearrangeTags];
    }

    if ([self.tagListDelegate respondsToSelector:@selector(tagList:shouldAddTagWithText:resultingContentSize:)]) {
        if (![self.tagListDelegate tagList:self shouldAddTagWithText:tagView.tagText resultingContentSize:self.contentSize]) {
            [self removeTag:tagView];
            return nil;
        }
    }

    return tagView;
}

- (UIView<AMTag> *)addTagView:(UIView<AMTag> *)tagView {
    [self addTagView:tagView andRearrange:YES];
    return tagView;
}

- (UIView<AMTag> *)addTagView:(UIView<AMTag> *)tagView andRearrange:(BOOL)rearrange {
    if ([tagView isKindOfClass:[AMTagView class]]) {
        UIFont *font = [[[tagView class] appearance] textFont];
        CGSize size = [((AMTagView *)tagView).tagText sizeWithAttributes:@{NSFontAttributeName: font}];
        CGPoint padding = [[[tagView class] appearance] textPadding];
        float tagLength = [[[tagView class] appearance] tagLength];
        size.width = (int)size.width + padding.x * 2 + tagLength;
        size.height = (int)size.height + padding.y;
        size.width = MIN(size.width, self.frame.size.width - self.marginX * 2);
        tagView.frame = (CGRect){{0, 0}, {size.width, size.height}};
    }
    
    [self.tags addObject:tagView];

    if (rearrange) {
        [self rearrangeTags];
    }

    if ([self.tagListDelegate respondsToSelector:@selector(tagList:shouldAddTagWithText:resultingContentSize:)]) {
        if (![self.tagListDelegate tagList:self shouldAddTagWithText:tagView.tagText resultingContentSize:self.contentSize]) {
            [self removeTag:tagView];
            return nil;
        }
    }

    return tagView;
}

- (void)addTags:(NSArray *)array {
    [self addTags:array andRearrange:YES];
}

- (void)addTags:(NSArray *)array andRearrange:(BOOL)rearrange {
    NSMutableArray *tags = [@[] mutableCopy];
    for (NSString* text in array) {
        AMTagView *tag = [self addTag:text andRearrange:rearrange];
        if (tag) {
            [tags addObject:tag];
        }
    }

    if ([self.tagListDelegate respondsToSelector:@selector(tagList:shouldAddTagWithText:resultingContentSize:)]) {
        if (![self.tagListDelegate tagList:self shouldAddTagsWithText:array resultingContentSize:self.contentSize]) {
            for (AMTagView *tag in tags) {
                [self removeTag:tag];
            }
        }
    }
}

#pragma mark - Tag removal

- (void)removeTag:(UIView<AMTag> *)view {
    [view removeFromSuperview];
    [self.tags removeObject:view];
    if ([self.tagListDelegate respondsToSelector:@selector(tagList:didRemoveTag:)]) {
        [self.tagListDelegate tagList:self didRemoveTag:view];
    }
    [self rearrangeTags];
}

- (void)removeAllTags {
    for (AMTagView *tag in self.tags) {
        [tag removeFromSuperview];
    }
    [self.tags removeAllObjects];
    [self rearrangeTags];
}

#pragma mark - Service

- (void)rearrangeTags {
    [self.subviews enumerateObjectsUsingBlock:^(UIView* obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
    __block float maxY = 0;
    __block float maxX = 0;
    __block CGSize size = CGSizeZero;
    for (AMTagView *obj in self.tags) {
        size = obj.frame.size;

        if (self.scrollDirection == AMScrollDirectionVertical) {
            [self.subviews enumerateObjectsUsingBlock:^(UIView* view, NSUInteger idx, BOOL *stop) {
                if ([view isKindOfClass:[AMTagView class]]) {
                    maxY = MAX(maxY, view.frame.origin.y);
                }
            }];
        }
        
        [self.subviews enumerateObjectsUsingBlock:^(UIView* view, NSUInteger idx, BOOL *stop) {
            if ([view isKindOfClass:[AMTagView class]]) {
                if (self.scrollDirection == AMScrollDirectionHorizontal || view.frame.origin.y == maxY) {
                    maxX = MAX(maxX, view.frame.origin.x + view.frame.size.width);
                }
            }
        }];

        // Go to a new line if the tag won't fit
        if (self.scrollDirection == AMScrollDirectionVertical) {
            if (size.width + maxX > (self.frame.size.width - self.marginX)) {
                maxY += size.height + self.marginY;
                maxX = 0;
            }
            obj.frame = CGRectMake(maxX + self.marginX, maxY, size.width, size.height);
        } else {
            obj.frame = CGRectMake(maxX + self.marginX, self.marginY, size.width, size.height);
        }
        [self addSubview:obj];
    };

    if (self.tagAlignment == AMTagAlignmentRight) {
        for (AMTagView *obj in self.tags) {
            obj.frame = CGRectMake(self.frame.size.width - obj.frame.origin.x - obj.frame.size.width, obj.frame.origin.y, obj.frame.size.width, obj.frame.size.height);
        }
    }
    
    if (self.scrollDirection == AMScrollDirectionHorizontal) {
        // calculate the real maxX:
        maxX = 0;
        for (AMTagView *obj in self.tags) {
            size = obj.frame.size;
            maxX = MAX(maxX, obj.frame.origin.x + obj.frame.size.width);
        }
        
        
        [self setContentSize:CGSizeMake(maxX + self.marginX, self.frame.size.height)];
    } else {
        [self setContentSize:CGSizeMake(self.frame.size.width, maxY + size.height + self.marginY)];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self rearrangeTags];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:_tagNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:_orientationNotification];
}

@end
