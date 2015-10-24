#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <FBSnapshotTestCase/FBSnapshotTestCase.h>
#import <Expecta+Snapshots/EXPMatchers+FBSnapshotTest.h>
#import <OCMock/OCMock.h>
#import "AMTagView.h"
#import "AMTagListView.h"

#define kRECORDING NO

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
    it(@"and it looks right", ^{
        [[AMTagView appearance] setRadius:1];
        [[AMTagView appearance] setTagLength:20];
        [[AMTagView appearance] setInnerTagPadding:6];
        [[AMTagView appearance] setHoleRadius:3];
        [[AMTagView appearance] setTextPadding:CGPointMake(15, 15)];
        [[AMTagView appearance] setTextFont:[UIFont fontWithName:@"MarkerFelt-Wide" size:[UIFont systemFontSize]]];
        [[AMTagView appearance] setTextColor:[UIColor whiteColor]];
        [[AMTagView appearance] setTagColor:[UIColor darkGrayColor]];
        [[AMTagView appearance] setInnerTagColor:[UIColor lightGrayColor]];

        subject = [[AMTagView alloc] initWithFrame:CGRectMake(0, 0, 120, 60)];
        [subject setupWithText:@"I love cheese"];
        if (kRECORDING) {
            expect(subject).to.recordSnapshot();
        } else {
            expect(subject).to.haveValidSnapshot();
        }
    });

    it(@"can specify vertical and horizontal padding separately", ^{
        [[AMTagView appearance] setTextPadding:CGPointMake(1, 10)];
        
        subject = [[AMTagView alloc] initWithFrame:CGRectMake(0, 0, 120, 60)];
        [subject setupWithText:@"I love cheese"];
        if (kRECORDING) {
            expect(subject).to.recordSnapshot();
        } else {
            expect(subject).to.haveValidSnapshot();
        }
    });
    
    it(@"updates the text color properly", ^{
        subject = [[AMTagView alloc] initWithFrame:CGRectMake(0, 0, 120, 60)];
        [subject setupWithText:@"I love cheese"];
        if (kRECORDING) {
            expect(subject).to.recordSnapshotNamed(@"can_be_customised_via_UIAppearance_updates_the_text_color_properly_before");
        } else {
            expect(subject).to.haveValidSnapshotNamed(@"can_be_customised_via_UIAppearance_updates_the_text_color_properly_before");
        }
        [subject setTextColor:[UIColor redColor]];
        if (kRECORDING) {
            expect(subject).to.recordSnapshotNamed(@"can_be_customised_via_UIAppearance_updates_the_text_color_properly_after");
        } else {
            expect(subject).to.haveValidSnapshotNamed(@"can_be_customised_via_UIAppearance_updates_the_text_color_properly_after");
        }
    });
});

SpecEnd
