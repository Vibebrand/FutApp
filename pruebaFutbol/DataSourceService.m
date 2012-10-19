//
//  DataSourceService.m
//  FutApp
//
//  Created by Ivo on 10/18/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import "DataSourceService.h"

@implementation DataSourceService

- (id)init
{
    self = [super init];
    if (self) {
        [self initializeData];
    }
    return self;
}

- (void)dealloc
{
    [teams release];
    [super dealloc];
}

- (NSArray *)allData {
    return teams;
}

- (NSArray *)playersForTeam:(NSString *)team {
    for (NSDictionary *dict in teams) {
        if ([dict objectForKey:@"name"] == team) {
            return [dict objectForKey:@"players"];
        }
    }
    return nil;
}
    
- (void)initializeData {
    NSArray *gdlPlayersNames = [NSArray arrayWithObjects:@"Luis Ernesto Michel", @"Héctor Reynoso", @"Omar Esparza",@"Juan Antonio Ocampo",  @"Miguel Ángel Ponce",  @"José Antonio Rodríguez",  @"Librorio Vicente Sánches", @"Mario de Luna", @"Christian Alejandro Pérez",@"Kristian Álavarez", @"Jorge Enríquez", @"Abraham Coronado",@"Xavier Báez", @"Patricio Araujo", @"Luis Ernesto Pérez",@"Antonio Gallardo",@"Marco Fabián de la Mora",@"Erick Estefano Torres",@"Giovanni Casillas", nil];
    NSArray *gdlPlayerNumbers = [NSArray arrayWithObjects:@"1",@"4", @"6", @"24", @"16", @"26", @"30", @"2",@"27", @"3", @"14", @"13", @"18", @"5", @"8", @"25", @"10", @"19", @"20", nil];
    
    NSMutableArray *gdlPlayers = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < gdlPlayerNumbers.count; i++) {
        NSDictionary *player = [NSDictionary dictionaryWithObjectsAndKeys: [gdlPlayersNames objectAtIndex:i], @"name", [gdlPlayerNumbers objectAtIndex:i], @"number", nil];
        [gdlPlayers addObject:player];
    }
    
        
    NSDictionary *gdlTeam = [NSDictionary dictionaryWithObjectsAndKeys:@"Guadalajara", @"name", @"redteam.png", @"teamImage", @"redteamdot.png", @"teamBadge", gdlPlayers, @"players", nil];
    [gdlPlayers release];
    
    
    NSArray *amePlayerNames = [NSArray arrayWithObjects:@"Moisés Muñóz", @"Andrés Ademar Rodríguez", @"Erik Pimentel", @"Jorge Reyes", @"Migul Layún", @"Hugo Gonzálex", @"Carlos Aurelio López", @"Adrián Aldrete", @"Paul Nicolás Aguilar", @"Efraín Juárez", @"Aquivaldo Mosquera", @"Diego Reyes", @"Daniel Acosta", @"Rosinei Adolfo", @"Rubens Sambueza", @"Jesús Molina", @"Antonio López", @"Christian Benítez", @"Martín Zúñiga", nil];
    
    NSArray *amePlayerNumbers = [NSArray arrayWithObjects:@"23", @"29", @"2", @"20", @"19", @"1", @"12", @"16", @"22", @"4", @"3", @"13", @"27", @"8", @"14", @"5", @"17", @"11", @"28", nil];
    
    NSMutableArray *amePlayers = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < amePlayerNumbers.count; i++) {
        NSDictionary *player = [NSDictionary dictionaryWithObjectsAndKeys:[amePlayerNames objectAtIndex:i], @"name", [amePlayerNumbers objectAtIndex:i], @"number", nil];
        [amePlayers addObject:player];
    }
    
    NSDictionary *ameTeam = [NSDictionary dictionaryWithObjectsAndKeys:@"América", @"name", @"yellowteam.png", @"teamImage", @"yellowteamdot.png", @"teamBadge", amePlayers, @"players", nil];

    [amePlayers release];

    teams = [[NSArray alloc] initWithObjects:gdlTeam, ameTeam, nil];


}

@end
