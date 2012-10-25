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
#import "ChosenPlayersService.h"
#import "CustomTKDragView.h"

@interface TwoTeamsFieldViewController ()

@end

@implementation TwoTeamsFieldViewController

@synthesize teamTwoChosenData,teamOneChosenData;

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
    self.upScrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navbar.jpg"]];
    self.upScrollView.contentSize = CGSizeMake(self.upScrollView.frame.size.width, self.upScrollView.frame.size.height);
    self.upScrollView.scrollEnabled = NO;
    [self.view insertSubview:self.upScrollView atIndex:3];
    
    backButton.frame = CGRectMake(backButton.frame.origin.x, 5, backButton.frame.size.width, backButton.frame.size.height);
    [backButton setImage:[UIImage imageNamed:@"backbutton.png"] forState:UIControlStateNormal];
    whiteColorButton.frame = CGRectMake(whiteColorButton.frame.origin.x, 5, whiteColorButton.frame.size.width, whiteColorButton.frame.size.height);
    undoButton.frame = CGRectMake(undoButton.frame.origin.x, 5, undoButton.frame.size.width, undoButton.frame.size.height);
    drawDragButton.frame = CGRectMake(drawDragButton.frame.origin.x,5, drawDragButton.frame.size.width, drawDragButton.frame.size.height);
    twitterButton.frame = CGRectMake(twitterButton.frame.origin.x, 5, twitterButton.frame.size.width, twitterButton.frame.size.height);
    facebookButton.frame = CGRectMake(facebookButton.frame.origin.x, 5, facebookButton.frame.size.width, facebookButton.frame.size.height);
    
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
    NSString *path = [bundle pathForResource:[[self.dataSource dataOfTeam:self.teamOneChosenData.chosenTeam] objectForKey:@"teamBadge"] ofType:nil];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    
    if (!image) {
        image = [UIImage imageNamed:@"DefaultTeam.png"];
    }
    
    
    //Numbers of players
    NSMutableArray *numbersOfPlayers = [[NSMutableArray alloc] initWithCapacity:self.teamOneChosenData.indexOfPlayers.count];
    
    for (int i = 0; i < self.teamOneChosenData.indexOfPlayers.count; i++) {
        NSArray *players = [self.dataSource playersForTeam:self.teamOneChosenData.chosenTeam];
        NSNumber *num = [self.teamOneChosenData.indexOfPlayers objectAtIndex:i];
        NSString *number = [[players objectAtIndex:[num integerValue] ] objectForKey:@"number"];
        if ([number length] == 1) {
            number = [NSString stringWithFormat:@" %@",number];
        }
        [numbersOfPlayers addObject: number];
    }
    
    
    //Se agregan jugadores al scroll view
    for (int i = 0; i < self.teamOneInfo.count; i++) {
        CGFloat xOrigin = i * 60;
        CGRect startFrame = CGRectMake(xOrigin, screenRect.size.width - 70, 50, 50);
        CustomTKDragView *dragView = [[CustomTKDragView alloc] initWithImage:[UIImage drawText:[numbersOfPlayers objectAtIndex:i] inImage:image atPoint:CGPointMake(image.size.width/4, image.size.height/4)] startFrame:startFrame goodFrames:goodFrames badFrames:badFrames andDelegate:delegado];
        dragView.canDragMultipleDragViewsAtOnce = NO;
        dragView.playersNames = self;
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
    [[self.dragViews objectAtIndex:0] swapToEndPositionAtIndex: 8 * oLimit];
    
    [[self.dragViews objectAtIndex:1] swapToEndPositionAtIndex: 6 * oLimit + 5];
    [[self.dragViews objectAtIndex:2] swapToEndPositionAtIndex: 10 * oLimit + 5];
    
    [[self.dragViews objectAtIndex:3] swapToEndPositionAtIndex: 5 * oLimit + 8];
    [[self.dragViews objectAtIndex:4] swapToEndPositionAtIndex: 7 * oLimit + 8];
    [[self.dragViews objectAtIndex:5] swapToEndPositionAtIndex: 9 * oLimit + 8];
    [[self.dragViews objectAtIndex:6] swapToEndPositionAtIndex: 11 * oLimit + 8];
    
    [[self.dragViews objectAtIndex:7] swapToEndPositionAtIndex: 5 * oLimit + 11];
    [[self.dragViews objectAtIndex:8] swapToEndPositionAtIndex: 7 * oLimit + 11];
    [[self.dragViews objectAtIndex:9] swapToEndPositionAtIndex: 9 * oLimit + 11];
    [[self.dragViews objectAtIndex:10] swapToEndPositionAtIndex: 11 * oLimit + 11];
    
    
    if (self.teamOneInfo.count > 11) {
        for (int i = 11; i < self.teamOneChosenData.indexOfPlayers.count; i++) {
            TKDragView *dragView = [self.dragViews objectAtIndex:i];
            dragView.startFrame = CGRectMake((i-11)*60, dragView.startFrame.origin.y, dragView.startFrame.size.width, dragView.startFrame.size.height);
            [dragView swapToStartPosition];
        }
    }
    
    
    
    
    //Igualo los start frames con los frames actuales
    for (int i = 0; i < 11; i++) {
        TKDragView *view = [self.dragViews objectAtIndex:i];
        view.startFrame = view.frame;
    }
    
    
    [[TKDragManager manager] addDragView:[self.dragViews objectAtIndex:10]];
    [self addSecondTeamViews:goodFrames :badFrames :delegado sizeOfPlayers:sizeOfPlayers];
}

