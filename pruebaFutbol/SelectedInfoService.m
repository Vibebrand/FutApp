//
//  SelectedInfoService.m
//  FutApp
//
//  Created by Ivo on 10/18/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import "SelectedInfoService.h"

@implementation SelectedInfoService

@synthesize teams;

- (id)init
{
    self = [super init];
    if (self) {
        self.teams = [[NSMutableArray alloc] initWithCapacity:2];
        [self.teams addObject:nil];
        [self.teams addObject:nil];
    }
    return self;
}

- (void)dealloc
{
    self.teams = nil;
    [super dealloc];
}

- (void)addTeam: (NSString *)team {
    if (![self.teams objectAtIndex:0]) {
        [self.teams insertObject:team atIndex:0];
    } else {
        if (![self.teams objectAtIndex:1]) {
            [self.teams insertObject:team atIndex:1];
        } else {
            [self.teams insertObject:team atIndex:0];
            [self.teams insertObject:nil atIndex:1];
        }
    }
}

- (void)addPlayers:(NSArray *)idxOfPlayers {
    
}

- (NSArray *)getTeams {
    return nil;
}

- (NSArray *)getFirstTeamPlayers{
    return nil;
}

- (NSArray *)getSecondTeamPlayers {
    return nil;
}

@end
