//
//  CustomTKDragViewDelegate.h
//  pruebaFutbol
//
//  Created by Ivo on 9/28/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKDragView.h"

@interface CustomTKDragViewDelegate : NSObject<TKDragViewDelegate> {
    @public
    id<TKDragViewDelegate> _userDelegate;
    int viewsInBar;
    
}
@property (nonatomic, retain) NSMutableArray *dragViews;

- (id)initWithDragviews: (NSMutableArray *)dragViews;
@end
