//
//  AlbumDetailViewController.m
//  MyMusicPlayer
//
//  Created by Ricardo Gonzalez on 22/08/16.
//  Copyright © 2016 RGO. All rights reserved.
//

#import "AlbumDetailViewController.h"

@interface AlbumDetailViewController ()

@end

@implementation AlbumDetailViewController
@synthesize albumTitle;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = albumTitle;
}

- (UIImage *) getAlbumArtworkWithSize: (CGSize) albumSize
{
    MPMediaQuery *albumQuery = [MPMediaQuery albumsQuery];
    MPMediaPropertyPredicate *albumPredicate = [MPMediaPropertyPredicate predicateWithValue: albumTitle forProperty: MPMediaItemPropertyAlbumTitle];
    [albumQuery addFilterPredicate:albumPredicate];
    NSArray *albumTracks = [albumQuery items];
    
    for (int i = 0; i < [albumTracks count]; i++) {
        
        MPMediaItem *mediaItem = [albumTracks objectAtIndex:i];
        UIImage *artworkImage;
        
        MPMediaItemArtwork *artwork = [mediaItem valueForProperty: MPMediaItemPropertyArtwork];
        artworkImage = [artwork imageWithSize: CGSizeMake (1, 1)];
        
        if (artworkImage) {
            artworkImage = [artwork imageWithSize:albumSize];
            return artworkImage;
        }
        
    }
    
    return [UIImage imageNamed:@"No-artwork-album.png"];
}

- (NSString *) getAlbumArtist
{
    MPMediaQuery *albumQuery = [MPMediaQuery albumsQuery];
    MPMediaPropertyPredicate *albumPredicate = [MPMediaPropertyPredicate predicateWithValue: albumTitle forProperty: MPMediaItemPropertyAlbumTitle];
    [albumQuery addFilterPredicate:albumPredicate];
    NSArray *albumTracks = [albumQuery items];
    
    for (int i = 0 ; i < [albumTracks count]; i++) {
        
        NSString *albumArtist = [[[albumTracks objectAtIndex:0] representativeItem] valueForProperty:MPMediaItemPropertyAlbumArtist];
        
        if (albumArtist) {
            return albumArtist;
        }
    }
    
    return @"Unknown artist";
}

- (NSString *) getAlbumInfo
{
    MPMediaQuery *albumQuery = [MPMediaQuery albumsQuery];
    MPMediaPropertyPredicate *albumPredicate = [MPMediaPropertyPredicate predicateWithValue: albumTitle forProperty: MPMediaItemPropertyAlbumTitle];
    [albumQuery addFilterPredicate:albumPredicate];
    NSArray *albumTracks = [albumQuery items];
    
    
    NSString *trackCount;
    
    if ([albumTracks count] > 1) {
        trackCount = [NSString stringWithFormat:@"%lu Songs", (unsigned long)[albumTracks count]];
    } else {
        trackCount = [NSString stringWithFormat:@"1 Song"];
    }
    
    long playbackDuration = 0;
    
    for (MPMediaItem *track in albumTracks)
    {
        playbackDuration += [[track  valueForProperty:MPMediaItemPropertyPlaybackDuration] longValue];
    }
    
    int albumMimutes = (playbackDuration /60);
    NSString *albumDuration;
    
    if (albumMimutes > 1) {
        albumDuration = [NSString stringWithFormat:@"%i Mins.", albumMimutes];
    } else {
        albumDuration = [NSString stringWithFormat:@"1 Min."];
    }
    
    return [NSString stringWithFormat:@"%@, %@", trackCount, albumDuration];
    
}

