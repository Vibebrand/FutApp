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
#import "UIImage+UIImageDrawText.h"
#import <Social/Social.h>
#import "ChosenPlayersService.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize  dragViews, logger, flowManager, teamOneInfo, teamOneChosenData;

- (void)dealloc
{
    self.dragViews = nil;
    self.logger = nil;
    self.teamOneChosenData = nil;
    [super dealloc];
}

- (void) loadView {
    [super loadView];
        
    
    
}

- (void)positionatePlayers:(int)numberOfPlayers screenRect:(CGRect)screenRect sizeOfPlayers:(float)sizeOfPlayers
{
    //Declaracion de dragviews
    
    self.dragViews = [NSMutableArray arrayWithCapacity: numberOfPlayers];
    NSMutableArray *goodFrames = [[NSMutableArray alloc] initWithCapacity:numberOfPlayers];
    NSMutableArray *badFrames = [[NSMutableArray alloc] initWithCapacity:numberOfPlayers];
    
    CustomTKDragViewDelegate *delegado = [[CustomTKDragViewDelegate alloc] init];
    delegado.logger = self.logger;
    
    self.canUseTheSameFrameManyTimes = NO;
    self.canDragMultipleViewsAtOnce = NO;
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"redteamdot.png" ofType:nil];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    
    
    //Numbers of players
    NSMutableArray *numbersOfPlayers = [[NSMutableArray alloc] initWithCapacity:self.teamOneInfo.count];
    
    for (int i = 0; i < self.teamOneInfo.count; i++) {
        NSString *number = [[self.teamOneInfo allKeys] objectAtIndex:i];
        if ([number length] == 1) {
            number = [NSString stringWithFormat:@" %@",number];
        }
        [numbersOfPlayers addObject: number];
    }
    
    //Se agregan jugadores al scroll view
    for (int i = 0; i < self.teamOneInfo.count; i++) {
        CGFloat xOrigin = i * 60;
        CGRect startFrame = CGRectMake(xOrigin, screenRect.size.width - 70, 50, 50);
        TKDragView *dragView = [[TKDragView alloc] initWithImage:[UIImage drawText:[numbersOfPlayers objectAtIndex:i] inImage:image atPoint:CGPointMake(image.size.width/4, image.size.height/4)] startFrame:startFrame goodFrames:goodFrames badFrames:badFrames andDelegate:delegado];
        dragView.canDragMultipleDragViewsAtOnce = NO;
        [downScrollView.elements addObject:dragView];
        [self.dragViews addObject:dragView];
        [self.view insertSubview:dragView atIndex:4];
        [dragView release];
    }
    delegado.dragViews = self.dragViews;
    [numbersOfPlayers release];
    [self.view insertSubview:downScrollView atIndex:3];
    
    
    
    
    
    
    //Create matrix for the field
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
    
    [[self.dragViews objectAtIndex:7] swapToEndPositionAtIndex: 6 * oLimit + 11];
    [[self.dragViews objectAtIndex:8] swapToEndPositionAtIndex: 8 * oLimit + 11];
    [[self.dragViews objectAtIndex:9] swapToEndPositionAtIndex: 10 * oLimit + 11];
    [[self.dragViews objectAtIndex:10] swapToEndPositionAtIndex: 12 * oLimit + 11];
    
    if (self.teamOneInfo.count > 11) {
        for (int i = 11; i < self.teamOneInfo.count; i++) {
            TKDragView *dragView = [self.dragViews objectAtIndex:i];
            dragView.startFrame = CGRectMake([[UIScreen mainScreen]bounds].size.height - ((i-10)*60), dragView.startFrame.origin.y, dragView.startFrame.size.width, dragView.startFrame.size.height);
            [dragView swapToStartPosition];
        }
    }
    
    //Igualo los start frames con los frames actuales
    for (int i = 0; i < 11; i++) {
        TKDragView *view = [self.dragViews objectAtIndex:i];
        view.startFrame = view.frame;
    }
    
    
    [[TKDragManager manager] addDragView:[self.dragViews objectAtIndex:10]];
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
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
    
    downScrollView = [[[HScrollView alloc] initWithFrame:CGRectMake(0, screenRect.size.width - 70, screenRect.size.height, 50)]autorelease];
    downScrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbarslice.jpg"]];
    downScrollView.contentSize = CGSizeMake(wideScroll-50, 50 );
    downScrollView.scrollEnabled = NO;
    
    
    UIImage *image;
    
    [self positionatePlayers:numberOfPlayers screenRect:screenRect sizeOfPlayers:sizeOfPlayers];
    
    //Botones
    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(-3, screenRect.size.width - 65, 100, 40);
    [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchDown];
    [backButton setImage:[UIImage imageNamed:@"backbutton.png"] forState:UIControlStateNormal];
    [self.view addSubview:backButton];
    
    whiteColorButton = [UIButton buttonWithType:UIButtonTypeCustom];
    whiteColorButton.frame = CGRectMake(91, screenRect.size.width - 65, 40, 40);
    [whiteColorButton addTarget:self action:@selector(colorButtonClicked:) forControlEvents:UIControlEventTouchDown];
    [whiteColorButton setImage:[UIImage imageNamed:@"whitebutton.png"] forState:UIControlStateNormal];
    [self.view addSubview:whiteColorButton];
    
    undoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    undoButton.frame = CGRectMake(134, screenRect.size.width - 65, 40, 40);
    [undoButton addTarget:self action:@selector(undoButtonClicked:) forControlEvents:UIControlEventTouchDown];
    [undoButton setImage:[UIImage imageNamed:@"bookbutton.png"] forState:UIControlStateNormal];
    [self.view addSubview:undoButton];
    
    drawDragButton = [UIButton buttonWithType:UIButtonTypeCustom];
    drawDragButton.frame = CGRectMake(178, screenRect.size.width - 65, 40, 40);
    [drawDragButton addTarget:self action:@selector(drawDragButtonClicked:) forControlEvents:UIControlEventTouchDown];
    [drawDragButton setImage:[UIImage imageNamed:@"handbutton.png"] forState:UIControlStateNormal];
    [self.view addSubview:drawDragButton];
    
    twitterButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    twitterButton.frame = CGRectMake(222, screenRect.size.width - 65, 40, 40);
    [twitterButton addTarget:self action:@selector(twitterButtonClicked:) forControlEvents:UIControlEventTouchDown];
    [twitterButton setImage:[UIImage imageNamed:@"twitterButton.png"] forState:UIControlStateNormal];
    [self.view addSubview:twitterButton];
    
    facebookButton = [UIButton buttonWithType:UIButtonTypeCustom];
    facebookButton.frame = CGRectMake(266, screenRect.size.width - 65, 40, 40);
    [facebookButton addTarget:self action:@selector(facebookButtonClicked:) forControlEvents:UIControlEventTouchDown];
    [facebookButton setImage:[UIImage imageNamed:@"facebookButton.png"] forState:UIControlStateNormal];
    [self.view addSubview:facebookButton];
    
    
    //Imagen del campo
    NSString *Path = [[NSBundle mainBundle] pathForResource:@"field.jpg" ofType:nil];
    image = [UIImage imageWithContentsOfFile:Path];
    soccerField = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.height, screenRect.size.width-70)];
    soccerField.image = image;
    [self.view insertSubview:soccerField atIndex:0];
    [soccerField release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [self becomeFirstResponder];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    [self eraseDrawings];
    [logger checkpointPassed:@"shake para borrar dibujos"];
}

