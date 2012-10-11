//
//  TeamInfoDataSourceDict.m
//  FutApp
//
//  Created by Ivo on 10/10/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import "TeamInfoServiceArray.h"

@implementation TeamInfoServiceArray

@synthesize teamSelected;

- (id)init
{
    NSLog(@"ff");
    
    self = [super init];
    if (self) {
        teamSelected = nil;
        [self fillData];
    }
    return self;
}

- (void)dealloc
{
    [names release];
    [images release];
    [america release];
    [guadalajara release];
    [teams release];
    teamSelected = nil;
    [super dealloc];
}

- (int)numberOfTeams {
    if (names) {
        return names.count;
    }
    return 0;
}

- (NSArray *)teamsNames {
    if (names) {
        return names;
    }
    return nil;
}

- (NSArray *)teamsImages {
    if (images) {
        return images;
    }
    return nil;
}

- (int)numberOfPlayersInTeam:(NSString *)team {
    return [[teams objectForKey:team] count];
}

- (NSDictionary *)playersOf:(NSString *)team {
    return [teams objectForKey:team];
}

- (int)numberOfPlayersInSelectedTeam {
    return [[teams objectForKey:teamSelected] count];
}

- (NSDictionary *)playersOfSelectedTeam {
    return [teams objectForKey:teamSelected];
}

- (NSArray *)allPlayers {
    return [NSArray arrayWithArray:teams.allValues];
}

- (void)fillData {
    names = [[NSArray alloc] initWithObjects:@"Guadalajara",@"America", nil];
    images = [[NSArray alloc] initWithObjects:@"guadalajara.jpeg",@"america.jpeg", nil];
    guadalajara = [[NSDictionary alloc] initWithObjectsAndKeys:@"Luis Ernesto Michel", @"1", @"Héctor Reynoso", @"30", @"Omar Esparza", @"6", @"Juan Antonio Ocampo", @"24", @"Miguel Ángel Ponce", @"16", nil];
    america = [[NSDictionary alloc] initWithObjectsAndKeys:@"Moisés Muñóz", @"23", @"Andrés Ademar Rodríguez", @"29", @"Erik Pimentel", @"2", @"Jorge Reyes", @"20", @"Migul Layún", @"19", nil];
    teams = [[NSDictionary alloc] initWithObjectsAndKeys:guadalajara, @"Guadalajara", america, @"America", nil];
}

@end
