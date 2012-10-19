//
//  IDataSource.h
//  FutApp
//
//  Created by Ivo on 10/18/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IDataSource <NSObject>

- (NSArray *)allData;
- (NSArray *)playersForTeam: (NSString *)team;

@end
