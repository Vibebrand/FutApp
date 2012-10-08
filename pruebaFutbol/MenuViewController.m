//
//  MenuViewController.m
//  FutApp
//
//  Created by Ivo on 10/8/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import "MenuViewController.h"
#import "AwesomeMenuItem.h"

typedef enum {
    Elegir_equipos = 0,
    Seleccion_mexicana = 1,
    Modo_libre = 2
    } GameModes;

@interface MenuViewController ()

@end

@implementation MenuViewController

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
    UIImage *storyMenuItemImage = [UIImage imageNamed:@"bg-menuitem.png"];
    UIImage *storyMenuitemImagePressed = [UIImage imageNamed:@"bg-menuitem-highlighted.png"];
    UIImage *starImage = [UIImage imageNamed:@"icon-star.png"];
    AwesomeMenuItem *menuItem1 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage highlightedImage:storyMenuItemImage ContentImage:starImage highlightedContentImage:nil];
    AwesomeMenuItem *menuItem2 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage highlightedImage:storyMenuitemImagePressed ContentImage:starImage highlightedContentImage:nil];
    AwesomeMenuItem *menuItem3 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage highlightedImage:storyMenuitemImagePressed ContentImage:starImage highlightedContentImage:nil];
    NSArray *menus = [NSArray arrayWithObjects:menuItem1, menuItem2, menuItem3, nil];
    [menuItem1 release];
    [menuItem2 release];
    
    AwesomeMenu *menu = [[AwesomeMenu alloc] initWithFrame:self.view.bounds menus:menus];
    [menu setDelegate:self];
    menu.startPoint = CGPointMake(30, [[UIScreen mainScreen] bounds].size.width - 50);
    menu.menuWholeAngle = M_PI_2;
    [self.view addSubview:menu];
    [menu release];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)AwesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx {
    switch (idx) {
        case Elegir_equipos:
            //TODO
            break;
            
        case Seleccion_mexicana:
            //TODO
            break;
        
        case Modo_libre:
            //TODO
            break;
            
        default:
            break;
    }
}

@end