- (void)addSecondTeamViews: (NSMutableArray *)goodFrames :(NSMutableArray *)badFrames :(CustomTKDragViewDelegate *)delegado sizeOfPlayers:(float)sizeOfPlayers{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:[[self.dataSource dataOfTeam:self.teamTwoChosenData.chosenTeam] objectForKey:@"teamBadge"] ofType:nil];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    
    if (!image) {
        image = [UIImage imageNamed:@"DefaultTeam.png"];
    }
    
    //Numbers of players
    NSMutableArray *numbersOfPlayers = [[NSMutableArray alloc] initWithCapacity:self.teamOneInfo.count];
    
    for (int i = 0; i < self.teamTwoChosenData.indexOfPlayers.count; i++) {
        NSArray *players = [self.dataSource playersForTeam:teamTwoChosenData.chosenTeam];
        NSNumber *num = [teamTwoChosenData.indexOfPlayers objectAtIndex:i];
        NSString *number = [[players objectAtIndex:[num integerValue] ] objectForKey:@"number"];
        if ([number length] == 1) {
            number = [NSString stringWithFormat:@" %@",number];
        }
        [numbersOfPlayers addObject: number];
    }
    
    
    //Se agregan jugadores al scroll view
    for (int i = 0; i < self.teamTwoInfo.count; i++) {
        CGRect startFrame = CGRectMake([[UIScreen mainScreen]bounds].size.height - ((i-10)*60), [[UIScreen mainScreen] bounds].size.width - 70, 50, 50);
        CustomTKDragView *dragView = [[CustomTKDragView alloc] initWithImage:[UIImage drawText:[numbersOfPlayers objectAtIndex:i] inImage:image atPoint:CGPointMake(image.size.width/4, image.size.height/4)] startFrame:startFrame goodFrames:goodFrames badFrames:badFrames andDelegate:delegado];
        dragView.canDragMultipleDragViewsAtOnce = NO;
        dragView.playersNames = self;
        [downScrollView.elements addObject:dragView];
        [self.dragViews addObject:dragView];
        [self.view insertSubview:dragView atIndex:4];
        [dragView release];
    }
    delegado.dragViews = self.dragViews;
    [numbersOfPlayers release];
    [self.view insertSubview:downScrollView atIndex:3];
    
    
    int oLimit = [[UIScreen mainScreen]bounds].size.height / (sizeOfPlayers * 0.75);

    
    //Posicionar jugadores titulares
    [[self.dragViews objectAtIndex:self.teamOneInfo.count] swapToEndPositionAtIndex: 9 * oLimit - 1];
    
    [[self.dragViews objectAtIndex:self.teamOneInfo.count + 1] swapToEndPositionAtIndex: 7 * oLimit - 6];
    [[self.dragViews objectAtIndex:self.teamOneInfo.count + 2] swapToEndPositionAtIndex: 11 * oLimit - 6];
    
    [[self.dragViews objectAtIndex:self.teamOneInfo.count + 3] swapToEndPositionAtIndex: 6 * oLimit - 9];
    [[self.dragViews objectAtIndex:self.teamOneInfo.count + 4] swapToEndPositionAtIndex: 8 * oLimit - 9];
    [[self.dragViews objectAtIndex:self.teamOneInfo.count + 5] swapToEndPositionAtIndex: 10 * oLimit - 9];
    [[self.dragViews objectAtIndex:self.teamOneInfo.count + 6] swapToEndPositionAtIndex: 12 * oLimit - 9];
    
    [[self.dragViews objectAtIndex:self.teamOneInfo.count + 7] swapToEndPositionAtIndex: 6 * oLimit - 12];
    [[self.dragViews objectAtIndex:self.teamOneInfo.count + 8] swapToEndPositionAtIndex: 8 * oLimit - 12];
    [[self.dragViews objectAtIndex:self.teamOneInfo.count + 9] swapToEndPositionAtIndex: 10 * oLimit - 12];
    [[self.dragViews objectAtIndex:self.teamOneInfo.count + 10] swapToEndPositionAtIndex: 12 * oLimit - 12];

    
    
    
    
    //Igualo los start frames con los frames actuales
    for (int i = self.teamOneInfo.count; i < self.teamOneInfo.count + self.teamTwoInfo.count; i++) {
        TKDragView *view = [self.dragViews objectAtIndex:i];
        view.startFrame = view.frame;
    }
    
    
 //   [[TKDragManager manager] addDragView:[self.dragViews objectAtIndex:10]];
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

