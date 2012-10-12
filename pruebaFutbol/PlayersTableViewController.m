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

#import "TeamInfoServiceArray.h"

@interface PlayersTableViewController ()

@end

@implementation PlayersTableViewController

@synthesize playersInfo, instantiator, isFinal;

- (id)init
{
    self = [super init];
    if (self) {
        selectedMarks = [NSMutableArray new];
        self.playersInfo = nil;
        self.instantiator = nil;
        self.isFinal = NO;
        selectedCells = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     
    [self addLeftBorderShadowWithWidth:20.0 andOffset:0.0f];
    
    UIImageView* header = [[UIImageView alloc] initWithFrame: CGRectMake(0.0, 0.0, self.view.bounds.size.width, 45.0)];
    [header setImage: [UIImage imageNamed:@"ToolBar_479x45.png"]];
    
    doneButton = [UIButton buttonWithType:UIBarButtonItemStyleBordered];
    [doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [doneButton setBackgroundImage:[UIImage imageNamed:@"ToolBar_479x45.png"] forState:UIControlStateNormal];
    doneButton.frame = CGRectMake(400, 8, 70, 30);
    [doneButton addTarget:self action:@selector(doneButtonClicked:) forControlEvents:UIControlEventTouchDown];
    [header addSubview:doneButton];
    [self.segmentedView setHeaderView:header];
    [doneButton setHidden:YES];
    
    [self setShowRoundedCorners: YES];
    self.tableView.allowsMultipleSelection = YES;
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doneButtonClicked: (UIButton *)sender {
    if (isFinal) {
        [self.flowManager toField];
    } else {
        [doneButton setHidden:YES];
        SecondTeamViewController *s = [self.instantiator teamsFactory];
        [self pushDetailViewController:s animated:YES];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [playersInfo numberOfPlayersInSelectedTeam];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CRTableViewCellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CRTableViewCellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CRTableViewCellIdentifier];
    }
    
    NSString *text = [[[self.playersInfo playersOfSelectedTeam] allValues] objectAtIndex:indexPath.row];
    cell.textLabel.text = text;
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (cell.isSelected) {
        selectedCells--;
    } else {
        selectedCells++;
    }
    [doneButton setHidden: (selectedCells==11) ? NO : YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    NSString *selectedPlayer = [[[self.playersInfo playersOfSelectedTeam] allValues] objectAtIndex:indexPath.row];
    ProfileViewController *profile = [self.instantiator profileFactory:selectedPlayer];
    [self pushDetailViewController:profile animated:YES];
}

@end
