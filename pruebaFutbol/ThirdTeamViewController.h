//
//  ThirdTeamViewController.h
//  FutApp
//
//  Created by Ivo on 10/23/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import "CLCategoriesViewController.h"
#import "IFlowManager.h"
#import "IInstantiatorDelegate.h"
#import "IDataSource.h"
#import "IHideTutorial.h"

@interface ThirdTeamViewController : CLCategoriesViewController

@property(nonatomic, retain) id<IFlowManager> flowManager;
@property(nonatomic, retain) id<IInstantiatorDelegate> instantiator;
@property (nonatomic, retain) id<IDataSource> dataSource;
@property (nonatomic, retain) id<IHideTutorial> hideTutorial;

@end
