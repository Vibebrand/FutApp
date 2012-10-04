//
//  CustomTKDragViewDelegate.m
//  pruebaFutbol
//
//  Created by Ivo on 9/28/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import "CustomTKDragViewDelegate.h"
#import "TKDragView.h"

@implementation CustomTKDragViewDelegate

@synthesize dragViews;

- (id)init
{
    self = [super init];
    if (self) {
        self.dragViews = nil;
        viewsInBar = 0;
    }
    return self;
}

- (id)initWithDragviews: (NSMutableArray *)dragViewsArray {
    self = [super init];
    if (self) {
        self.dragViews = dragViewsArray;
        viewsInBar = dragViewsArray.count;
    }
    return self;
}

- (void)dealloc
{
    self.dragViews = nil;
    [super dealloc];
}

-(void)setDragViews:(NSMutableArray *)dragViewsArray {
    if (dragViews != dragViewsArray) {
        [dragViews release];
        dragViews = [dragViewsArray retain];
        viewsInBar = dragViews.count;
    }
}

- (void)dragViewDidSwapToEndFrame:(TKDragView *)dragView atIndex:(NSInteger)index {
    CGRect rect = [[[dragView goodFramesArray] objectAtIndex:index]CGRectValue];
    TKDragView *temp = [self canDragView:dragView DragTo:rect];
    if (temp) {
        temp.startFrame = dragView.startFrame;
        dragView.startFrame = rect;
        [temp swapToStartPosition];
        [dragView swapToStartPosition];
    }
    else {
        if (!dragView.startFrame.origin.y) {
            [dragView swapToStartPosition];
        }
    }
}

- (TKDragView *)canDragView: (TKDragView *)dragView DragTo:(CGRect)destination {
    for (TKDragView *view in self.dragViews) {
        if (view != dragView && CGRectIntersectsRect(destination, view.frame)) {
            return view;
        }
    }
    return nil;
}

-(int)viewsInStartFrame {
    int sum = 0;
    for (int i = 0; i < self.dragViews.count; i++) {
        if ([[self.dragViews objectAtIndex:i] isAtStartFrame]) {
            sum++;
        }
    }
    return sum;
}


@end
