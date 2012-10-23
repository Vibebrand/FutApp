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
    NSString *file;
    for (file in files) {
        [self addTeamFromFile:file];
    }
    NSLog(@"%@", teams);
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
        NSArray *attr = [txt componentsSeparatedByString:@","];
        NSDictionary *player = [[NSDictionary alloc] initWithObjectsAndKeys:[attr objectAtIndex:0], @"name", [attr objectAtIndex:1], @"number", [attr objectAtIndex:2], @"position", [attr objectAtIndex:3], @"foreign", [attr objectAtIndex:4], @"short name", nil];
        [players addObject:player];
        [player release];
    }
    
    NSDictionary *team = [[NSDictionary alloc] initWithObjectsAndKeys:nameOfTeam, @"name", imgName, @"teamImage", imgBadge, @"teamBadge", players, @"players", nil];
    [players release];
    [teams addObject:team];
    [team release];
}

@end
