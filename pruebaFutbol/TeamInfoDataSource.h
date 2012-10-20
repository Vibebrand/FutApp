//
//  TeamInfoDataSource.h
//  FutApp
//
//  Created by Ivo on 10/10/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ITeamInfoService.h"

@interface TeamInfoDataSource : NSObject<UITableViewDataSource>

@property(nonatomic, retain) id<ITeamInfoService> teamsInfo;

@end
