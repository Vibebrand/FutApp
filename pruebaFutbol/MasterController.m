//
//  MasterController.m
//  FutApp
//
//  Created by Ivo on 10/8/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import "MasterController.h"
#import "ViewController.h"
#import "CascadeController.h"
#import "TwoTeamsFieldViewController.h"
#import "ChosenPlayersService.h"

@implementation MasterController

@synthesize navigator, logger, cascadeController, teamOneChosen, teamTwoChosen;

- (id)init
{
    self = [super init];
    if (self) {
        self.navigator = nil;
        self.logger = nil;
        self.cascadeController = nil;
        self.teamOneChosen = [[ChosenPlayersService new] autorelease];
        self.teamTwoChosen = [[ChosenPlayersService new] autorelease];
    }
    return self;
}

- (CascadeController *)cascadeController {
    if (!cascadeController) {
        cascadeController = [[CascadeController alloc] init];
    }
    return cascadeController;
}

- (void)toFieldWithOneTeam:(NSDictionary *)team {
    ViewController *field = [ViewController new];
    field.flowManager = self;
    field.teamOneInfo = team;
    field.teamOneChosenData = self.teamOneChosen;
    field.dataSource = self.dataSource;
    [self.navigator pushViewController:field animated:YES];
}

- (void)toFieldWithTwoTeams:(NSDictionary *)local And:(NSDictionary *)visitor {
    TwoTeamsFieldViewController *field = [TwoTeamsFieldViewController new];
    field.flowManager = self;
    field.teamOneInfo = local;
    field.teamTwoInfo = visitor;
    field.teamOneChosenData = self.teamOneChosen;
    field.teamTwoChosenData = self.teamTwoChosen;
    field.dataSource = self.dataSource;
    [self.navigator pushViewController:field animated:YES];
}

- (void)backToRootView {
    [self.navigator popToRootViewControllerAnimated:YES];
}

- (void)willchangeToOption:(int)index
{
    self.cascadeController = [[CascadeController alloc] init];
    self.cascadeController.dataSource = self.dataSource;
    self.cascadeController.twoTeams = index;
    self.cascadeController.flowManager = self;
    self.cascadeController.teamOneChosenData = self.teamOneChosen;
    self.cascadeController.teamTwoChosenData = self.teamTwoChosen;
    [self.navigator pushViewController:self.cascadeController.splitCascadeViewController animated:YES];
}

@end
