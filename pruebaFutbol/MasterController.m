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

@implementation MasterController

@synthesize navigator, logger, cascadeController;

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
    [self.navigator pushViewController:field animated:YES];
}

- (void)toFieldWithTwoTeams:(NSDictionary *)local And:(NSDictionary *)visitor {
    TwoTeamsFieldViewController *field = [TwoTeamsFieldViewController new];
    field.flowManager = self;
    field.teamOneInfo = local;
    field.teamTwoInfo = visitor;
    [self.navigator pushViewController:field animated:YES];
}

- (void)backToRootView {
    [self.navigator popToRootViewControllerAnimated:YES];
}

- (void)willchangeToOption:(int)index
{
    NSLog(@"willchangeToOption");
    self.cascadeController = [[CascadeController alloc] init];
    self.cascadeController.twoTeams = index;
    self.cascadeController.flowManager = self;
    [self.navigator pushViewController:self.cascadeController.splitCascadeViewController animated:YES];
}

@end
