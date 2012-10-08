//
//  ViewController.h
//  pruebaFutbol
//
//  Created by Ivo on 9/22/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKDragView.h"
#import "ICheckpointMessages.h"

@class HScrollView;
@class SmoothLineView;
@class MGDrawingSlate;



@interface ViewController : UIViewController {
    SmoothLineView *slv;
    MGDrawingSlate *mds;
    MGDrawingSlate *mdsG;
    UIImageView *soccerField;
    BOOL canDrag;
}

@property (nonatomic, retain) HScrollView *upScrollView;
@property (nonatomic, retain) NSMutableArray *dragViews;
@property BOOL canDragMultipleViewsAtOnce;
@property BOOL canUseTheSameFrameManyTimes;
@property (nonatomic, retain) id<ICheckpointMessages> logger;
@property (nonatomic, retain) UIButton *drawColorButton;

@end
