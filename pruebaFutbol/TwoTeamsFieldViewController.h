//
//  TwoTeamsFieldViewController.h
//  FutApp
//
//  Created by Ivo on 10/13/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import "ViewController.h"

@interface TwoTeamsFieldViewController : ViewController

@property(nonatomic, retain) HScrollView *upScrollView;
@property(nonatomic, retain) NSDictionary *teamTwoInfo;
@property (nonatomic, retain) ChosenPlayersService *teamTwoChosenData;

@end
