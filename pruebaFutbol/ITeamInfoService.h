//
//  ITeamInfoDataSource.h
//  FutApp
//
//  Created by Ivo on 10/10/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ITeamInfoService <NSObject>

- (NSArray *)teamsNames;
- (NSArray *)teamsImages;
- (int)numberOfTeams;

@end