- (void)eraseChosenData {
    [super eraseChosenData];
    self.teamTwoChosenData = nil;
}

- (void)initTextBoxes {
    textBoxes = [[NSMutableArray alloc] initWithCapacity:22];
    labels = [[NSMutableArray alloc] initWithCapacity:22];
    for (int i = 0; i < 22; i++) {
        UIImageView *imgView = [[UIImageView alloc] init];
        [textBoxes addObject:imgView];
        [imgView release];
        
        UILabel *label = [[UILabel alloc] init];
        [labels addObject:label];
        [label release];
    }
}

- (void)showPlayersName {
    [self showPlayersNameTeamOne];
    [self showPlayersNameTeamTwo];
}

- (void)hidePlayersName {
    for(UILabel *lb in labels)
        [lb removeFromSuperview];
    for(UIImageView *img in textBoxes)
        [img removeFromSuperview];
}

- (void)showPlayersNameTeamOne {
    NSArray *players = [self.dataSource playersForTeam:teamOneChosenData.chosenTeam];
    int j = 0;
    for (int i =0; i < teamOneChosenData.indexOfPlayers.count; i++) {
        CGRect rect = [[self.dragViews objectAtIndex:i] frame];
        if (rect.origin.y != [[UIScreen mainScreen]bounds].size.width - 70) {
            
            CGRect frame;
            NSString *img;
            CGFloat angle = 0;
            if (rect.origin.x < rect.size.width/2) {
                img = @"leftBubble.png";
                frame = CGRectMake(rect.origin.x + rect.size.width/2, rect.origin.y - rect.size.height, 100, 35);
                if (rect.origin.y < rect.size.height*2) {
                    angle = M_PI;
                    img = @"rightBubble.png";
                    frame = CGRectMake(rect.origin.x + rect.size.width/2, rect.origin.y + rect.size.height, 100, 35);
                }
            } else {
                
                if (rect.origin.x > [[UIScreen mainScreen] bounds].size.height - rect.size.width * 2) {
                    img = @"rightBubble.png";
                    frame = CGRectMake(rect.origin.x - rect.size.width * 2.2, rect.origin.y - rect.size.height, 100, 35);
                    if (rect.origin.y < rect.size.height*2) {
                        angle = M_PI;
                        img = @"leftBubble.png";
                        frame = CGRectMake(rect.origin.x - rect.size.width * 2.2, rect.origin.y + rect.size.height, 100, 35);
                    }
                } else {
                    
                    img = @"middlebubble.png";
                    frame = CGRectMake(rect.origin.x - rect.size.width + 8, rect.origin.y - rect.size.height, 100, 35);
                    if (rect.origin.y < rect.size.height*2) {
                        angle = M_PI;
                        frame = CGRectMake(rect.origin.x - rect.size.width + 8, rect.origin.y + rect.size.height, 100, 35);
                    }
                }
            }
            
            NSNumber *num = [[self.teamOneChosenData indexOfPlayers] objectAtIndex:i];
            
            UIImageView *imgView = [textBoxes objectAtIndex:j];
            imgView.image = [UIImage imageNamed:img];
            imgView.frame = frame;
            imgView.transform = CGAffineTransformMakeRotation(angle);
            
            UILabel *label = [labels objectAtIndex:j];
            label.frame = frame;
            label.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
            label.textColor = [UIColor whiteColor];
            label.font = [label.font fontWithSize:12];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = [[players objectAtIndex:[num integerValue]] objectForKey:@"short name"];
            
            
            j++;
            
            
            [self.view addSubview:imgView];
            [self.view addSubview:label];
        }
    }
}

