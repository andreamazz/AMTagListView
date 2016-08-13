#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <FBSnapshotTestCase/FBSnapshotTestCase.h>
#import <Expecta+Snapshots/EXPMatchers+FBSnapshotTest.h>
#import <OCMock/OCMock.h>

#import "AMTagListView.h"

#define kRECORDING NO

@interface NegativeDelegate : NSObject <AMTagListDelegate>
@end

@implementation NegativeDelegate

- (BOOL)tagList:(AMTagListView *)tagListView shouldAddTagWithText:(NSString *)text resultingContentSize:(CGSize)size {
    return NO;
}

@end

@interface DeletionDelegate : NSObject <AMTagListDelegate>
@end

@implementation DeletionDelegate

- (void)tagList:(AMTagListView *)tagListView didRemoveTag:(UIView<AMTag> *)tag {}

@end

SpecBegin(AMTagListView)

__block AMTagListView *subject;

describe(@"initWithFrame:", ^{
    it(@"should init with the default margins of 4 points", ^{
        AMTagListView *listView = [[AMTagListView alloc] initWithFrame:CGRectZero];
        expect(listView.marginX).to.equal(4);
        expect(listView.marginY).to.equal(4);
    });

    it(@"should register for orientation notifications", ^{
        AMTagListView *listView = [[AMTagListView alloc] initWithFrame:CGRectZero];
        expect([listView valueForKey:@"orientationNotification"]).toNot.beNil;
    });

    it(@"should register for tag notifications", ^{
        AMTagListView *listView = [[AMTagListView alloc] initWithFrame:CGRectZero];
        expect([listView valueForKey:@"tagNotification"]).toNot.beNil;
    });

    it(@"should init an empty tag array", ^{
        AMTagListView *listView = [[AMTagListView alloc] initWithFrame:CGRectZero];
        expect(listView.tags).to.beKindOf([NSArray class]);
        expect(listView.tags.count).to.equal(0);
    });
});

describe(@"addTag:", ^{
    __block AMTagListView *listView;
    beforeAll(^{
        listView = [[AMTagListView alloc] initWithFrame:CGRectZero];
    });

    it(@"should increase the number of tags", ^{
        [listView addTag:@"tag"];
        expect(listView.tags.count).to.equal(1);
    });

    it(@"should add a tag with the given string", ^{
        [listView addTag:@"tag"];
        expect([listView.tags[0] valueForKey:@"tagText"]).to.equal(@"tag");
    });

    it(@"should increase the view's content size height", ^{
        listView.contentSize = (CGSize){0, 0};
        [listView addTag:@"tag"];
        expect(listView.contentSize.height).to.beGreaterThan(0);
    });
});

describe(@"addTags:", ^{
    it(@"should add an array of tags", ^{
        AMTagListView *listView;
        listView = [[AMTagListView alloc] initWithFrame:CGRectZero];
        NSArray *tags = @[@"one", @"two"];
        [listView addTags:tags];
        expect(listView.tags.count).to.equal(tags.count);
    });
});

describe(@"removeTag:", ^{
    it(@"should remove a given tag", ^{
        AMTagListView *listView;
        listView = [[AMTagListView alloc] initWithFrame:CGRectZero];
        [listView addTags:@[@"one", @"two"]];
        [listView removeTag:listView.tags[0]];
        expect(listView.tags.count).to.equal(1);
        expect([listView.tags[0] valueForKey:@"tagText"]).to.equal(@"two");
    });
});

describe(@"removeAllTags", ^{
    it(@"should remove every tag", ^{
        AMTagListView *listView;
        listView = [[AMTagListView alloc] initWithFrame:CGRectZero];
        [listView addTags:@[@"one", @"two"]];
        [listView removeAllTags];
        expect(listView.tags.count).to.equal(0);
    });
});

describe(@"tagListDelegate", ^{
    it(@"should not add a tag when the delegate returns NO", ^{
        AMTagListView *listView;
        NegativeDelegate *delegate = [[NegativeDelegate alloc] init];
        listView = [[AMTagListView alloc] initWithFrame:CGRectZero];
        listView.tagListDelegate = delegate;
        [listView addTag:@"tag"];
        expect(listView.tags.count).to.equal(0);
    });

    it(@"should be called when a tag is removed", ^{
        AMTagListView *listView;
        DeletionDelegate *delegate = [[DeletionDelegate alloc] init];
        listView = [[AMTagListView alloc] initWithFrame:CGRectZero];
        listView.tagListDelegate = delegate;
        AMTagView *tag = [listView addTag:@"tag"];
        id mock = OCMPartialMock(delegate);
        OCMExpect([mock tagList:listView didRemoveTag:tag]);
        [listView removeTag:tag];
        OCMVerifyAll(mock);
    });
});

describe(@"notifications", ^{
    it(@"rearranges when UIDeviceOrientationDidChangeNotification is called", ^{
        subject = [[AMTagListView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
        id mock = OCMPartialMock(subject);
        OCMExpect([mock rearrangeTags]);

        [[NSNotificationCenter defaultCenter] postNotificationName:UIDeviceOrientationDidChangeNotification object:nil];
        OCMVerifyAll(mock);
    });

    it(@"calls the tap handler when a AMTagViewNotification is sent", ^{
        __block BOOL hasCalledHandler = NO;
        subject = [[AMTagListView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
        [subject setTapHandler:^(AMTagView *tagView) {
            hasCalledHandler = YES;
        }];

        [[NSNotificationCenter defaultCenter] postNotificationName:AMTagViewNotification object:nil userInfo:@{ @"superview": subject } ];
        expect(hasCalledHandler).to.beTruthy();
    });
});


describe(@"visuals", ^{
    it(@"looks right by default", ^{
        subject = [[AMTagListView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        if (kRECORDING) {
            expect(subject).to.recordSnapshot();
        } else {
            expect(subject).to.haveValidSnapshot();
        }
    });

    it(@"looks right with a tag", ^{
        subject = [[AMTagListView alloc] initWithFrame:CGRectMake(0, 0, 400, 400)];
        [subject addTag:@"Hello World"];
        if (kRECORDING) {
            expect(subject).to.recordSnapshot();
        } else {
            expect(subject).to.haveValidSnapshot();
        }
    });

    it(@"looks right with an array of tags", ^{
        subject = [[AMTagListView alloc] initWithFrame:CGRectMake(0, 0, 400, 400)];
        [subject addTags:@[@"Hello", @"World", @"OK?"]];
        if (kRECORDING) {
            expect(subject).to.recordSnapshot();
        } else {
            expect(subject).to.haveValidSnapshot();
        }
    });

    it(@"looks right with an array of tags aligned to the right", ^{
        subject = [[AMTagListView alloc] initWithFrame:CGRectMake(0, 0, 400, 400)];
        subject.tagAlignment = AMTagAlignmentRight;
        [subject addTags:@[@"Hello", @"World", @"OK?"]];
        if (kRECORDING) {
            expect(subject).to.recordSnapshot();
        } else {
            expect(subject).to.haveValidSnapshot();
        }
    });
});

SpecEnd
