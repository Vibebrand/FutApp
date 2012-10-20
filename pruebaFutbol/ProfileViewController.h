//
//  ProfileViewController.h
//  FutApp
//
//  Created by Ivo on 10/11/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import "CLTableViewController.h"
#import "IPlayerInfo.h"

@interface ProfileViewController : CLTableViewController

@property(nonatomic, retain) id<IPlayerInfo> playerInfo;

@end
