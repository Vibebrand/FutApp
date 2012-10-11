//
//  ITeamInfoDataSource.h
//  FutApp
//
//  Created by Ivo on 10/10/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ITeamInfoDataSource <NSObject>

- (NSDictionary *)teamsInfo;
- (int)numberOfTeams;

@end
