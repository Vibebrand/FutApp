//
//  TeamInfoDataSourceDict.m
//  FutApp
//
//  Created by Ivo on 10/10/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import "TeamInfoServiceArray.h"

@implementation TeamInfoServiceArray

@synthesize teamSelected, playerSelected;

- (id)init
{
    NSLog(@"ff");
    
    self = [super init];
    if (self) {
        self.teamSelected = nil;
        self.playerSelected = nil;
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
    self.teamSelected = nil;
    self.playerSelected = nil;
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

- (NSString *)imageOfPlayer {
    return @"UnknownProfile1.png";
}

- (NSString *)nameOfPlayer {
    return self.playerSelected;
}

- (int)numberOfPlayer {
    NSArray *numbers = [[teams objectForKey:teamSelected] allKeysForObject:self.playerSelected];
    return [[numbers objectAtIndex:0] intValue];
}

- (NSString *)descriptionOfPlayer{
    return @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec libero libero, dapibus semper ullamcorper vitae, faucibus eu lectus. Morbi euismod augue non massa tincidunt consequat. Mauris velit tellus, dapibus vitae interdum quis, aliquam eu est. Quisque consequat sem purus, eu hendrerit nulla. Praesent interdum, dui id feugiat euismod, diam lacus varius augue, a iaculis orci neque ac quam. Duis ante orci, vulputate at faucibus non, egestas vitae ipsum. Curabitur interdum enim vel velit euismod viverra. Aenean dignissim mi vitae libero volutpat ut sodales nisl euismod. Integer imperdiet, tellus sed tincidunt tincidunt, libero purus placerat ipsum, a rutrum ligula metus non sem. Integer feugiat blandit turpis, in volutpat tellus volutpat eget.";
}

- (int)ageOfPlayer {
    return 24;
}

- (float)weightOfPlayer {
    return 88.5;
}

- (NSString *)positionOfPlayer {
    return @"Delantero";
}

- (void)fillData {
    names = [[NSArray alloc] initWithObjects:@"Guadalajara",@"America", nil];
    images = [[NSArray alloc] initWithObjects:@"guadalajara.jpeg",@"america.jpeg", nil];
    guadalajara = [[NSDictionary alloc] initWithObjectsAndKeys:@"Luis Ernesto Michel", @"1", @"Héctor Reynoso", @"4", @"Omar Esparza", @"6", @"Juan Antonio Ocampo", @"24", @"Miguel Ángel Ponce", @"16", @"José Antonio Rodríguez", @"26", @"Librorio Vicente Sánches",@"30", @"Mario de Luna", @"2", @"Christian Alejandro Pérez", @"27", @"Kristian Álavarez", @"3", @"Jorge Enríquez", @"14", @"Abraham Coronado", @"13", @"Xavier Báez", @"18", @"Patricio Araujo", @"5", @"Luis Ernesto Pérez", @"8", @"Antonio Gallardo", @"25", @"Marco Fabián de la Mora", @"10", @"Erick Estefano Torres", @"19", @"Giovanni Casillas", @"20", nil];
    
    america = [[NSDictionary alloc] initWithObjectsAndKeys:@"Moisés Muñóz", @"23", @"Andrés Ademar Rodríguez", @"29", @"Erik Pimentel", @"2", @"Jorge Reyes", @"20", @"Migul Layún", @"19", @"Hugo Gonzálex", @"1", @"Carlos Aurelio López", @"12", @"Adrián Aldrete", @"16", @"Paul Nicolás Aguilar", @"22", @"Efraín Juárez", @"4", @"Aquivaldo Mosquera", @"3", @"Diego Reyes", @"13", @"Daniel Acosta", @"27", @"Rosinei Adolfo", @"8", @"Rubens Sambueza", @"14", @"Jesús Molina", @"5", @"Antonio López", @"17", @"Christian Benítez", @"11", @"Martín Zúñiga", @"28", nil];
    teams = [[NSDictionary alloc] initWithObjectsAndKeys:guadalajara, @"Guadalajara", america, @"America", nil];
}

@end
