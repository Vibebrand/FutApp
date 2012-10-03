//
//  ViewController.h
//  pruebaFutbol
//
//  Created by Ivo on 9/22/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKDragView.h"
@class HScrollView;
@class SmoothLineView;
@class MGDrawingSlate;


@interface ViewController : UIViewController <TKDragViewDelegate> {
    SmoothLineView *slv;
    MGDrawingSlate *mds;
    MGDrawingSlate *mdsG;
}

@property (nonatomic, retain) HScrollView *downScrollView;
@property (nonatomic, retain) HScrollView *upScrollView;
@property (nonatomic, retain) NSMutableArray *dragViews;
@property BOOL canDragMultipleViewsAtOnce;
@property BOOL canUseTheSameFrameManyTimes;

@end
