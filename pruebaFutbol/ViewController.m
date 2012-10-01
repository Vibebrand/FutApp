//
//  ViewController.m
//  pruebaFutbol
//
//  Created by Ivo on 9/22/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import "ViewController.h"
#import "TKDragView.h"
#import "CustomTKDragViewDelegate.h"


@interface ViewController ()

@end

@implementation ViewController

@synthesize downScrollView, upScrollView, dragViews;

- (void) loadView {
    [super loadView];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    int numberOfPlayers = 17;
    float sizeOfPlayers = 50;
    CGFloat wideScroll;
    
    if (numberOfPlayers < 10) {
        wideScroll = screenRect.size.height + 40;
    }
    else {
        wideScroll = numberOfPlayers * 110;
    }
    
 //Declaracion de scrollviews
    
    self.upScrollView = [[[HScrollView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.height, 50)]autorelease];
    self.upScrollView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    self.upScrollView.contentSize = CGSizeMake(wideScroll-50, 50 );
    self.upScrollView.scrollEnabled = NO;
    
    self.downScrollView = [[[HScrollView alloc] initWithFrame:CGRectMake(0, screenRect.size.width - 60, screenRect.size.height, 50)]autorelease];
    self.downScrollView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    self.downScrollView.contentSize = CGSizeMake(screenRect.size.height+40, 100);
    
    //Declaracion de dragviews
    
    self.dragViews = [NSMutableArray arrayWithCapacity: numberOfPlayers];
    NSMutableArray *goodFrames = [[NSMutableArray alloc] initWithCapacity:numberOfPlayers];
    NSMutableArray *badFrames = [[NSMutableArray alloc] initWithCapacity:numberOfPlayers];
    
    CustomTKDragViewDelegate *delegado = [[CustomTKDragViewDelegate alloc] init];
    
    
    self.canUseTheSameFrameManyTimes = NO;
    self.canDragMultipleViewsAtOnce = NO;
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"tile_green.png" ofType:nil];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    
    
    
    //Se agregan jugadores al scroll view
    for (int i = 0; i < numberOfPlayers; i++) {
        CGFloat xOrigin = i * 60;
        CGRect startFrame = CGRectMake(xOrigin, 0, 50, 50);
        
        TKDragView *dragView = [[TKDragView alloc] initWithImage:image startFrame:startFrame goodFrames:goodFrames badFrames:badFrames andDelegate:self];
        dragView.canDragMultipleDragViewsAtOnce = NO;
        dragView.canUseSameEndFrameManyTimes = NO;
        dragView.delegate = delegado;
        [self.upScrollView.elements addObject:dragView];
        [self.dragViews addObject:dragView];
        [self.view insertSubview:dragView atIndex:2];
        [dragView release];
    }
    delegado.dragViews = self.dragViews;

    [self.view insertSubview:self.upScrollView atIndex:0];
    [self.view insertSubview:self.downScrollView  atIndex:0];
    
    //Crear matriz para la cancha
    int limit = ([[UIScreen mainScreen]bounds].size.width - sizeOfPlayers * 2)/sizeOfPlayers;
    int oLimit = [[UIScreen mainScreen]bounds].size.height / sizeOfPlayers;
    for (int i = 1; i <= limit; i++) {
        for (int j = 0; j < oLimit; j++) {
            float x = 10.7 + j * 53;
            if (x <= [[UIScreen mainScreen]bounds].size.height - sizeOfPlayers) {
                CGRect endFrame = CGRectMake(x, 3 + i * 50, sizeOfPlayers, sizeOfPlayers);
                [goodFrames addObject:TKCGRectValue(endFrame)];
            }
            
        }
    }

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
