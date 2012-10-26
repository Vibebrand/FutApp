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
#import "IFlowManager.h"
#import "ISelectedPlayersInfo.h"
#import "IDataSource.h"
#import "IShowPlayersNames.h"

@class HScrollView;
@class SmoothLineView;
@class MGDrawingSlate;
@class ChosenPlayersService;
@class CustomTKDragView;

@interface ViewController : UIViewController <IShowPlayersNames> {
    SmoothLineView *slv;
    MGDrawingSlate *mds;
    MGDrawingSlate *mdsG;
    MGDrawingSlate *mdsR;
    UIImageView *soccerField;
    BOOL canDrag;
    BOOL namesVisibles;
    HScrollView *downScrollView;
    UIButton *backButton;
    UIButton *whiteColorButton;
    UIButton *yellowColorButton;
    UIButton *redColorButton;
    UIButton *undoButton;
    UIButton *drawDragButton;
    UIButton *twitterButton;
    UIButton *facebookButton;
    NSMutableArray *textBoxes;
    NSMutableArray *labels;
}

@property (nonatomic, retain) NSMutableArray *dragViews;
@property BOOL canDragMultipleViewsAtOnce;
@property BOOL canUseTheSameFrameManyTimes;
@property (nonatomic, retain) id<ICheckpointMessages> logger;
@property (nonatomic, retain) id<IFlowManager> flowManager;
@property (nonatomic, retain) NSDictionary *teamOneInfo;
@property (nonatomic, retain) ChosenPlayersService *teamOneChosenData;
@property (nonatomic, retain) id<IDataSource> dataSource;

- (void)eraseChosenData;
- (void)initTextBoxes;

@end
