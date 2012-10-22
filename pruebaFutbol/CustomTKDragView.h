//
//  CustomTKDragView.h
//  FutApp
//
//  Created by Ivo on 10/22/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import "TKDragView.h"
#import "IShowPlayersNames.h"

@interface CustomTKDragView : TKDragView

@property (nonatomic, retain) id<IShowPlayersNames> playersNames;

@end
