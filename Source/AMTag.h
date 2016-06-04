//
//  AMTag.h
//  TagListViewDemo
//
//  Created by Andrea Mazzini on 04/06/16.
//  Copyright © 2016 Andrea Mazzini. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AMTag

- (void)setUserInfo:(NSDictionary *)userInfo;
- (NSDictionary *)userInfo;
- (NSString *)tagText;

@end
