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

- (void)dragViewDidLeaveStartFrame:(TKDragView *)dragView {
   /* for (int i = 0; i < self.dragViews.count; i++) {
        TKDragView *view = (TKDragView *)[self.dragViews objectAtIndex:i];
        if (view.isAtStartFrame && view.frame.origin.x > dragView.frame.origin.x) {
            view.startFrame = CGRectMake(view.startFrame.origin.x - 60, view.startFrame.origin.y, view.startFrame.size.width, view.startFrame.size.height);
            [view swapToStartPosition];
        }
    }
    dragView.startFrame = CGRectMake(-660, dragView.startFrame.origin.y, dragView.startFrame.size.width, dragView.startFrame.size.height);
    */
}

- (void)dragViewWillSwapToStartFrame:(TKDragView *)dragView {
  
    /*if (!dragView.isAtStartFrame || dragView.startFrame.origin.x == -660) {
        dragView.startFrame = CGRectMake([self viewsInStartFrame] * 60, dragView.startFrame.origin.y, dragView.startFrame.size.width, dragView.startFrame.size.height);
    }*/
    
}

- (void)dragViewDidSwapToEndFrame:(TKDragView *)dragView atIndex:(NSInteger)index {
    /*if (!dragView.startFrame .origin.y) {
        [dragView swapToStartPosition];
    }*/
    CGRect rect = [[[dragView goodFramesArray] objectAtIndex:index]CGRectValue];
    NSLog(@"destination: (%f, %f)", rect.origin.x, rect.origin.y);
    NSLog(@"actual frame: (%f, %f)", dragView.frame.origin.x, dragView.frame.origin.y);
    NSLog(@"start frame: (%f, %f)", dragView.startFrame.origin.x, dragView.startFrame.origin.y);
    TKDragView *temp = [self canDragView:dragView DragTo:rect];
    NSLog(@"T actual frame: (%f, %f)", temp.frame.origin.x, temp.frame.origin.y);
    NSLog(@"T start frame: (%f, %f)", temp.startFrame.origin.x, temp.startFrame.origin.y);
    if (temp) {
        temp.startFrame = dragView.startFrame;
        dragView.startFrame = rect;
        [temp swapToStartPosition];
        [dragView swapToStartPosition];
    }
    NSLog(@"--------------------");
    NSLog(@"destination: (%f, %f)", rect.origin.x, rect.origin.y);
    NSLog(@"actual frame: (%f, %f)", dragView.frame.origin.x, dragView.frame.origin.y);
    NSLog(@"start frame: (%f, %f)", dragView.startFrame.origin.x, dragView.startFrame.origin.y);
    NSLog(@"T actual frame: (%f, %f)", temp.frame.origin.x, temp.frame.origin.y);
    NSLog(@"T start frame: (%f, %f)", temp.startFrame.origin.x, temp.startFrame.origin.y);
    
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
