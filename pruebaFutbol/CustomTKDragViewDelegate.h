//
//  CustomTKDragViewDelegate.h
//  pruebaFutbol
//
//  Created by Ivo on 9/28/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKDragView.h"
#import "ICheckpointMessages.h"
#import "IShowPlayersNames.h"

@interface CustomTKDragViewDelegate : NSObject<TKDragViewDelegate> {
    @public
    id<TKDragViewDelegate> _userDelegate;    
}
@property (nonatomic, retain) NSMutableArray *dragViews;
@property (nonatomic, retain) id<ICheckpointMessages> logger;
@property (nonatomic, retain) id<IShowPlayersNames> playersNames;

- (id)initWithDragviews: (NSMutableArray *)dragViews;
@end
