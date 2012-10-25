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
#import "ChosenPlayersService.h"
#import "ThirdTeamViewController.h"
#import "CustomCLSplitCascadeViewController.h"

@implementation CascadeController

@synthesize cascadeNavController, splitCascadeViewController, teamsViewController, twoTeams, flowManager, teamOne, teamTwo,dataSource, teamOneChosenData, teamTwoChosenData, nationalTeamViewController;

- (id)init
{
    self = [super init];
    if (self) {
        info = [[TeamInfoServiceArray alloc] init];
        self.cascadeNavController = [[[CLCascadeNavigationController alloc] init] autorelease];
        self.teamsViewController = [[[TeamsViewController alloc] initWithNibName:@"TeamsViewController" bundle:nil] autorelease];
        self.teamsViewController.flowManager = self;
        self.nationalTeamViewController = [[[ThirdTeamViewController alloc] initWithNibName:@"TeamsViewController" bundle:nil] autorelease];
        self.nationalTeamViewController.flowManager = self;
        self.splitCascadeViewController = [[[CustomCLSplitCascadeViewController alloc] initWithNavigationController:self.cascadeNavController] autorelease];
        self.teamsViewController.hideTutorial = self.splitCascadeViewController;
        self.nationalTeamViewController.hideTutorial = self.splitCascadeViewController;
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grass.jpg"]];
        imgView.frame = self.splitCascadeViewController.view.bounds;
        [self.splitCascadeViewController setBackgroundView:imgView];
        [imgView release];
        [self.splitCascadeViewController setCategoriesViewController:self.teamsViewController];
        self.twoTeams = NO;
        numOfPlayers = [[NSMutableArray alloc] init];
        self.dataSource = nil;
    }
    return self;
}

- (id)initForNationalTeam {
    self = [super init];
    if (self) {
        info = [[TeamInfoServiceArray alloc] init];
        self.teamsViewController = [[[TeamsViewController alloc] initWithNibName:@"TeamsViewController" bundle:nil] autorelease];
        self.cascadeNavController = [[[CLCascadeNavigationController alloc] init] autorelease];
        self.nationalTeamViewController = [[[ThirdTeamViewController alloc] initWithNibName:@"TeamsViewController" bundle:nil] autorelease];
        self.nationalTeamViewController.flowManager = self;
        self.splitCascadeViewController = [[[CustomCLSplitCascadeViewController alloc] initWithNavigationController:self.cascadeNavController] autorelease];
        self.nationalTeamViewController.hideTutorial = self.splitCascadeViewController;
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grass.jpg"]];
        imgView.frame = self.splitCascadeViewController.view.bounds;
        [self.splitCascadeViewController setBackgroundView:imgView];
        [imgView release];
        [self.splitCascadeViewController setCategoriesViewController:self.nationalTeamViewController];
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
        self.nationalTeamViewController.dataSource = dataSource;
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
    teams.flowManager = self;
    teams.instantiator = self;
    teams.dataSource = self.dataSource;
    return teams;
}

- (PlayersTableViewController *)playersFactory:(int)row {
    PlayersTableViewController *playersTable = [[PlayersTableViewController alloc] init];
    playersTable.isFinal = 1;
    playersTable.instantiator = self;
    playersTable.flowManager = self;
    playersTable.chosenTeam = [[[self.dataSource allData] objectAtIndex:row] objectForKey:@"name"];
    playersTable.dataSource = self.dataSource;
    playersTable.teamOneChosen = self.teamOneChosenData;
    playersTable.teamTwoChosen = self.teamTwoChosenData;
    self.teamTwoChosenData.chosenTeam = [[[self.dataSource allData] objectAtIndex:row] objectForKey:@"name"];
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
            NSLog(@"%@", self.teamOneChosenData.indexOfPlayers);
            [self.flowManager toFieldWithOneTeam: [self.teamOne getTeamPlayers]];
        }
    } else {
        if ([[numOfPlayers objectAtIndex:0] count] >= 11 && [[numOfPlayers objectAtIndex:1] count] >= 11) {
            NSLog(@"%@ %@", self.teamOneChosenData.indexOfPlayers, self.teamTwoChosenData.indexOfPlayers);
            [self.flowManager toFieldWithTwoTeams:[self.teamOne getTeamPlayers] And:[self.teamTwo getTeamPlayers]];
        }
    }

}

- (void)asignCascadeView:(int)row {
    //info.teamSelected = [[info teamsNames] objectAtIndex:row];
    PlayersTableViewController *playersTable = [[PlayersTableViewController alloc] init];
    playersTable.instantiator = self;
    playersTable.flowManager = self;
    playersTable.isFinal = !self.twoTeams;
    playersTable.chosenTeam = [[[self.dataSource allData] objectAtIndex:row] objectForKey:@"name"];
    playersTable.dataSource = self.dataSource;
    playersTable.teamOneChosen = self.teamOneChosenData;
    playersTable.teamTwoChosen = self.teamTwoChosenData;
    self.teamOneChosenData.chosenTeam = [[[self.dataSource allData] objectAtIndex:row] objectForKey:@"name"];
    self.teamOne = playersTable;
    [numOfPlayers insertObject:playersTable.selectedCells atIndex:0];
    [self.cascadeNavController setRootViewController:playersTable animated:YES];
}

- (void)asignCascadeViewForNational: (int)row {
    
    NSString *team;
    
    if (!row) {
        team = [[self.dataSource locals] objectForKey:@"name"];
    } else {
        team = [[self.dataSource foreigns] objectForKey:@"name"];
    }
    
    PlayersTableViewController *playersTable = [[PlayersTableViewController alloc] init];
    playersTable.instantiator = self;
    playersTable.flowManager = self;
    playersTable.isFinal = YES;
    playersTable.chosenTeam = team;
    playersTable.dataSource = self.dataSource;
    playersTable.teamOneChosen = self.teamOneChosenData;
    playersTable.teamTwoChosen = self.teamTwoChosenData;
    self.teamOneChosenData.chosenTeam = team;
    self.teamOne = playersTable;
    [numOfPlayers insertObject:playersTable.selectedCells atIndex:0];
    [self.cascadeNavController setRootViewController:playersTable animated:YES];
    
}

- (void)backToRootView {
    [self.splitCascadeViewController.navigationController popToRootViewControllerAnimated:YES];
}

@end
