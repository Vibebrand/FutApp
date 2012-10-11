//
//  TeamInfoDataSourceDict.m
//  FutApp
//
//  Created by Ivo on 10/10/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import "TeamInfoDataSourceDict.h"

@implementation TeamInfoDataSourceDict

- (id)init
{
    self = [super init];
    if (self) {
        teams = [[NSDictionary alloc] init];
        [self fillDictionary];
    }
    return self;
}

- (void)dealloc
{
    [teams release];
    [super dealloc];
}

- (int)numberOfTeams {
    return teams.count;
}

- (NSDictionary *)teamsInfo {
    return teams;
}

- (void)fillDictionary {
    //TODO
}

@end
