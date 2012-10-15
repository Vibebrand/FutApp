//
//  TwoTeamsFieldViewController.m
//  FutApp
//
//  Created by Ivo on 10/13/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import "TwoTeamsFieldViewController.h"
#import "HScrollView.h"
#import "CustomTKDragViewDelegate.h"
#import "UIImage+UIImageDrawText.h"

@interface TwoTeamsFieldViewController ()

@end

@implementation TwoTeamsFieldViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.upScrollView = [[[HScrollView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, 50)]autorelease];
    self.upScrollView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    self.upScrollView.contentSize = CGSizeMake(self.upScrollView.frame.size.width, self.upScrollView.frame.size.height);
    self.upScrollView.scrollEnabled = NO;
    [self.view insertSubview:self.upScrollView atIndex:3];
    
    backButton.frame = CGRectMake(4, 4, 100, 40);
    colorButton.frame = CGRectMake(124, 4, 100, 40);
    undoButton.frame = CGRectMake(244, 5, 100, 40);
    drawDragButton.frame = CGRectMake(364,5, 100, 40);
    
    soccerField.frame = CGRectMake(0, 50, [[UIScreen mainScreen]bounds].size.height, [[UIScreen mainScreen]bounds].size.width - 120);
    
    
}

- (void)positionatePlayers:(int)numberOfPlayers screenRect:(CGRect)screenRect sizeOfPlayers:(float)sizeOfPlayers {
    self.dragViews = [NSMutableArray arrayWithCapacity: numberOfPlayers];
    NSMutableArray *goodFrames = [[NSMutableArray alloc] initWithCapacity:numberOfPlayers];
    NSMutableArray *badFrames = [[NSMutableArray alloc] initWithCapacity:numberOfPlayers];
    
    CustomTKDragViewDelegate *delegado = [[CustomTKDragViewDelegate alloc] init];
    delegado.logger = self.logger;
    
    self.canUseTheSameFrameManyTimes = NO;
    self.canDragMultipleViewsAtOnce = NO;
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"chivasBadgeNum.png" ofType:nil];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    
    
    //Numbers of players
    NSMutableArray *numbersOfPlayers = [[NSMutableArray alloc] initWithCapacity:17];
    [numbersOfPlayers addObject:@" 1"];
    [numbersOfPlayers addObject:@"21"];
    [numbersOfPlayers addObject:@" 4"];
    [numbersOfPlayers addObject:@"24"];
    [numbersOfPlayers addObject:@" 3"];
    [numbersOfPlayers addObject:@"13"];
    [numbersOfPlayers addObject:@"25"];
    [numbersOfPlayers addObject:@"28"];
    [numbersOfPlayers addObject:@"14"];
    [numbersOfPlayers addObject:@"17"];
    [numbersOfPlayers addObject:@"19"];
    [numbersOfPlayers addObject:@"20"];
    [numbersOfPlayers addObject:@" 7"];
    [numbersOfPlayers addObject:@" 5"];
    [numbersOfPlayers addObject:@"26"];
    [numbersOfPlayers addObject:@"10"];
    [numbersOfPlayers addObject:@" 2"];
    
    
    //Se agregan jugadores al scroll view
    for (int i = 0; i < numberOfPlayers; i++) {
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
            if (i < limit -2 ) {
                CGRect endFrame = CGRectMake(j*miniSize + 5, i * miniSize+52, miniSize, miniSize);
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.upScrollView = nil;
    [super dealloc];
}

@end
