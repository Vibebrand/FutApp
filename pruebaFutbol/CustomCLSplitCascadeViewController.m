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
    tutorial = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tutorialBueno.png"]];
    tutorial.frame = CGRectMake(294, 430, 720, 258);
    [tutorial setUserInteractionEnabled:YES];
    [self.view setUserInteractionEnabled:YES];
    [self.cascadeNavigationController.view addSubview:tutorial];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [tutorial release];
    [super dealloc];
}

- (void)hideTutorial {
    [tutorial setHidden:YES];
}

@end
