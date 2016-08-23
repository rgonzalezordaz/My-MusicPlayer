//
//  AlbumDetailViewController.h
//  MyMusicPlayer
//
//  Created by Ricardo Gonzalez on 22/08/16.
//  Copyright © 2016 RGO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "AlbumsViewController.h"
#import "AlbumsCell.h"
#import "SongsCell.h"


@interface AlbumDetailViewController : UITableViewController
{
    NSString *albumTitle;
}

@property NSString *albumTitle;


@end
