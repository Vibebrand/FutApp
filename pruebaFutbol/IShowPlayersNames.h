//
//  IShowPlayersNames.h
//  FutApp
//
//  Created by Ivo on 10/22/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TKDragView;

@protocol IShowPlayersNames <NSObject>

- (void)showPlayersName;
- (void)hidePlayersName;
- (void)showPlayer: (id)sender;

@end
