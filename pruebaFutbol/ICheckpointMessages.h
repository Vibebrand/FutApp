//
//  ICheckpointMessages.h
//  pruebaFutbol
//
//  Created by Ivo on 10/4/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ICheckpointMessages <NSObject>

- (void)checkpointPassed: (NSString *)message;
- (void)nonExpectedBehaviour: (NSString *)message;

@end
