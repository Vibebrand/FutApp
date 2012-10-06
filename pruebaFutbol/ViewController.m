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
#import "MGDrawingSlate.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize  upScrollView, dragViews, logger;

- (void) loadView {
    [super loadView];
        
    canDrag = YES;
    slv = nil;
    mds = [[MGDrawingSlate alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width-70)];
    mds.drawingColor = [UIColor yellowColor];
    [self.view insertSubview:mds atIndex:1];
    mds.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    mdsG = [[MGDrawingSlate alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width-70)];
    mdsG.drawingColor = [UIColor whiteColor];
    [self.view insertSubview:mdsG atIndex:2];
    mdsG.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    [mds setUserInteractionEnabled:NO];
    [mdsG setUserInteractionEnabled:NO];
    
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
    
    self.upScrollView = [[[HScrollView alloc] initWithFrame:CGRectMake(0, screenRect.size.width - 70, screenRect.size.height, 50)]autorelease];
    self.upScrollView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    self.upScrollView.contentSize = CGSizeMake(wideScroll-50, 50 );
    self.upScrollView.scrollEnabled = NO;
    

    //Declaracion de dragviews
    
    self.dragViews = [NSMutableArray arrayWithCapacity: numberOfPlayers];
    NSMutableArray *goodFrames = [[NSMutableArray alloc] initWithCapacity:numberOfPlayers];
    NSMutableArray *badFrames = [[NSMutableArray alloc] initWithCapacity:numberOfPlayers];
    
    CustomTKDragViewDelegate *delegado = [[CustomTKDragViewDelegate alloc] init];
    delegado.logger = self.logger;
    
    self.canUseTheSameFrameManyTimes = NO;
    self.canDragMultipleViewsAtOnce = NO;
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"chivasBadge.png" ofType:nil];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    
    
    
    //Se agregan jugadores al scroll view
    for (int i = 0; i < numberOfPlayers; i++) {
        CGFloat xOrigin = i * 60;
        CGRect startFrame = CGRectMake(xOrigin, screenRect.size.width - 70, 50, 50);
        
        TKDragView *dragView = [[TKDragView alloc] initWithImage:image startFrame:startFrame goodFrames:goodFrames badFrames:badFrames andDelegate:self];
        dragView.canDragMultipleDragViewsAtOnce = NO;
        dragView.delegate = delegado;
        [self.upScrollView.elements addObject:dragView];
        [self.dragViews addObject:dragView];
        [self.view insertSubview:dragView atIndex:4];
        [dragView release];
    }
    delegado.dragViews = self.dragViews;
    
    [self.view insertSubview:self.upScrollView atIndex:3];
    
    //Crear matriz para la cancha
    int limit = ([[UIScreen mainScreen]bounds].size.width - sizeOfPlayers)/(sizeOfPlayers * 0.75);
    int oLimit = [[UIScreen mainScreen]bounds].size.height / (sizeOfPlayers * 0.75);
    CGFloat miniSize = sizeOfPlayers * 0.75;
    for (int i = 0; i < limit; i++) {
        for (int j = 0; j < oLimit; j++) {
            if (i < limit -1 ) {
                CGRect endFrame = CGRectMake(j*miniSize + 5, i * miniSize, miniSize, miniSize);
                [goodFrames addObject:TKCGRectValue(endFrame)];
            }
            else {
                CGRect endFrame = CGRectMake(j*miniSize + 5,((i-1) * miniSize)+miniSize/2, miniSize, miniSize);
                [goodFrames addObject:TKCGRectValue(endFrame)];
            }
            
        }
    }
    
    
    
    //Posicionar jugadores titulares
    [[self.dragViews objectAtIndex:0] swapToEndPositionAtIndex: 9 * oLimit];
    
    [[self.dragViews objectAtIndex:1] swapToEndPositionAtIndex: 7 * oLimit + 5];
    [[self.dragViews objectAtIndex:2] swapToEndPositionAtIndex: 11 * oLimit + 5];
    
    [[self.dragViews objectAtIndex:3] swapToEndPositionAtIndex: 6 * oLimit + 9];
    [[self.dragViews objectAtIndex:4] swapToEndPositionAtIndex: 8 * oLimit + 9];
    [[self.dragViews objectAtIndex:5] swapToEndPositionAtIndex: 10 * oLimit + 9];
    [[self.dragViews objectAtIndex:6] swapToEndPositionAtIndex: 12 * oLimit + 9];
    
    [[self.dragViews objectAtIndex:7] swapToEndPositionAtIndex: 6 * oLimit + 13];
    [[self.dragViews objectAtIndex:8] swapToEndPositionAtIndex: 8 * oLimit + 13];
    [[self.dragViews objectAtIndex:9] swapToEndPositionAtIndex: 10 * oLimit + 13];
    [[self.dragViews objectAtIndex:10] swapToEndPositionAtIndex: 12 * oLimit + 13];
    
    //Igualo los start frames con los frames actuales
    for (int i = 0; i < 11; i++) {
        TKDragView *view = [self.dragViews objectAtIndex:i];        
        view.startFrame = view.frame;
    }
    
    
    [[TKDragManager manager] addDragView:[self.dragViews objectAtIndex:10]];
    //Botones
    UIButton *greenColorButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [greenColorButton setTitle:@"White" forState:UIControlStateNormal];
    greenColorButton.frame = CGRectMake(4, screenRect.size.width - 65, 100, 40);
    [greenColorButton addTarget:self action:@selector(colorButtonClicked:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:greenColorButton];
    
    UIButton *undoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [undoButton setTitle:@"Undo" forState:UIControlStateNormal];
    undoButton.frame = CGRectMake(108, screenRect.size.width - 65, 100, 40);
    [undoButton addTarget:self action:@selector(undoButtonClicked:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:undoButton];
    
    UIButton *drawColorButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [drawColorButton setTitle:@"Drag" forState:UIControlStateNormal];
    drawColorButton.frame = CGRectMake(212, screenRect.size.width - 65, 100, 40);
    [drawColorButton addTarget:self action:@selector(drawColorButtonClicked:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:drawColorButton];
    

    //Imagen del campo
    path = [bundle pathForResource:@"soccer.png" ofType:nil];
    image = [UIImage imageWithContentsOfFile:path];
    soccerField = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.height, screenRect.size.width-70)];
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

- (void)colorButtonClicked:(UIButton *)sender {
    int indexOfYellow = [[self.view subviews] indexOfObject:mds];
    int indexOfWhite = [[self.view subviews] indexOfObject:mdsG];
    if (indexOfYellow > indexOfWhite) {
        [self.view exchangeSubviewAtIndex:indexOfWhite withSubviewAtIndex:indexOfYellow];
        [sender setTitle:@"White" forState:UIControlStateNormal];
    }
    else {
        [self.view exchangeSubviewAtIndex:indexOfWhite withSubviewAtIndex:indexOfYellow];
        [sender setTitle:@"Yellow" forState:UIControlStateNormal];
    }
    [logger checkpointPassed:@"cambio de color"];
}

- (void)drawColorButtonClicked: (UIButton *)sender {
    for (int i = 0; i < self.dragViews.count; i++) {
        TKDragView *view = (TKDragView *)[self.dragViews objectAtIndex:i];
        [view setUserInteractionEnabled: !view.userInteractionEnabled];
    }
    [mdsG setUserInteractionEnabled:!mdsG.userInteractionEnabled];
    [mds setUserInteractionEnabled:!mds.userInteractionEnabled];
    canDrag = !canDrag;
    if (canDrag) {
        [sender setTitle:@"Drag" forState:UIControlStateNormal];
    }
    else {
        [sender setTitle:@"Draw" forState:UIControlStateNormal];
    }
    
    [logger checkpointPassed:@"cambio drag-draw"];
}


- (void)undoButtonClicked:(UIButton *)sender {
    int indexOfYellow = [[self.view subviews] indexOfObject:mds];
    int indexOfWhite = [[self.view subviews] indexOfObject:mdsG];
    [mds removeFromSuperview];
    [mdsG removeFromSuperview];
    [mdsG release];
    mdsG = nil;
    [mds release];
    mds = nil;
    mds = [[MGDrawingSlate alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width-70)];
    mds.drawingColor = [UIColor yellowColor];
    mds.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    mdsG = [[MGDrawingSlate alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width-70)];
    mdsG.drawingColor = [UIColor whiteColor];
    mdsG.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    [self.view insertSubview:mds atIndex:indexOfYellow];
    [self.view insertSubview:mdsG atIndex:indexOfWhite];
    
    if (canDrag) {
        [mdsG setUserInteractionEnabled:NO];
        [mds setUserInteractionEnabled:NO];
    }
    
    [logger checkpointPassed:@"undo"];
}

@end
