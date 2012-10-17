//
//  IFlowManager.h
//  FutApp
//
//  Created by Ivo on 10/8/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IFlowManager <NSObject>

@optional
- (void)willchangeToOption: (int)index;
- (void)asignCascadeView: (int)row;
- (void)backToRootView;
- (void)toField;
- (void)toFieldWithOneTeam: (NSDictionary *)team;
- (void)toFieldWithTwoTeams: (NSDictionary *)local And:(NSDictionary *)visitor;

@end
