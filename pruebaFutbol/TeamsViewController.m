//
//  TeamsViewController.m
//  FutApp
//
//  Created by Ivo on 10/10/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import "TeamsViewController.h"
#import "TeamInfoServiceArray.h"
#import "UIViewController+CLSegmentedView.h"

@interface TeamsViewController ()

@end

@implementation TeamsViewController

@synthesize teamsInfo, flowManager;

- (id<ITeamInfoService>)teamsInfo {
    if (!teamsInfo) {
        teamsInfo = [[TeamInfoServiceArray alloc] init];
    }
    return teamsInfo;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.tableView.rowHeight = 88;
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchDown];
    backButton.frame = CGRectMake(10, 8, 60, 35);
    [backButton setBackgroundImage:[UIImage imageNamed:@"backupbutton.png"] forState:UIControlStateNormal];
    [self.view addSubview:backButton];
    [backButton release];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.teamsInfo){
        return [self.teamsInfo numberOfTeams];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        [cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:17.0]];
        [cell.textLabel setTextColor: [UIColor colorWithRed:0.894117 green:0.839215 blue:0.788235 alpha:1.0]];
      //  [cell.textLabel setShadowColor: [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.75]];
        [cell.textLabel setShadowOffset:CGSizeMake(0.0, 1.0)];
        
    }
    
    NSString *name = (NSString *)[[self.teamsInfo teamsNames] objectAtIndex:indexPath.row];
    NSString *image = (NSString *)[[self.teamsInfo teamsImages] objectAtIndex:indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:image];
    cell.textLabel.text = name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [flowManager asignCascadeView:indexPath.row];
}

- (void)backButtonPressed {
    [flowManager backToRootView];
}

@end
