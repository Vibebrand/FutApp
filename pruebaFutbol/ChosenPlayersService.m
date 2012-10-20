//
//  ChosenPlayersService.m
//  FutApp
//
//  Created by Ivo on 10/19/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import "ChosenPlayersService.h"

@implementation ChosenPlayersService

@synthesize chosenTeam, indexOfPlayers;

- (id)init
{
    self = [super init];
    if (self) {
        self.chosenTeam = nil;
        self.indexOfPlayers = nil;
    }
    return self;
}

- (void)dealloc
{
    self.chosenTeam = nil;
    self.indexOfPlayers = nil;
    [super dealloc];
}

@end
