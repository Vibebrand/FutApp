//
//  TeamsViewController.h
//  FutApp
//
//  Created by Ivo on 10/10/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLCategoriesViewController.h"
#import "IFlowManager.h"
#import "IDataSource.h"

@interface TeamsViewController : CLCategoriesViewController

@property (nonatomic, retain) id<IFlowManager> flowManager;
@property (nonatomic, retain) id<IDataSource> dataSource;

@end
