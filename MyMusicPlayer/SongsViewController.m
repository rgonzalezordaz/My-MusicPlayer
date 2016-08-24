//
//  SongsViewController.m
//  MyMusicPlayer
//
//  Created by Ricardo Gonzalez on 21/08/16.
//  Copyright © 2016 RGO. All rights reserved.
//

#import "SongsViewController.h"

@interface SongsViewController ()

@end

@implementation SongsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    MPMediaQuery *songsQuery = [MPMediaQuery songsQuery];
    NSArray *songs = [songsQuery items];
    
    return [songs count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
SongsCell *cell = (SongsCell *)[tableView dequeueReusableCellWithIdentifier:@"SongsCell"];
    
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"SongsCell" bundle:nil] forCellReuseIdentifier:@"SongsCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"SongsCell"];
    }
 
 // Configure the cell...
 
 MPMediaQuery *songsQuery = [MPMediaQuery songsQuery];
 NSArray *songs = [songsQuery items];
 
 MPMediaItem *rowItem = [songs objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
 cell.textLabel.text = [rowItem valueForProperty:MPMediaItemPropertyTitle];
 cell.detailTextLabel.text = [rowItem valueForProperty:MPMediaItemPropertyArtist];
 
 return cell;
 
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    //1. Setup the CATransform3D structure
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
    rotation.m34 = 1.0/ -600;
    
    //2. Define the initial state (Before the animation)
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    
    cell.layer.transform = rotation;
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    //3. Define the final state (After the animation) and commit the animation
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.4];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    
    //Reassure that cell its in its place (WaGo)
    cell.frame = CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
    [UIView commitAnimations];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MPMediaQuery *songsQuery = [MPMediaQuery songsQuery];
    NSArray *songs = [songsQuery items];
    
    int selectedIndex = [[self.tableView indexPathForSelectedRow] row];
    
    MPMediaItem *selectedItem = [[songs objectAtIndex:selectedIndex] representativeItem];
    
    MPMusicPlayerController *musicPlayer = [MPMusicPlayerController iPodMusicPlayer];
    
    [musicPlayer setQueueWithItemCollection:[MPMediaItemCollection collectionWithItems:[songsQuery items]]];
    [musicPlayer setNowPlayingItem:selectedItem];
    
    [musicPlayer play];
    
}

@end
