//
//  IInstantiatorDelegate.h
//  FutApp
//
//  Created by Ivo on 10/11/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ProfileViewController;
@class SecondTeamViewController;
@class PlayersTableViewController;

@protocol IInstantiatorDelegate <NSObject>

- (ProfileViewController *)profileFactory: (NSString *)selectedPlayer;
- (SecondTeamViewController *)teamsFactory;
- (PlayersTableViewController *)playersFactory: (int)row;

@end
