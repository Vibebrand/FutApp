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

@synthesize  flowManager, dataSource;


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
    [flowManager asignCascadeView:indexPath.row];
}

- (void)backButtonPressed {
    [flowManager backToRootView];
}

@end
