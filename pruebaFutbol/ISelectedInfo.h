//
//  ISelectedInfo.h
//  FutApp
//
//  Created by Ivo on 10/18/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ISelectedInfo <NSObject>

- (void)addTeam: (NSString *)team;
- (void)addPlayers:(NSArray *)idxOfPlayers;
- (NSArray *)getTeams;
- (NSArray *)getFirstTeamPlayers;
- (NSArray *)getSecondTeamPlayers;

@end
