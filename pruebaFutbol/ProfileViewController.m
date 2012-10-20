//
//  ProfileViewController.m
//  FutApp
//
//  Created by Ivo on 10/11/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIViewController+CLSegmentedView.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

@synthesize playerInfo;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
	// add shadow
    [self addLeftBorderShadowWithWidth:40.0 andOffset:0.0f];
    
    // add header view
    UIImageView* header = [[UIImageView alloc] initWithFrame: CGRectMake(0.0, 0.0, self.view.bounds.size.width, 45.0)];
    [header setImage: [UIImage imageNamed:@"navbar.jpg"]];
    [self.segmentedView setHeaderView: header];
    
    [self setShowRoundedCorners:YES];
    UIImageView *photo = [[UIImageView alloc] initWithFrame:CGRectMake(210, 30, 88.0, 88.0)];
    [photo setImage: [UIImage imageNamed: [playerInfo imageOfPlayer]]];
    [self.tableView addSubview:photo];
    [photo release];
    
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.scrollEnabled = NO;
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(30, 148, 400, 20)];
    name.text = [NSString stringWithFormat:@"Nombre: %@", [playerInfo nameOfPlayer]];
    UILabel *number = [[UILabel alloc] initWithFrame:CGRectMake(30, 178, 400, 20)];
    number.text = [NSString stringWithFormat:@"Número: %d", [playerInfo numberOfPlayer]];
    UILabel *position = [[UILabel alloc] initWithFrame:CGRectMake(30, 208, 400, 20)];
    position.text = [NSString stringWithFormat:@"Posición: %@", [playerInfo positionOfPlayer]];
    UILabel *age = [[UILabel alloc] initWithFrame:CGRectMake(30, 238, 400, 20)];
    age.text = [NSString stringWithFormat:@"Edad: %d", [playerInfo ageOfPlayer]];
    UILabel *weight = [[UILabel alloc] initWithFrame:CGRectMake(30, 268, 400, 20)];
    weight.text = [NSString stringWithFormat:@"Peso: %.02f", [playerInfo weightOfPlayer]];
    UILabel *description = [[UILabel alloc] initWithFrame:CGRectMake(30, 308, 400, 400)];
    description.text = [NSString stringWithFormat:@"Descripción: %@", [playerInfo descriptionOfPlayer]];
    description.lineBreakMode = NSLineBreakByWordWrapping;
    description.numberOfLines = 0;
    [self.tableView addSubview:name];
    [name release];
    [self.tableView addSubview:number];
    [number release];
    [self.tableView addSubview:position];
    [position release];
    [self.tableView addSubview:age];
    [age release];
    [self.tableView addSubview:weight];
    [weight release];
    [self.tableView addSubview:description];
    [description release];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
