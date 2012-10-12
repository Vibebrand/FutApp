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

@implementation MasterController

@synthesize navigator, cancha, logger, cascadeController;

- (ViewController *)cancha {
    if (!cancha) {
        cancha = [[[ViewController alloc] init] autorelease];
        cancha.flowManager = self;
    }
    return cancha;
}

- (CascadeController *)cascadeController {
    if (!cascadeController) {
        cascadeController = [[CascadeController alloc] init];
    }
    return cascadeController;
}

- (void)toField {
    self.cancha = [[ViewController new] autorelease];
    cancha.flowManager = self;
    [self.navigator pushViewController:self.cancha animated:YES];
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
