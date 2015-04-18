#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <FBSnapshotTestCase/FBSnapshotTestCase.h>
#import <Expecta+Snapshots/EXPMatchers+FBSnapshotTest.h>
#import <OCMock/OCMock.h>

#import "AMTagListView.h"

SpecBegin(AMTagListView)

describe(@"delegate callbacks", ^{
    it(@"should tell a delegate its getting a callback", ^{

    });
});

describe(@"notifications", ^{
    it(@"rearranges when UIDeviceOrientationDidChangeNotification is called", ^{
        AMTagListView *subject = [[AMTagListView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
        id mock = OCMPartialMock(subject);
        OCMExpect([mock rearrangeTags]);

        [[NSNotificationCenter defaultCenter] postNotificationName:UIDeviceOrientationDidChangeNotification object:nil];
        OCMVerifyAll(mock);
    });

    it(@"calls the tap handler when a AMTagViewNotification is sent", ^{
        
    });

});

describe(@"adding tags", ^{
    it(@"adds tags and rearranges", ^{

    });

    it(@"can add tags and not rearrange", ^{

    });

    it(@"can take its own tag view", ^{

    });
});

describe(@"visuals", ^{
    it(@"looks right by default", ^{

    });

    it(@"support UIAppearance changes", ^{

    });
});

SpecEnd