//
//  MenuViewController.h
//  FutApp
//
//  Created by Ivo on 10/8/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AwesomeMenu.h"
#import "IFlowManager.h"

@class ViewController;

@interface MenuViewController : UIViewController <AwesomeMenuDelegate>

@property (nonatomic, retain) id<IFlowManager> flowManager;


@end
