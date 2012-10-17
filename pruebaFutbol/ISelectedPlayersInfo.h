//
//  ISelectedPlayersInfo.h
//  FutApp
//
//  Created by Ivo on 10/15/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ISelectedPlayersInfo <NSObject>

- (void)setTeamPlayers: (NSDictionary *)players;
- (NSDictionary *)getTeamPlayers;

@end
