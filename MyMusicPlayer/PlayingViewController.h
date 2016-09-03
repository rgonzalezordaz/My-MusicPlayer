//
//  PlayingViewController.h
//  MyMusicPlayer
//
//  Created by Ricardo Gonzalez on 25/08/16.
//  Copyright © 2016 RGO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "Declarations.h"


@interface PlayingViewController : UIViewController

{
    MPMusicPlayerController *musiPlayer;
    
    IBOutlet UIImageView *artworkImageView;
    
    IBOutlet UIButton *playPauseButton;
    IBOutlet UISlider *volumeSlider;
    
    IBOutlet UILabel *artistLabel;
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *albumLabel;
    
    IBOutlet UILabel *lblStatus;
    IBOutlet UIButton *RepeatBtn;
    
    IBOutlet UIButton *ShuffleBtn;
}


@property (nonatomic, retain) MPMusicPlayerController *musicPlayer;

- (IBAction)playPause:(id)sender;
- (IBAction)nextSong:(id)sender;
- (IBAction)previousSong:(id)sender;
- (IBAction)volumeSliderChanged:(id)sender;

- (void) registerMediaPlayerNotifications;
- (IBAction)RepeatBtnPressed:(id)sender;
- (IBAction)ShuffleBtnPressed:(id)sender;


@end
