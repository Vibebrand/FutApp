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

@synthesize cascadeNavController, splitCascadeViewController, teamsViewController, twoTeams, flowManager, teamOne, teamTwo,dataSource;

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
        numOfPlayers = [[NSMutableArray alloc] init];
        self.dataSource = nil;
    }
    return self;
}

- (void)setDataSource:(id<IDataSource>)dataS {
    if (dataSource != dataS) {
        [dataSource release];
        dataSource = [dataS retain];
        self.teamsViewController.dataSource = dataSource;
    }
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
    self.teamTwo = playersTable;
    [numOfPlayers insertObject:playersTable.selectedCells atIndex:1];
    return playersTable;
}

- (void)dealloc
{
    self.cascadeNavController = nil;
    self.splitCascadeViewController = nil;
    self.teamsViewController = nil;
    [numOfPlayers release];
    [super dealloc];
}

- (void)toField {
    if (numOfPlayers.count == 1){
        if ([[numOfPlayers objectAtIndex:0] count] >= 11) {
            [self.flowManager toFieldWithOneTeam: [self.teamOne getTeamPlayers]];
        }
    } else {
        if ([[numOfPlayers objectAtIndex:0] count] >= 11 && [[numOfPlayers objectAtIndex:1] count] >= 11) {
            [self.flowManager toFieldWithTwoTeams:[self.teamOne getTeamPlayers] And:[self.teamTwo getTeamPlayers]];
        }
    }

}

- (void)asignCascadeView:(int)row {
    info.teamSelected = [[info teamsNames] objectAtIndex:row];
    PlayersTableViewController *playersTable = [[PlayersTableViewController alloc] init];
    playersTable.playersInfo = info;
    playersTable.instantiator = self;
    playersTable.flowManager = self;
    playersTable.isFinal = !self.twoTeams;
    self.teamOne = playersTable;
    [numOfPlayers insertObject:playersTable.selectedCells atIndex:0];
    [self.cascadeNavController setRootViewController:playersTable animated:YES];
}

- (void)backToRootView {
    [self.splitCascadeViewController.navigationController popToRootViewControllerAnimated:YES];
}

@end
