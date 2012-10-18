//
//  IDataSource.h
//  FutApp
//
//  Created by Ivo on 10/18/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IDataSource <NSObject>

- (NSArray *)completeNameForPlayersInTeam: (NSString *)team;
- (NSArray *)nicknameForPlayersInTeam: (NSString *)team;
- (NSArray *)numbersForPlayersInTeam: (NSString *)team;

@end
