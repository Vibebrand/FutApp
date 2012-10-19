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
#import "ISelectedPlayersInfo.h"
#import "CLCascadeNavigationController.h"
#import "IDataSource.h"
@class ChosenPlayersService;

@interface PlayersTableViewController : CLTableViewController<CLCascadeViewDelegate, ISelectedPlayersInfo> {
    NSMutableArray *selectedMarks;
    UIButton *doneButton;
    UILabel *playersLeft;
}

@property(nonatomic, retain) id<IPlayerInfoService> playersInfo;
@property(nonatomic, retain) id<IInstantiatorDelegate> instantiator;
@property(nonatomic, assign) BOOL isFinal;
@property(nonatomic, assign) id<IFlowManager> flowManager;
@property(nonatomic, retain) NSMutableArray *selectedCells;
@property(nonatomic, retain) NSMutableDictionary *selectedPlayers;
@property (nonatomic, retain) NSString *chosenTeam;
@property (nonatomic, retain) id<IDataSource> dataSource;
@property (nonatomic, retain) ChosenPlayersService *teamOneChosen;
@property (nonatomic, retain) ChosenPlayersService *teamTwoChosen;

@end
