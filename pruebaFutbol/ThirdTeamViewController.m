//
//  ThirdTeamViewController.m
//  FutApp
//
//  Created by Ivo on 10/23/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import "ThirdTeamViewController.h"
#import "PlayersTableViewController.h"

@interface ThirdTeamViewController ()

@end

@implementation ThirdTeamViewController

@synthesize instantiator, dataSource, flowManager;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    self.instantiator = nil;
    self.dataSource = nil;
    self.flowManager = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        [cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:17.0]];
        [cell.textLabel setShadowOffset:CGSizeMake(0.0, 1.0)];
        
    }
    
    
    UIImage *img;
    NSString *text;
    
    if (!indexPath.row) {
        img = [UIImage imageNamed:[[self.dataSource locals] objectForKey:@"teamImage"]];
        text = [[self.dataSource locals] objectForKey:@"name"];
    } else {
        img = [UIImage imageNamed:[[self.dataSource foreigns] objectForKey:@"teamImage"]];
        text = [[self.dataSource foreigns] objectForKey:@"name"];
    }
    
    if (!img) {
        img = [UIImage imageNamed:@"DefaultTeam.png"];
    }
    
    cell.imageView.image = img;
    cell.textLabel.text = text;
    
    return cell;
}

- (void)backButtonPressed {
    [flowManager backToRootView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [flowManager asignCascadeViewForNational:indexPath.row];
}

@end
