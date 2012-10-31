//
//  CustomTKDragView.m
//  FutApp
//
//  Created by Ivo on 10/22/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import "CustomTKDragView.h"

@implementation CustomTKDragView

@synthesize playersNames;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.playersNames = nil;
    }
    return self;
}

- (void)dealloc
{
    self.playersNames = nil;
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan");
    [self.playersNames hidePlayersName];
    [self.playersNames showPlayer:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.playersNames hidePlayersName];
}

@end
