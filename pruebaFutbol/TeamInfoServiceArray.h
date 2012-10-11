//
//  TeamInfoDataSourceDict.h
//  FutApp
//
//  Created by Ivo on 10/10/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ITeamInfoService.h"
#import "IPlayerInfoService.h"

@interface TeamInfoServiceArray : NSObject<ITeamInfoService, IPlayerInfoService> {
    NSArray *names;
    NSArray *images;
    NSDictionary *america;
    NSDictionary *guadalajara;
    NSDictionary *teams;
}

@property(nonatomic, retain) NSString *teamSelected;

@end
