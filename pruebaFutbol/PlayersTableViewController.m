//
//  PlayersTableViewController.m
//  FutApp
//
//  Created by Ivo on 10/11/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import "PlayersTableViewController.h"
#import "UIViewController+CLSegmentedView.h"
#import "CRTableViewCell.h"
#import "ViewController.h"
#import "ProfileViewController.h"
#import "SecondTeamViewController.h"
#import "ChosenPlayersService.h"
#import "TeamInfoServiceArray.h"

@interface PlayersTableViewController ()

@end

@implementation PlayersTableViewController

@synthesize instantiator, isFinal, selectedCells, selectedPlayers;

- (id)init
{
    self = [super init];
    if (self) {
        selectedMarks = [NSMutableArray new];
        self.instantiator = nil;
        self.isFinal = NO;
        self.selectedCells = [[NSMutableArray new] autorelease];
        self.selectedPlayers = nil;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     
    [self addLeftBorderShadowWithWidth:20.0 andOffset:0.0f];
    
    UIImageView* header = [[UIImageView alloc] initWithFrame: CGRectMake(0.0, 0.0, self.view.bounds.size.width, 45.0)];
    [header setImage: [UIImage imageNamed:@"navbar.jpg"]];
    
    doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneButton setBackgroundImage:[UIImage imageNamed:@"okbutton.png"] forState:UIControlStateNormal];
    doneButton.frame = CGRectMake(400, 4, 60, 35);
    [doneButton addTarget:self action:@selector(doneButtonClicked:) forControlEvents:UIControlEventTouchDown];
    [header addSubview:doneButton];
    
    playersLeft = [[UILabel alloc] initWithFrame:CGRectMake(220, 8, 70, 30)];
    [playersLeft setText:@"11"];
    playersLeft.textColor = [UIColor whiteColor];
    [playersLeft setBackgroundColor:[UIColor colorWithWhite:0 alpha:0]];
    [header addSubview:playersLeft];
    
    [self.segmentedView setHeaderView:header];
    [doneButton setHidden:YES];
    
    [self setShowRoundedCorners: YES];
    self.tableView.allowsMultipleSelection = YES;
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    
    self.selectedPlayers = [NSMutableDictionary new];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doneButtonClicked: (UIButton *)sender {
    if (isFinal) {
        if (self.teamOneChosen.indexOfPlayers) {
            self.teamTwoChosen.indexOfPlayers = self.selectedCells;
        } else {
            self.teamOneChosen.indexOfPlayers = self.selectedCells;
        }
        [self.flowManager toField];
    } else {
        SecondTeamViewController *s = [self.instantiator teamsFactory];
        self.teamOneChosen.indexOfPlayers = self.selectedCells;
        [self pushDetailViewController:s animated:YES];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    
    if ([self.dataSource playersForTeam:self.chosenTeam]) {
        return [[self.dataSource playersForTeam:self.chosenTeam] count];
    } else {
        NSLog(@"%@", self.chosenTeam);
        return [[self.dataSource playersForSpecialTeam:self.chosenTeam] count];
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CRTableViewCellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CRTableViewCellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CRTableViewCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    if ([self.dataSource playersForTeam:self.chosenTeam])
        cell.textLabel.text = [[[self.dataSource playersForTeam:self.chosenTeam] objectAtIndex:indexPath.row] objectForKey:@"name"];
    else
        cell.textLabel.text = [[[self.dataSource playersForSpecialTeam:self.chosenTeam] objectAtIndex:indexPath.row] objectForKey:@"name"];
        
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger i = selectedCells.count;
    if (![selectedCells containsObject:[NSNumber numberWithInt:indexPath.row]] && selectedCells.count < 17) {
        [selectedCells addObject:[NSNumber numberWithInt:indexPath.row]];
        NSString *name = [[self.dataSource playersForTeam:self.chosenTeam] objectAtIndex:indexPath.row];
        NSString *number = [[self.dataSource playersForTeam:self.chosenTeam] objectAtIndex:indexPath.row];
        
        if (!name && !number) {
            name = [[self.dataSource playersForSpecialTeam:self.chosenTeam] objectAtIndex:indexPath.row];
            number = [[self.dataSource playersForSpecialTeam:self.chosenTeam] objectAtIndex:indexPath.row];
        }
        
        [self.selectedPlayers setValue:name forKey:number];
    }
    if (selectedCells.count == i)
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [playersLeft setText:[NSString stringWithFormat:@"%d",11-selectedCells.count]];
    if (selectedCells.count >= 11) {
        [doneButton setHidden:NO];
        [playersLeft setHidden:YES];
    } else {
        [playersLeft setHidden:NO];
        [doneButton setHidden:YES];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([selectedCells containsObject:[NSNumber numberWithInt:indexPath.row]]) {
        [selectedCells removeObject:[NSNumber numberWithInt:indexPath.row]];
        [self.selectedPlayers removeObjectForKey:[[self.dataSource playersForTeam:self.chosenTeam] objectAtIndex:indexPath.row]];
    }
    [playersLeft setText:[NSString stringWithFormat:@"%d",11-selectedCells.count]];
    if (selectedCells.count >= 11) {
        [doneButton setHidden:NO];
        [playersLeft setHidden:YES];
    } else {
        [playersLeft setHidden:NO];
        [doneButton setHidden:YES];
    }
}

- (void)setTeamPlayers:(NSDictionary *)players {
    self.selectedPlayers = [NSMutableDictionary dictionaryWithDictionary:players];
}

- (NSDictionary *)getTeamPlayers {
    return self.selectedPlayers;
}



@end
