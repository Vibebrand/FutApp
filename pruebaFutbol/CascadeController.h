//
//  CascadeController.h
//  FutApp
//
//  Created by Ivo on 10/10/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IFlowManager.h"

@class CLCascadeNavigationController;
@class TeamsViewController;
@class CLSplitCascadeViewController;

@interface CascadeController : NSObject<IFlowManager>

@property(nonatomic, retain) CLCascadeNavigationController *cascadeNavController;
@property(nonatomic, retain) TeamsViewController *teamsViewController;
@property(nonatomic, retain) CLSplitCascadeViewController *splitCascadeViewController;

@end
