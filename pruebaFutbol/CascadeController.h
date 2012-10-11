//
//  CascadeController.h
//  FutApp
//
//  Created by Ivo on 10/10/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLCascadeNavigationController;
@class TeamsViewController;
@class CLSplitCascadeViewController;

@interface CascadeController : NSObject

@property(nonatomic, retain) CLCascadeNavigationController *cascadeNavController;
@property(nonatomic, retain) TeamsViewController *teamsViewController;
@property(nonatomic, retain) CLSplitCascadeViewController *splitCascadeViewController;

@end
