//
//  TeamsViewController.h
//  FutApp
//
//  Created by Ivo on 10/10/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLCategoriesViewController.h"
#import "ITeamInfoService.h"
#import "IFlowManager.h"

@interface TeamsViewController : CLCategoriesViewController

@property(nonatomic, retain) id<ITeamInfoService> teamsInfo;
@property(nonatomic, retain) id<IFlowManager> flowManager;

@end
