//
//  SecondTeamViewController.h
//  FutApp
//
//  Created by Ivo on 10/12/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import "ViewController.h"
#import "CLTableViewController.h"
#import "ITeamInfoService.h"
#import "IFlowManager.h"
#import "IInstantiatorDelegate.h"

@interface SecondTeamViewController : CLTableViewController

@property(nonatomic, retain) id<ITeamInfoService> teamsInfo;
@property(nonatomic, retain) id<IFlowManager> flowManager;
@property(nonatomic, retain) id<IInstantiatorDelegate> instantiator;

@end
