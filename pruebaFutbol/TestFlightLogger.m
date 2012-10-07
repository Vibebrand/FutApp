//
//  TestFlightLogger.m
//  pruebaFutbol
//
//  Created by Ivo on 10/4/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import "TestFlightLogger.h"
#import "TestFlight.h"

@implementation TestFlightLogger

- (void)checkpointPassed:(NSString *)message {
    [TestFlight passCheckpoint:message];
}

- (void)nonExpectedBehaviour:(NSString *)message {
    NSString *msg = [@"Non expected behaviour - "stringByAppendingString:message];
    [TestFlight passCheckpoint:msg];
}

@end
