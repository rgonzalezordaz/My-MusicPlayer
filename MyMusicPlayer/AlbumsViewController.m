//
//  AlbumsViewController.m
//  MyMusicPlayer
//
//  Created by Ricardo Gonzalez on 22/08/16.
//  Copyright © 2016 RGO. All rights reserved.
//

#import "AlbumsViewController.h"
#import "AlbumDetailViewController.h"

@interface AlbumsViewController ()

@end

@implementation AlbumsViewController

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

    MPMediaQuery *albumsQuery = [MPMediaQuery albumsQuery];
    NSArray *albums = [albumsQuery collections];
    
    return [albums count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        return 120;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

   AlbumsCell *cell = (AlbumsCell *)[tableView dequeueReusableCellWithIdentifier:@"AlbumsCell"];
    
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"AlbumsCell" bundle:nil] forCellReuseIdentifier:@"AlbumsCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"AlbumsCell"];
    }

    MPMediaQuery *albumsQuery = [MPMediaQuery albumsQuery];
    NSArray *albums = [albumsQuery collections];
    
    MPMediaItem *rowItem = [[albums objectAtIndex:indexPath.row] representativeItem];
    cell.AlbumText.textColor = [UIColor whiteColor];
    cell.AlbumText.text = [rowItem valueForProperty:MPMediaItemPropertyAlbumTitle];
    cell.AlbumInfoText.text = [rowItem valueForProperty:MPMediaItemPropertyAlbumArtist];
    
    MPMediaItemArtwork *artwork = [rowItem valueForProperty:MPMediaItemPropertyArtwork];
    UIImage *artworkImage = [artwork imageWithSize: CGSizeMake (10, 10)];


    if (artworkImage) {
        cell.Imagen.image = artworkImage;
    } else {
        cell.Imagen.image = [UIImage imageNamed:@"No- WorkArt.jpeg"];
    }
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
    [self performSegueWithIdentifier:@"AlbumDetail" sender:self];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    AlbumDetailViewController *detailViewController = [segue destinationViewController];
    
    MPMediaQuery *albumsQuery = [MPMediaQuery albumsQuery];
    NSArray *albums = [albumsQuery collections];
    
    int selectedIndex = [[self.tableView indexPathForSelectedRow] row];
    MPMediaItem *selectedItem = [[albums objectAtIndex:selectedIndex] representativeItem];
    NSString *albumTitle = [selectedItem valueForProperty:MPMediaItemPropertyAlbumTitle];
    
    [detailViewController setAlbumTitle:albumTitle];

}

@end
