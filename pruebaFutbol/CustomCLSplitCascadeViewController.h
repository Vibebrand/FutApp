//
//  CustomCLSplitCascadeViewController.h
//  FutApp
//
//  Created by Ivo on 10/24/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import "CLSplitCascadeViewController.h"
#import "IHideTutorial.h"

@interface CustomCLSplitCascadeViewController : CLSplitCascadeViewController <IHideTutorial> {
    UIImageView *tutorial;
    UIButton *okTutorial;
}

@end
