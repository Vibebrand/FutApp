//
//  MasterController.m
//  FutApp
//
//  Created by Ivo on 10/8/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import "MasterController.h"
#import "ViewController.h"

typedef enum {
    Elegir_equipos = 0,
    Seleccion_mexicana = 1,
    Modo_libre = 2
} GameModes;

@implementation MasterController

@synthesize navigator, cancha, logger;

- (ViewController *)cancha {
    if (!cancha) {
        cancha = [[ViewController alloc] init];
    }
    return cancha;
}

- (void)willchangeToOption:(int)index
{
    switch (index) {
        case Elegir_equipos:
            [self.navigator pushViewController:self.cancha animated:YES];
            break;
            
        case Seleccion_mexicana:
            break;
            
        case Modo_libre:
            break;
            
        default:
            break;
    }
}

@end
