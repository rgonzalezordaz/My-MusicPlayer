//
//  AlbumsViewController.m
//  MyMusicPlayer
//
//  Created by Ricardo Gonzalez on 22/08/16.
//  Copyright © 2016 RGO. All rights reserved.
//

#import "AlbumsViewController.h"

@interface AlbumsViewController ()

@end

@implementation AlbumsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    AlbumsCell *cell = (AlbumsCell *)[tableView dequeueReusableCellWithIdentifier:@"AlbumsCell"];
    
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"AlbumsCell" bundle:nil] forCellReuseIdentifier:@"AlbumsCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"AlbumsCell"];
    }
    MPMediaQuery *albumsQuery = [MPMediaQuery albumsQuery];
    NSArray *albums = [albumsQuery collections];
    
    MPMediaItem *rowItem = [[albums objectAtIndex:indexPath.row] representativeItem];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = [rowItem valueForProperty:MPMediaItemPropertyAlbumTitle];
    cell.detailTextLabel.text = [rowItem valueForProperty:MPMediaItemPropertyAlbumArtist];
    
    MPMediaItemArtwork *artwork = [rowItem valueForProperty:MPMediaItemPropertyArtwork];
    
    UIImage *artworkImage = [artwork imageWithSize: CGSizeMake (44, 44)];
   /*
    if (artworkImage) {
        cell.imageView.image = artworkImage;
    } else {
        cell.imageView.image = [UIImage imageNamed:@"No-artwork-albums.png"];
    }
    
    
    */
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
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
