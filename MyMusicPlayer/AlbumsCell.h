//
//  AlbumsCell.h
//  MyMusicPlayer
//
//  Created by Ricardo Gonzalez on 22/08/16.
//  Copyright © 2016 RGO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *Imagen;
@property (strong, nonatomic) IBOutlet UILabel *AlbumText;
@property (strong, nonatomic) IBOutlet UILabel *AlbumInfoText;

@end