- (void)backButtonClicked: (UIButton *)sender {
    [flowManager backToRootView];
    [self eraseChosenData];
}

- (void)colorButtonClicked:(UIButton *)sender {
    [self changeCholor];
    static uint count = 0;
    count++;
    if (count%2) {
        [sender setImage:[UIImage imageNamed:@"yellowbutton.png"] forState:UIControlStateNormal];
    } else {
        [sender setImage:[UIImage imageNamed:@"whitebutton.png"] forState:UIControlStateNormal];
    }
    [logger checkpointPassed:@"cambio de color"];
}

- (void)drawDragButtonClicked: (UIButton *)sender {
    [self changeDragDraw]; 
    if (canDrag) {
        [drawDragButton setImage:[UIImage imageNamed:@"handbutton.png"] forState:UIControlStateNormal];
    }
    else {
        [drawDragButton setImage:[UIImage imageNamed:@"penbutton.png"] forState:UIControlStateNormal];
    }
    [logger checkpointPassed:@"cambio drag-draw"];
}

- (void)twitterButtonClicked: (UIButton *)sender {
    UIImage *img = [UIImage captureView: self.view];
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"Mi jugada"];
        [tweetSheet addImage:img];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:@"Necesita añadir una cuenta de Twitter en Ajutes"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }

}

- (void)facebookButtonClicked: (UIButton *)sender {
    UIImage *img = [UIImage captureView: self.view];
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [tweetSheet setInitialText:@"Mi jugada"];
        [tweetSheet addImage:img];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:@"Necesita añadir una cuenta de Facebook en Ajutes"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }

}

- (void)undoButtonClicked:(UIButton *)sender {
    [self eraseDrawings];
    [logger checkpointPassed:@"undo"];
}

- (void)changeCholor {
    int indexOfYellow = [[self.view subviews] indexOfObject:mds];
    int indexOfWhite = [[self.view subviews] indexOfObject:mdsG];
    [self.view exchangeSubviewAtIndex:indexOfWhite withSubviewAtIndex:indexOfYellow];

    if (canDrag) {
        [self drawDragButtonClicked:drawDragButton];
    }
}

- (void)changeDragDraw {
    for (int i = 0; i < self.dragViews.count; i++) {
        TKDragView *view = (TKDragView *)[self.dragViews objectAtIndex:i];
        [view setUserInteractionEnabled: !view.userInteractionEnabled];
    }
    [mdsG setUserInteractionEnabled:!mdsG.userInteractionEnabled];
    [mds setUserInteractionEnabled:!mds.userInteractionEnabled];
    canDrag = !canDrag;
    
}

- (void)eraseDrawings {
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
}

- (void)eraseChosenData {
    self.teamOneChosenData.indexOfPlayers = nil;
}

@end
