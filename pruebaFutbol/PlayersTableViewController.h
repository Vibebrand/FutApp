//
//  PlayersTableViewController.h
//  FutApp
//
//  Created by Ivo on 10/11/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLTableViewController.h"
#import "IPlayerInfoService.h"

@interface PlayersTableViewController : CLTableViewController {
    NSMutableArray *selectedMarks;
}

@property(nonatomic, retain) id<IPlayerInfoService> playersInfo;
@property(nonatomic, retain) NSIndexPath *idx;

@end
