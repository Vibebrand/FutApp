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
        cancha = [[ViewController alloc] init];
    }
    return cancha;
}

- (CascadeController *)cascadeController {
    if (!cascadeController) {
        cascadeController = [[CascadeController alloc] init];
    }
    return cascadeController;
}

- (void)willchangeToOption:(int)index
{
    NSLog(@"willchangeToOption");
    self.cascadeController.twoTeams = index;
    [self.navigator pushViewController:self.cascadeController.splitCascadeViewController animated:YES];
}

@end
