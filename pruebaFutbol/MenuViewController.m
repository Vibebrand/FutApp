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
    UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width)];
    background.image = [UIImage imageNamed:@"background.jpg"];
    [self.view addSubview:background];
    [background release];
        
    UIButton *oneTeam = [UIButton buttonWithType:UIButtonTypeCustom];
    oneTeam.frame = CGRectMake(340, 450, 104, 104);
    [oneTeam addTarget:self action:@selector(oneTeamButtonClicked) forControlEvents:UIControlEventTouchDown];
    [oneTeam setImage:[UIImage imageNamed:@"oneteamButton.png"] forState:UIControlStateNormal];
    [self.view addSubview:oneTeam];
    [oneTeam release];
    
    UIButton *twoTeams = [UIButton buttonWithType:UIButtonTypeCustom];
    twoTeams.frame = CGRectMake(578, 450, 104, 104);
    [twoTeams addTarget:self action:@selector(twoTeamsButtonClicked) forControlEvents:UIControlEventTouchDown];
    [twoTeams setImage:[UIImage imageNamed:@"teambutton.png"] forState:UIControlStateNormal];
    [self.view addSubview:twoTeams];
    [twoTeams release];
    
    UIButton *nationalTeam = [UIButton buttonWithType:UIButtonTypeCustom];
    nationalTeam.frame = CGRectMake(454, 445, 114, 114);
    [nationalTeam addTarget:self action:@selector(nationalTeamButtonClicked) forControlEvents:UIControlEventTouchDown];
    [nationalTeam setImage:[UIImage imageNamed:@"seleccion.png"] forState:UIControlStateNormal];
    [self.view addSubview:nationalTeam];
    [nationalTeam release];
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

- (void)nationalTeamButtonClicked {
    [flowManager willchangeToOption:2];
}



@end
