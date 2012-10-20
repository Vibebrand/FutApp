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

@class HScrollView;
@class SmoothLineView;
@class MGDrawingSlate;
@class ChosenPlayersService;


@interface ViewController : UIViewController {
    SmoothLineView *slv;
    MGDrawingSlate *mds;
    MGDrawingSlate *mdsG;
    UIImageView *soccerField;
    BOOL canDrag;
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
- (void)showPlayersName;
- (void)initTextBoxes;

@end
