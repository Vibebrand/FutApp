//
//  CascadeController.m
//  FutApp
//
//  Created by Ivo on 10/10/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import "CascadeController.h"
#import "CLCascadeNavigationController.h"
#import "TeamsViewController.h"
#import "CLSplitCascadeViewController.h"
#import "TeamInfoServiceArray.h"
#import "PlayersTableViewController.h"

@implementation CascadeController

@synthesize cascadeNavController, splitCascadeViewController, teamsViewController;

- (id)init
{
    self = [super init];
    if (self) {
        info = [[TeamInfoServiceArray alloc] init];
        self.cascadeNavController = [[[CLCascadeNavigationController alloc] init] autorelease];
        self.teamsViewController = [[[TeamsViewController alloc] initWithNibName:@"TeamsViewController" bundle:nil] autorelease];
        self.teamsViewController.teamsInfo = info;
        self.teamsViewController.flowManager = self;
        self.splitCascadeViewController = [[[CLSplitCascadeViewController alloc] initWithNavigationController:self.cascadeNavController] autorelease];
        [self.splitCascadeViewController setCategoriesViewController:self.teamsViewController];
    }
    return self;
}

- (void)dealloc
{
    self.cascadeNavController = nil;
    self.splitCascadeViewController = nil;
    self.teamsViewController = nil;
    [super dealloc];
}

- (void)asignCascadeView:(int)row {
    info.teamSelected = [[info teamsNames] objectAtIndex:row];
    PlayersTableViewController *playersTable = [[PlayersTableViewController alloc] init];
    playersTable.playersInfo = info;
    [self.cascadeNavController setRootViewController:playersTable animated:YES];
}

@end
