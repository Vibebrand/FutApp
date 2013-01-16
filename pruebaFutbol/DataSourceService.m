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
        [self initData];
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

- (NSArray *)playersForSpecialTeam:(NSString *)team {
    for (NSDictionary *dict in specialTeams) {
        if ([dict objectForKey:@"name"] == team) {
            return [dict objectForKey:@"players"];
        }
    }
    return nil;
}

- (NSDictionary *)dataOfTeam: (NSString *)team {
    for (NSDictionary *dict in teams) {
        if ([dict objectForKey:@"name"] == team) {
            return dict;
        }
    }
    
    return nil;
}

- (void)initData {
    NSArray *files = [[NSBundle mainBundle] pathsForResourcesOfType:@".csv" inDirectory:@"."];
    teams = [[NSMutableArray alloc] initWithCapacity:files.count];
    locals = [[NSMutableDictionary alloc] init];
    [locals setValue:[[[NSMutableArray alloc] init] autorelease] forKey:@"players"];
    [locals setValue:@"Jugadores mexicanos" forKey:@"name"];
    [locals setValue:@"MéxicoTeam.png" forKey:@"teamImage"];
    [locals setValue:@"MéxicoBadge.png" forKey:@"teamBadge"];
    
    foreigns = [[NSMutableDictionary alloc] init];
    [foreigns setValue:[[[NSMutableArray alloc] init] autorelease] forKey:@"players"];
    [foreigns setValue:@"En el extranjero" forKey:@"name"];
    [foreigns setValue:@"DefaultTeam.png" forKey:@"teamImage"];
    [foreigns setValue:@"Default.png" forKey:@"teamBadge"];
    
    eleven = [[NSMutableDictionary alloc] init];
    [eleven setValue:[[[NSMutableArray alloc]init]autorelease] forKey:@"players"];
    [eleven setValue:@"11 ideal" forKey:@"name"];
    [eleven setValue:@"MéxicoTeam.png" forKey:@"teamImage"];
    [eleven setValue:@"MéxicoBadge.png" forKey:@"teamBadge"];
    
    NSString *file;
    for (file in files) {
        NSArray *components = [file componentsSeparatedByString:@"/"];
        NSString *nameOfTeam = [[[components objectAtIndex:components.count - 1] componentsSeparatedByString:@"."] objectAtIndex:0];
        if (![nameOfTeam isEqualToString:@"Internacional"]) {
            [self addTeamFromFile:file];
        } else {
            NSString *text = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
            NSArray *lines = [text componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
            NSMutableArray *players = [[NSMutableArray alloc] initWithCapacity:lines.count];
            for (NSString *txt in lines) {
                if ([txt length]) {
                    NSArray *attr = [txt componentsSeparatedByString:@","];
                    NSDictionary *player = [[NSDictionary alloc] initWithObjectsAndKeys:[attr objectAtIndex:0],@"name", [attr objectAtIndex:1], @"short name", [attr objectAtIndex:2], @"number",@"extranjeroTeam",@"imgName", nil];
                    [[locals objectForKey:@"players"] insertObject:player atIndex:0];
                    [players addObject:player];
                    [player release];
                }
            }
            [foreigns setValue:players forKey:@"players"];
            [players release];
        }
    
    }
    [teams insertObject:eleven atIndex:0];
    NSLog(@"%@", locals);
    specialTeams = [[NSArray alloc] initWithObjects:locals, nil];
}

- (NSDictionary *)locals {
    return locals;
}

- (NSDictionary *)foreigns {
    return foreigns;
}

- (NSArray *)specialTeams {
    return specialTeams;
}

- (void)addTeamFromFile: (NSString *)file {
    NSArray *components = [file componentsSeparatedByString:@"/"];
    NSString *nameOfTeam = [[[components objectAtIndex:components.count - 1] componentsSeparatedByString:@"."] objectAtIndex:0];
    NSString *imgName = [NSString stringWithFormat:@"%@Team.png", nameOfTeam];
    NSString *imgBadge = [NSString stringWithFormat:@"%@Badge.png", nameOfTeam];
    NSString *text = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
    NSArray *lines = [text componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    NSMutableArray *players = [[NSMutableArray alloc] initWithCapacity:lines.count];
        for (NSString *txt in lines) {
            if ([txt length]) {
                NSArray *attr = [txt componentsSeparatedByString:@","];
                NSDictionary *player = [[NSDictionary alloc] initWithObjectsAndKeys:[attr objectAtIndex:0], @"name", [attr objectAtIndex:1], @"number", [attr objectAtIndex:2], @"position", [attr objectAtIndex:3], @"foreign", [attr objectAtIndex:4], @"short name",imgName, @"imgName", nil];
                
                [players addObject:player];
                [[eleven objectForKey:@"players"] addObject:player];
                
                if ([[player objectForKey:@"foreign"] integerValue] != 1) {
                    [[locals objectForKey:@"players"] addObject:player];
                }
                
                [player release];
            }
        }
        
        NSDictionary *team = [[NSDictionary alloc] initWithObjectsAndKeys:nameOfTeam, @"name", imgName, @"teamImage", imgBadge, @"teamBadge", players, @"players", nil];
        [players release];
        
        if ([[team objectForKey:@"players"] count]) {
            [teams addObject:team];
        }
        
        
        [team release];
}

@end
