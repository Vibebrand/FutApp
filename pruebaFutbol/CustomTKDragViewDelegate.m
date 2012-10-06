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

@synthesize dragViews, logger;

- (id)init
{
    self = [super init];
    if (self) {
        self.dragViews = nil;
    }
    return self;
}

- (id)initWithDragviews: (NSMutableArray *)dragViewsArray {
    self = [super init];
    if (self) {
        self.dragViews = dragViewsArray;
    }
    return self;
}

- (void)dealloc
{
    self.dragViews = nil;
    self.logger = nil;
    [super dealloc];
}

-(void)setDragViews:(NSMutableArray *)dragViewsArray {
    if (dragViews != dragViewsArray) {
        [dragViews release];
        dragViews = [dragViewsArray retain];
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
        if (temp.frame.origin.y == [[UIScreen mainScreen] bounds].size.width - 70) {
            [logger checkpointPassed:@"cambio con banca"];
        } else {
            [logger checkpointPassed:@"cambio entre jugadores"];
        }
    }
    else {
        if (dragView.startFrame.origin.y == [[UIScreen mainScreen] bounds].size.width - 70) {
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
