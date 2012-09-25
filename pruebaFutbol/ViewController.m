//
//  ViewController.m
//  pruebaFutbol
//
//  Created by Ivo on 9/22/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import "ViewController.h"
#import "TKDragView.h"


@interface ViewController ()

@end

@implementation ViewController

@synthesize downScrollView, upScrollView, dragViews;

- (void) loadView {
    [super loadView];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    self.upScrollView = [[[HScrollView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.height, 100)]autorelease];
    self.upScrollView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    self.upScrollView.contentSize = CGSizeMake(screenRect.size.height+40, 100);
    self.upScrollView.delegate = self.upScrollView.delegate;
    
    self.downScrollView = [[[HScrollView alloc] initWithFrame:CGRectMake(0, screenRect.size.width - 120, screenRect.size.height, 100)]autorelease];
    self.downScrollView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    self.downScrollView.contentSize = CGSizeMake(screenRect.size.height+40, 100);
     
    
    int numberOfPlayers = 5;
    self.dragViews = [NSMutableArray arrayWithCapacity: numberOfPlayers];
    NSMutableArray *goodFrames = [[NSMutableArray alloc] initWithCapacity:numberOfPlayers];
    NSMutableArray *badFrames = [[NSMutableArray alloc] initWithCapacity:numberOfPlayers];
    
    for (int i = 0; i < numberOfPlayers; i++) {
        CGRect endFrame = CGRectMake(6 + i * 103, 200, 100, 100);
        CGRect badFrame = CGRectMake(6 + i * 103, 340, 100, 100);
        
        [goodFrames addObject:TKCGRectValue(endFrame)];
        [badFrames addObject:TKCGRectValue(badFrame)];
        
    }
    
    self.canUseTheSameFrameManyTimes = NO;
    self.canDragMultipleViewsAtOnce = NO;
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"tile_green.png" ofType:nil];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    
    for (int i = 0; i < numberOfPlayers; i++) {
        CGFloat xOrigin = i * 110;
        CGRect startFrame = CGRectMake(xOrigin, 0, 100, 100);
        
        TKDragView *dragView = [[TKDragView alloc] initWithImage:image startFrame:startFrame goodFrames:goodFrames badFrames:badFrames andDelegate:self];
        dragView.canDragMultipleDragViewsAtOnce = NO;
        dragView.canUseSameEndFrameManyTimes = NO;
        [self.upScrollView.elements insertObject:dragView atIndex:i];
        [self.dragViews addObject:dragView];
        [self.view insertSubview:dragView atIndex:2];
        [dragView release];
    }

    [self.view insertSubview:self.upScrollView atIndex:0];
    [self.view insertSubview:self.downScrollView  atIndex:0];

}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
