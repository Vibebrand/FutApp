//
//  TeamInfoDataSourceDict.m
//  FutApp
//
//  Created by Ivo on 10/10/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import "TeamInfoServiceArray.h"

@implementation TeamInfoServiceArray

- (id)init
{
    self = [super init];
    if (self) {
        [self fillData];
    }
    return self;
}

- (void)dealloc
{
    [names release];
    [images release];
    [super dealloc];
}

- (int)numberOfTeams {
    if (names) {
        return names.count;
    }
    return 0;
}

- (NSArray *)teamsNames {
    if (names) {
        return names;
    }
    return nil;
}

- (NSArray *)teamsImages {
    if (images) {
        return images;
    }
    return nil;
}

- (void)fillData {
    names = [[NSArray alloc] initWithObjects:@"Guadalajara",@"America", nil];
    images = [[NSArray alloc] initWithObjects:@"guadalajara.jpeg",@"america.jpeg", nil];
}

@end
