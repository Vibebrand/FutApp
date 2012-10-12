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
#import "ProfileViewController.h"
#import "SecondTeamViewController.h"

@implementation CascadeController

@synthesize cascadeNavController, splitCascadeViewController, teamsViewController, twoTeams, flowManager;

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
        self.twoTeams = NO;
    }
    return self;
}

- (ProfileViewController *)profileFactory: (NSString *)selectedPlayer {
    info.playerSelected = selectedPlayer;
    ProfileViewController *profile = [[[ProfileViewController alloc]initWithSize:CLViewSizeNormal] autorelease];
    profile.playerInfo = info;
    return profile;
}

- (SecondTeamViewController *)teamsFactory {
    SecondTeamViewController *teams = [[[SecondTeamViewController alloc] initWithNibName:@"TeamsViewController" bundle:nil] autorelease];
    teams.teamsInfo = info;
    teams.flowManager = self;
    teams.instantiator = self;
    return teams;
}

- (PlayersTableViewController *)playersFactory:(int)row {
    info.teamSelected = [[info teamsNames] objectAtIndex:row];
    PlayersTableViewController *playersTable = [[PlayersTableViewController alloc] init];
    playersTable.playersInfo = info;
    playersTable.isFinal = 1;
    playersTable.instantiator = self;
    playersTable.flowManager = self;
    return playersTable;
}

- (void)dealloc
{
    self.cascadeNavController = nil;
    self.splitCascadeViewController = nil;
    self.teamsViewController = nil;
    [super dealloc];
}

- (void)toField {
    [self.flowManager toField];
}

- (void)asignCascadeView:(int)row {
    info.teamSelected = [[info teamsNames] objectAtIndex:row];
    PlayersTableViewController *playersTable = [[PlayersTableViewController alloc] init];
    playersTable.playersInfo = info;
    playersTable.instantiator = self;
    playersTable.flowManager = self;
    playersTable.isFinal = !self.twoTeams;
    [self.cascadeNavController setRootViewController:playersTable animated:YES];
}

- (void)backToRootView {
    [self.splitCascadeViewController.navigationController popToRootViewControllerAnimated:YES];
}

@end
