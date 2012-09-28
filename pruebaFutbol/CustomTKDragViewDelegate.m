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

- (void)dragViewDidLeaveStartFrame:(TKDragView *)dragView {
    int index = [self.dragViews indexOfObject:dragView];
    for (int i = index + 1; i < self.dragViews.count; i++) {
        TKDragView *view = (TKDragView *)[self.dragViews objectAtIndex:i];
        view.startFrame = CGRectMake(view.startFrame.origin.x - 60, view.startFrame.origin.y, view.startFrame.size.width, view.startFrame.size.height);
        if (view.frame.origin.y == view.startFrame.origin.y) {
            [view swapToStartPosition];
        }
    }
    viewsInBar--;
    NSLog(@"%d", viewsInBar*60);
dragView.startFrame = CGRectMake(viewsInBar * 60, dragView.startFrame.origin.y, dragView.startFrame.size.width, dragView.startFrame.size.height);
    [self.dragViews removeObjectAtIndex:index];
    [self.dragViews addObject:dragView];
    
}

- (void)dragViewWillSwapToStartFrame:(TKDragView *)dragView {
   /* for (int i = 0; i < self.dragViews.count; i++) {
        TKDragView *view = (TKDragView *)[self.dragViews objectAtIndex:i];
        if (view.frame.origin.y != view.startFrame.origin.y) {
            CGRect temp = dragView.startFrame;
            dragView.startFrame = view.startFrame;
            view.startFrame = temp;
            break;
        }
    }*/
}

@end
