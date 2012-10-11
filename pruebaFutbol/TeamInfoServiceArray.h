//
//  TeamInfoDataSourceDict.h
//  FutApp
//
//  Created by Ivo on 10/10/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ITeamInfoService.h"

@interface TeamInfoServiceArray : NSObject<ITeamInfoService> {
    NSArray *names;
    NSArray *images;
}

@end
