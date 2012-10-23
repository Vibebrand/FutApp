//
//  SecondTeamViewController.m
//  FutApp
//
//  Created by Ivo on 10/12/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import "SecondTeamViewController.h"
#import "PlayersTableViewController.h"

@interface SecondTeamViewController ()

@end

@implementation SecondTeamViewController

@synthesize flowManager, teamsInfo, instantiator;

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
    self.tableView.rowHeight = 88;
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
    if (self.dataSource){
        return [[self.dataSource allData] count];
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
    
    UIImage *img = [UIImage imageNamed:[[[self.dataSource allData] objectAtIndex:indexPath.row] objectForKey:@"teamImage"]];
    
    if (!img) {
        img = [UIImage imageNamed:@"DefaultTeam.png"];
    }
    
    cell.imageView.image = img;
    cell.textLabel.text = [[[self.dataSource allData] objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PlayersTableViewController *players = [self.instantiator playersFactory:indexPath.row];
    [self pushDetailViewController:players animated:YES];
}

@end
