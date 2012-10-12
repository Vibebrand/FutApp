//
//  IInstantiatorDelegate.h
//  FutApp
//
//  Created by Ivo on 10/11/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ProfileViewController;

@protocol IInstantiatorDelegate <NSObject>

- (ProfileViewController *)profileFactory: (NSString *)selectedPlayer;

@end
