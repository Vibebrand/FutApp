//
//  TeamInfoDataSource.m
//  FutApp
//
//  Created by Ivo on 10/10/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import "TeamInfoDataSource.h"

@implementation TeamInfoDataSource

@synthesize teamsInfo;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (![teamsInfo numberOfTeams])
        return [teamsInfo numberOfTeams];
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        [cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:17.0]];
        [cell.textLabel setTextColor: [UIColor colorWithRed:0.894117 green:0.839215 blue:0.788235 alpha:1.0]];
        [cell.textLabel setShadowColor: [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.75]];
        [cell.textLabel setShadowOffset:CGSizeMake(0.0, 1.0)];
        
    }
    
    NSString *name = (NSString *)[[teamsInfo teamsNames] objectAtIndex:indexPath.row];
    NSString *image = (NSString *)[[teamsInfo teamsImages] objectAtIndex:indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:image];
    cell.textLabel.text = name;
    
    return cell;
}

@end
