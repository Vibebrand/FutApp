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
#import "HScrollView.h"
#import "SmoothLineView.h"
#import "MGDrawingSlate.h"


@interface ViewController ()

@end

@implementation ViewController

@synthesize  upScrollView, dragViews;

- (void) loadView {
    [super loadView];
    slv = nil;
    mds = [[MGDrawingSlate alloc] initWithFrame:CGRectMake(0, 50, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width-115)];
    mds.drawingColor = [UIColor redColor];
    [self.view insertSubview:mds atIndex:1];
    mds.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    mdsG = [[MGDrawingSlate alloc] initWithFrame:CGRectMake(0, 50, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width-115)];
    mdsG.drawingColor = [UIColor greenColor];
    [self.view insertSubview:mdsG atIndex:2];
    mdsG.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    
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
        [self.view insertSubview:dragView atIndex:4];
        [dragView release];
    }
    delegado.dragViews = self.dragViews;
    
    [self.view insertSubview:self.upScrollView atIndex:3];
    
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
    
    
    //Botones
    UIButton *greenColorButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [greenColorButton setTitle:@"Verde" forState:UIControlStateNormal];
    greenColorButton.frame = CGRectMake(0, -12, 100, 60);
    [greenColorButton addTarget:self action:@selector(greenColorButtonClicked:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:greenColorButton];
    
    UIButton *redColorButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [redColorButton setTitle:@"Rojo" forState:UIControlStateNormal];
    redColorButton.frame = CGRectMake(100, -12, 100, 60);
    [redColorButton addTarget:self action:@selector(redColorButtonClicked:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:redColorButton];
    
    UIButton *undoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [undoButton setTitle:@"Undo" forState:UIControlStateNormal];
    undoButton.frame = CGRectMake(200, -12, 100, 60);
    [undoButton addTarget:self action:@selector(undoButtonClicked:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:undoButton];
    

    //Imagen del campo
    path = [bundle pathForResource:@"soccer.png" ofType:nil];
    image = [UIImage imageWithContentsOfFile:path];
    UIImageView *soccerField = [[UIImageView alloc] initWithFrame:CGRectMake(0, upScrollView.frame.origin.y + upScrollView.frame.size.height, screenRect.size.height, screenRect.size.width)];
    soccerField.image = image;
    [self.view insertSubview:soccerField atIndex:0];
    [soccerField release];
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

- (void)greenColorButtonClicked:(UIButton *)sender {
    if ([[self.view subviews] indexOfObject:mdsG] == 1) {
        [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:2];
    }
}

- (void)redColorButtonClicked:(UIButton *)sender {
    if ([[self.view subviews] indexOfObject:mds] == 1) {
        [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:2];
    }

}


- (void)undoButtonClicked:(UIButton *)sender {
    int indexOfRed = [[self.view subviews] indexOfObject:mds];
    [mds removeFromSuperview];
    [mdsG removeFromSuperview];
    [mdsG release];
    mdsG = nil;
    [mds release];
    mds = nil;
    mds = [[MGDrawingSlate alloc] initWithFrame:CGRectMake(0, 50, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width-115)];
    mds.drawingColor = [UIColor redColor];
    mds.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    mdsG = [[MGDrawingSlate alloc] initWithFrame:CGRectMake(0, 50, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width-115)];
    mdsG.drawingColor = [UIColor greenColor];
    mdsG.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    [self.view insertSubview:mds atIndex:1];
    [self.view insertSubview:mdsG atIndex:2];
    
    if (indexOfRed == 1) {
        [self.view insertSubview:mds atIndex:2];
        [self.view insertSubview:mdsG atIndex:1];
    }
}

@end
