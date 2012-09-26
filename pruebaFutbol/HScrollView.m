//
//  HScrollView.m
//  pruebaFutbol
//
//  Created by Ivo on 9/24/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import "HScrollView.h"

@interface HScrollViewDelegate : NSObject <UIScrollViewDelegate> {
    @public
    id <UIScrollViewDelegate> _userDelegate;
}
@end

@implementation HScrollView {
    HScrollViewDelegate *_myDelegate;
}

- (void)initDelegate {
    _myDelegate = [[HScrollViewDelegate alloc] init];
    [_myDelegate retain];
    [super setDelegate:_myDelegate];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initDelegate];
        self.elements = [[[NSMutableArray alloc] init] autorelease];
    }
    return self;
}

- (void)dealloc
{
    [_myDelegate release];
    self.elements = nil;
    [super dealloc];
}

- (void)setDelegate:(id<UIScrollViewDelegate>)delegate {
    _myDelegate->_userDelegate = delegate;
    super.delegate = nil;
    super.delegate = (id)_myDelegate;
}

- (id <UIScrollViewDelegate>) delegate {
    return _myDelegate->_userDelegate;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end


@implementation HScrollViewDelegate

- (void)scrollViewWillBeginDragging:(HScrollView *)scrollView {
    for (int i = 0; i < scrollView.elements.count; i++) {
        UIView *view = (UIView *)[scrollView.elements objectAtIndex:i];
        if (!view.frame.origin.y) {
            [view removeFromSuperview];
            [scrollView insertSubview:view atIndex:0];
        }
    }
    if ([_userDelegate respondsToSelector:_cmd]) {
        [_userDelegate scrollViewWillBeginDragging:scrollView];
    }
}

- (void) scrollViewDidEndScrollingAnimation:(HScrollView *)scrollView {
    for (int i = 0; i < scrollView.elements.count; i++) {
        UIView *view = (UIView *)[scrollView.elements objectAtIndex:i];
        [view removeFromSuperview];
        [scrollView.superview insertSubview:view atIndex:2];
    }
    if ([_userDelegate respondsToSelector:_cmd])
            [_userDelegate scrollViewDidEndScrollingAnimation:scrollView];
    
}

@end
