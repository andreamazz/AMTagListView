#AMTagListView

[![Build Status](https://travis-ci.org/andreamazz/AMTagListView.png)](https://travis-ci.org/andreamazz/AMTagListView)
[![Cocoapods](https://cocoapod-badges.herokuapp.com/v/AMTagListView/badge.png)](http://cocoapods.org/?q=amtaglistview)

UIScrollView subclass that allows to add a list of highly customizable tags. You can customize colors, border radius, and the tail of the tag. Tags can be added in bulk or dinamically one by one. The newly inserted tag will automatically arrange itself inside the scrollview.

##Screenshot

![AMTagListView](https://raw.githubusercontent.com/andreamazz/AMTagListView/master/screenshot.gif)

##Setup with Cocoapods

* Add ```pod 'AMTagListView'``` to your Podfile
* Run ```pod install```
* Run ```open App.xcworkspace```
* Import ```AMTagListView.h``` in your controller
* Create a new AMTagListView with Storyboards or via code.

##Usage
```objc
// Init 
AMTagListView *tagListView = [[AMTagListView alloc] initWithFrame:frame];
[self.view addSubview:tagListView];

// Add one tag
[self.tagListView addTag:@"my tag"];

// Add multiple tags
[self.tagListView addTags:@[@"my tag", @"some tag"]];
```

##Arranging tags
The tags are rearranged when you use the method calls listed above. You can also avoid the auto-rearrange by using the `andRearrange:` versions of such methods. This is useful when adding a big batch of tags. When you do so you must force the rearrange action manually:
```
[self.tagListView rearrangeTags];
```

##Appearance
Use the AMTagView's UIAppearance selectors to customize its appearance:
```objc
// Tag's corner radius
[[AMTagView appearance] setRadius:float]

// Tail's length
[[AMTagView appearance] setTagLength:float]

// Inner padding of the tag label
[[AMTagView appearance] setInnerTagPadding:float]

// Radius of the hole punched in the tail
[[AMTagView appearance] setHoleRadius:float]

// Text padding
[[AMTagView appearance] setTextPadding:float]

// Text font
[[AMTagView appearance] setTextFont:UIFont]

// The text color
[[AMTagView appearance] setTextColor:UIColor]

// Tag main color
[[AMTagView appearance] setTagColor:UIColor]

// Tag label background color
[[AMTagView appearance] setInnerTagColor:UIColor]
```

##Test

To run the test suite, launch `pod install` inside the `Tests` folder, and run the rake task in the root.

##Using this library?

Please let me know! I'll be glad to link your project here.



#MIT License

	Copyright (c) 2014 Andrea Mazzini. All rights reserved.

	Permission is hereby granted, free of charge, to any person obtaining a
	copy of this software and associated documentation files (the "Software"),
	to deal in the Software without restriction, including
	without limitation the rights to use, copy, modify, merge, publish,
	distribute, sublicense, and/or sell copies of the Software, and to
	permit persons to whom the Software is furnished to do so, subject to
	the following conditions:

	The above copyright notice and this permission notice shall be included
	in all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
	OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
	MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
	IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
	CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
	TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
	SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
	
[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/andreamazz/amtaglistview/trend.png)](https://bitdeli.com/free "Bitdeli Badge")
