//
//  SecondTeamViewController.h
//  FutApp
//
//  Created by Ivo on 10/12/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import "ViewController.h"
#import "CLTableViewController.h"
#import "IFlowManager.h"
#import "IInstantiatorDelegate.h"
#import "IDataSource.h"

@interface SecondTeamViewController : CLTableViewController

@property(nonatomic, retain) id<IFlowManager> flowManager;
@property(nonatomic, retain) id<IInstantiatorDelegate> instantiator;
@property (nonatomic, retain) id<IDataSource> dataSource;

@end
