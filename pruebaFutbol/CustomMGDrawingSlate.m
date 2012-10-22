//
//  CustomMGDrawingSlate.m
//  FutApp
//
//  Created by Ivo on 10/20/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import "CustomMGDrawingSlate.h"

@implementation CustomMGDrawingSlate

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
