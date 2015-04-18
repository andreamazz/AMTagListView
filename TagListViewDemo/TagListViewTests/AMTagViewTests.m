#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <FBSnapshotTestCase/FBSnapshotTestCase.h>
#import <Expecta+Snapshots/EXPMatchers+FBSnapshotTest.h>
#import <OCMock/OCMock.h>
#import "AMTagView.h"
#import "AMTagListView.h"

SpecBegin(AMTagView)

__block AMTagView *subject;

before(^{
    subject = [[AMTagView alloc] initWithFrame:CGRectMake(0, 0, 120, 60)];
});


it(@"send a notification when tapped", ^{
    AMTagListView *parent = [[AMTagListView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    [parent addSubview:subject];

    UIButton *button = nil;
    for(UIView *view in subject.subviews) {
        if ([view isKindOfClass:UIButton.class]) {
            button = (UIButton *)view;
            break;
        }
    }

    expect(button).toNot.beNil();

    id observerMock = OCMObserverMock();
    [[NSNotificationCenter defaultCenter] addMockObserver:observerMock name:AMTagViewNotification object:nil];
    [[observerMock expect] notificationWithName:AMTagViewNotification object:[OCMArg any] userInfo:[OCMArg any]];

    [button sendActionsForControlEvents:UIControlEventTouchUpInside];

    OCMVerifyAll(observerMock);
});

it(@"gets the right tag text when setup with text", ^{
    expect(subject.tagText).notTo.equal(@"Hi Mom!");
    [subject setupWithText:@"Hi Mom!"];
    expect(subject.tagText).to.equal(@"Hi Mom!");
});

describe(@"can be customised via UIAppearance", ^{

});




SpecEnd
