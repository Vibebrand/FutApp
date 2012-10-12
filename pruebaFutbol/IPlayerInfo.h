//
//  IPlayerInfo.h
//  FutApp
//
//  Created by Ivo on 10/11/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IPlayerInfo <NSObject>

- (NSString *)imageOfPlayer;
- (NSString *)nameOfPlayer;
- (int)numberOfPlayer;
- (NSString *)descriptionOfPlayer;
- (int)ageOfPlayer;
- (float)weightOfPlayer;
- (NSString *)positionOfPlayer;

@end