- (void)showPlayersNameTeamTwo {
    NSArray *players = [self.dataSource playersForTeam:teamTwoChosenData.chosenTeam];
    int j = 0;
    for (int i =0; i < teamTwoChosenData.indexOfPlayers.count; i++) {
        CGRect rect = [[self.dragViews objectAtIndex:i+teamOneChosenData.indexOfPlayers.count] frame];
        if (rect.origin.y != [[UIScreen mainScreen]bounds].size.width - 70) {
            
            CGRect frame;
            NSString *img;
            CGFloat angle = 0;
            if (rect.origin.x < rect.size.width/2) {
                img = @"leftBubble.png";
                frame = CGRectMake(rect.origin.x + rect.size.width/2, rect.origin.y - rect.size.height, 100, 35);
                if (rect.origin.y < rect.size.height*2) {
                    angle = M_PI;
                    img = @"rightBubble.png";
                    frame = CGRectMake(rect.origin.x + rect.size.width/2, rect.origin.y + rect.size.height, 100, 35);
                }
            } else {
                
                if (rect.origin.x > [[UIScreen mainScreen] bounds].size.height - rect.size.width * 2) {
                    img = @"rightBubble.png";
                    frame = CGRectMake(rect.origin.x - rect.size.width * 2.2, rect.origin.y - rect.size.height, 100, 35);
                    if (rect.origin.y < rect.size.height*2) {
                        angle = M_PI;
                        img = @"leftBubble.png";
                        frame = CGRectMake(rect.origin.x - rect.size.width * 2.2, rect.origin.y + rect.size.height, 100, 35);
                    }
                } else {
                    
                    img = @"middlebubble.png";
                    frame = CGRectMake(rect.origin.x - rect.size.width + 8, rect.origin.y - rect.size.height, 100, 35);
                    if (rect.origin.y < rect.size.height*2) {
                        angle = M_PI;
                        frame = CGRectMake(rect.origin.x - rect.size.width + 8, rect.origin.y + rect.size.height, 100, 35);
                    }
                }
            }
            
            NSNumber *num = [[self.teamTwoChosenData indexOfPlayers] objectAtIndex:i];
            
            UIImageView *imgView = [textBoxes objectAtIndex:j+11];
            imgView.image = [UIImage imageNamed:img];
            imgView.frame = frame;
            imgView.transform = CGAffineTransformMakeRotation(angle);
            
            UILabel *label = [labels objectAtIndex:j+11];
            label.frame = frame;
            label.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
            label.textColor = [UIColor whiteColor];
            label.font = [label.font fontWithSize:12];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = [[players objectAtIndex:[num integerValue]] objectForKey:@"short name"];
            
            
            j++;
            
            
            [self.view addSubview:imgView];
            [self.view addSubview:label];
        }
    }

}

@end
