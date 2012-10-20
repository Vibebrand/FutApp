//
//  CascadeController.h
//  FutApp
//
//  Created by Ivo on 10/10/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IFlowManager.h"
#import "IInstantiatorDelegate.h"
#import "ISelectedPlayersInfo.h"
#import "IDataSource.h"


@class CLCascadeNavigationController;
@class TeamsViewController;
@class CLSplitCascadeViewController;
@class TeamInfoServiceArray;
@class ChosenPlayersService;

@interface CascadeController : NSObject<IFlowManager, IInstantiatorDelegate> {
    TeamInfoServiceArray *info;
    NSMutableArray *numOfPlayers;
}

@property(nonatomic, retain) CLCascadeNavigationController *cascadeNavController;
@property(nonatomic, retain) TeamsViewController *teamsViewController;
@property(nonatomic, retain) CLSplitCascadeViewController *splitCascadeViewController;
@property(nonatomic, assign) BOOL twoTeams;
@property(nonatomic, retain) id<IFlowManager> flowManager;
@property(nonatomic, retain) id<ISelectedPlayersInfo> teamOne;
@property(nonatomic, retain) id<ISelectedPlayersInfo> teamTwo;
@property (nonatomic, retain) id<IDataSource> dataSource;
@property (nonatomic, retain) ChosenPlayersService *teamOneChosenData;
@property (nonatomic, retain) ChosenPlayersService *teamTwoChosenData;


- (id)initWithDataSource: (id<IDataSource>)dataS;

@end
