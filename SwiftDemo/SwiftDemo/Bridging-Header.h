//
//  Bridging-Header.h
//  SwiftDemo
//
//  Created by Andrea Mazzini on 31/10/14.
//  Copyright (c) 2014 Fancy Pixel. All rights reserved.
//

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#import <AMTagListView.h>