- (BOOL) sameArtists
{
    MPMediaQuery *albumQuery = [MPMediaQuery albumsQuery];
    MPMediaPropertyPredicate *albumPredicate = [MPMediaPropertyPredicate predicateWithValue: albumTitle forProperty: MPMediaItemPropertyAlbumTitle];
    [albumQuery addFilterPredicate:albumPredicate];
    NSArray *albumTracks = [albumQuery items];
    
    for (int i = 0 ; i < [albumTracks count]; i++) {
        
        if ([[[[albumTracks objectAtIndex:0] representativeItem] valueForProperty:MPMediaItemPropertyArtist] isEqualToString:[[[albumTracks objectAtIndex:i] representativeItem] valueForProperty:MPMediaItemPropertyArtist]]) {
        } else {
            return NO;
        }
    }
    
    return YES;
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
    MPMediaQuery *albumQuery = [MPMediaQuery albumsQuery];
    
    MPMediaPropertyPredicate *albumPredicate = [MPMediaPropertyPredicate predicateWithValue: albumTitle forProperty: MPMediaItemPropertyAlbumTitle];
    [albumQuery addFilterPredicate:albumPredicate];
    
    NSArray *albumTracks = [albumQuery items];
    
    return [albumTracks count] +1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if ([indexPath row] == 0) {
        return 120;
    } else {
        return 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if ([indexPath row] == 0) {
        AlbumsCell *cell = (AlbumsCell *)[tableView dequeueReusableCellWithIdentifier:@"AlbumsCell"];
        
        if (cell == nil) {
            [tableView registerNib:[UINib nibWithNibName:@"AlbumsCell" bundle:nil] forCellReuseIdentifier:@"AlbumsCell"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"AlbumsCell"];
        }
        
        UIImageView *albumArtworkImageView = (UIImageView *)[cell Imagen];
        albumArtworkImageView.image = [self getAlbumArtworkWithSize:albumArtworkImageView.frame.size];
        
        UILabel *albumArtistLabel = (UILabel *)[cell viewWithTag:101];
        albumArtistLabel.text = [self getAlbumArtist];
        
        UILabel *albumInfoLabel = (UILabel *)[cell viewWithTag:102];
        albumInfoLabel.text = [self getAlbumInfo];
        
        return cell;
    } else {
        
    SongsCell *cell = (SongsCell *)[tableView dequeueReusableCellWithIdentifier:@"SongsCell"];
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"SongsCell" bundle:nil] forCellReuseIdentifier:@"SongsCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"SongsCell"];
    }
        MPMediaQuery *albumQuery = [MPMediaQuery albumsQuery];
        MPMediaPropertyPredicate *albumPredicate = [MPMediaPropertyPredicate predicateWithValue: albumTitle forProperty: MPMediaItemPropertyAlbumTitle];
        [albumQuery addFilterPredicate:albumPredicate];
        NSArray *albumTracks = [albumQuery items];
        
        NSUInteger trackNumber = [[[albumTracks objectAtIndex:(indexPath.row - 1)]  valueForProperty:MPMediaItemPropertyAlbumTrackNumber] unsignedIntegerValue];
        cell.textLabel.textColor = [UIColor whiteColor];
        if (trackNumber) {
            cell.textLabel.text = [NSString stringWithFormat:@"%lu. %@", (unsigned long)trackNumber, [[[albumTracks objectAtIndex:(indexPath.row -1)] representativeItem] valueForProperty:MPMediaItemPropertyTitle]];
        } else {
            cell.textLabel.text = [[[albumTracks objectAtIndex:(indexPath.row - 1)] representativeItem] valueForProperty:MPMediaItemPropertyTitle];
        }
        
        
        if ([self sameArtists]) {
            
            cell.detailTextLabel.text = @"";
            
        } else {
            
            if ([[[albumTracks objectAtIndex:(indexPath.row -1)] representativeItem] valueForProperty:MPMediaItemPropertyArtist]) {
                cell.detailTextLabel.text = [[[albumTracks objectAtIndex:(indexPath.row -1) ] representativeItem] valueForProperty:MPMediaItemPropertyArtist];
            } else {
                cell.detailTextLabel.text = @"";
            }
            
        }
        
        return cell;
}
}

#pragma mark - Navigation


@end
