//
//  MenuViewController.m
//  FutApp
//
//  Created by Ivo on 10/8/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import "MenuViewController.h"
#import "AwesomeMenuItem.h"
#import "ViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

@synthesize flowManager;

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
    // Do any additional setup after loading the view from its nib.
    UIButton *oneTeam = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [oneTeam setTitle:@"Un equipo" forState:UIControlStateNormal];
    oneTeam.frame = CGRectMake([[UIScreen mainScreen] bounds].size.height - 200, [[UIScreen mainScreen] bounds].size.width - 160, 160, 40);
    [oneTeam addTarget:self action:@selector(oneTeamButtonClicked) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:oneTeam];
    [oneTeam release];
    
    UIButton *twoTeams = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [twoTeams setTitle:@"Dos equipos" forState:UIControlStateNormal];
    twoTeams.frame = CGRectMake([[UIScreen mainScreen] bounds].size.height - 200, [[UIScreen mainScreen] bounds].size.width - 100, 160, 40);
    [twoTeams addTarget:self action:@selector(twoTeamsButtonClicked) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:twoTeams];
    [twoTeams release];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)oneTeamButtonClicked {
    [flowManager willchangeToOption:0];
}

- (void)twoTeamsButtonClicked {
    [flowManager willchangeToOption:1];
}



@end
