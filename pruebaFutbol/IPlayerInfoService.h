//
//  IPlayerInfoService.h
//  FutApp
//
//  Created by Ivo on 10/11/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IPlayerInfoService <NSObject>

- (int)numberOfPlayersInTeam: (NSString *)team;
- (NSDictionary *)playersOf: (NSString *)team;
- (NSArray *)allPlayers;
- (int)numberOfPlayersInSelectedTeam;
- (NSDictionary *)playersOfSelectedTeam;

@end
