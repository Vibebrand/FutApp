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
#import "IPlayerInfo.h"

@interface TeamInfoServiceArray : NSObject<ITeamInfoService, IPlayerInfoService, IPlayerInfo> {
    NSArray *names;
    NSArray *images;
    NSDictionary *america;
    NSDictionary *guadalajara;
    NSDictionary *teams;
}

@property(nonatomic, retain) NSString *teamSelected;
@property(nonatomic, retain) NSString *playerSelected;

@end
