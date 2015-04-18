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
    after(^{
        [[AMTagView appearance] setRadius:kDefaultRadius];
        [[AMTagView appearance] setTagLength:kDefaultTagLength];
        [[AMTagView appearance] setInnerTagPadding:kDefaultInnerPadding];
        [[AMTagView appearance] setHoleRadius:kDefaultHoleRadius];
        [[AMTagView appearance] setTextPadding:kDefaultTextPadding];
        [[AMTagView appearance] setTextFont:kDefaultFont];
        [[AMTagView appearance] setTextColor:kDefaultTextColor];
        [[AMTagView appearance] setTagColor:kDefaultTagColor];
        [[AMTagView appearance] setInnerTagColor:kDefaultInnerTagColor];
    });

    it(@"and it looks right", ^{
        [[AMTagView appearance] setRadius:1];
        [[AMTagView appearance] setTagLength:20];
        [[AMTagView appearance] setInnerTagPadding:6];
        [[AMTagView appearance] setHoleRadius:3];
        [[AMTagView appearance] setTextPadding:15];
        [[AMTagView appearance] setTextFont:[UIFont fontWithName:@"MarkerFelt-Wide" size:[UIFont systemFontSize]]];
        [[AMTagView appearance] setTextColor:[UIColor whiteColor]];
        [[AMTagView appearance] setTagColor:[UIColor darkGrayColor]];
        [[AMTagView appearance] setInnerTagColor:[UIColor lightGrayColor]];

        subject = [[AMTagView alloc] initWithFrame:CGRectMake(0, 0, 120, 60)];
        [subject setupWithText:@"I love cheese"];
        expect(subject).to.haveValidSnapshot();
    });
});




SpecEnd
