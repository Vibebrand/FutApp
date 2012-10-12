//
//  PlayersTableViewController.h
//  FutApp
//
//  Created by Ivo on 10/11/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLTableViewController.h"
#import "IPlayerInfoService.h"
#import "IInstantiatorDelegate.h"
#import "IFlowManager.h"

@interface PlayersTableViewController : CLTableViewController {
    NSMutableArray *selectedMarks;
    UIButton *doneButton;
    int selectedCells;
}

@property(nonatomic, retain) id<IPlayerInfoService> playersInfo;
@property(nonatomic, retain) id<IInstantiatorDelegate> instantiator;
@property(nonatomic, assign) BOOL isFinal;
@property(nonatomic, assign) id<IFlowManager> flowManager;

@end
