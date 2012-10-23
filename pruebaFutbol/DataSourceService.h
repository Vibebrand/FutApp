//
//  DataSourceService.h
//  FutApp
//
//  Created by Ivo on 10/18/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDataSource.h"

@interface DataSourceService : NSObject <IDataSource>{
    NSMutableArray *teams;
    NSMutableDictionary *locals;
    NSMutableDictionary *foreigns;
    NSArray *specialTeams;
}

@end
