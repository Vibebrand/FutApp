//
//  CustomCLSplitCascadeViewController.m
//  FutApp
//
//  Created by Ivo on 10/24/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import "CustomCLSplitCascadeViewController.h"
#import "CLCascadeNavigationController.h"

@interface CustomCLSplitCascadeViewController ()

@end

@implementation CustomCLSplitCascadeViewController

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
    tutorial = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"popup1.png"]];
    tutorial.frame = CGRectMake([[UIScreen mainScreen] bounds].size.height/2-80, 300, 427, 126);
    okTutorial = [UIButton buttonWithType:UIButtonTypeCustom];
    [okTutorial setImage:[UIImage imageNamed:@"ok1.png"] forState:UIControlStateNormal];
    okTutorial.frame = CGRectMake(tutorial.frame.origin.x + tutorial.frame.size.width/2 - 74, tutorial.frame.origin.y + 70, 118, 38);
    [okTutorial addTarget:self action:@selector(hideTutorial) forControlEvents:UIControlEventTouchDown];
    [tutorial setUserInteractionEnabled:YES];
    [okTutorial setUserInteractionEnabled:YES];
    [self.view setUserInteractionEnabled:YES];
    [self.cascadeNavigationController.view addSubview:tutorial];
    [self.cascadeNavigationController.view addSubview:okTutorial];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [tutorial release];
    [okTutorial release];   
    [super dealloc];
}

- (void)hideTutorial {
    [okTutorial setHidden:YES];
    [tutorial setHidden:YES];
}

@end
