//
//  MasterController.h
//  FutApp
//
//  Created by Ivo on 10/8/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICheckpointMessages.h"
#import "IFlowManager.h"
#import "ISelectedInfo.h"
#import "IDataSource.h"

@class ViewController;
@class CascadeController;

@interface MasterController : NSObject<IFlowManager>

@property (nonatomic, retain) id<ICheckpointMessages> logger;
@property (nonatomic, retain) UINavigationController *navigator;
@property (nonatomic, retain) CascadeController *cascadeController;
@property (nonatomic, retain) id<IDataSource> dataSource;

@end
