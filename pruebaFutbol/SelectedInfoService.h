//
//  SelectedInfoService.h
//  FutApp
//
//  Created by Ivo on 10/18/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISelectedInfo.h"
#import "IDataSource.h"

@interface SelectedInfoService : NSObject <ISelectedInfo> {
    
}

@property (nonatomic, retain) NSMutableArray *teams;
@property (nonatomic, retain) NSMutableArray *firstTeamPlayers;
@property (nonatomic, retain) NSMutableArray *secondTeamPlayers;
@property (nonatomic, retain) id<IDataSource> dataSource;

@end
