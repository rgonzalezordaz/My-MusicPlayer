//
//  PlayingViewController.m
//  MyMusicPlayer
//
//  Created by Ricardo Gonzalez on 25/08/16.
//  Copyright © 2016 RGO. All rights reserved.
//

#import "PlayingViewController.h"

@interface PlayingViewController ()

@end

@implementation PlayingViewController

@synthesize musicPlayer;


- (void)viewDidLoad {
    [super viewDidLoad];
    musicPlayer = [MPMusicPlayerController systemMusicPlayer];
    [self registerMediaPlayerNotifications];
    
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = backButton;
    self.Repetir = NO;
    self.Shuffle = NO;
    // Do any additional setup after loading the view.
}
- (void) back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    // update control button
    
    if ([musicPlayer playbackState] == MPMusicPlaybackStatePlaying) {
        
        [playPauseButton setImage:[UIImage imageNamed:@"Pause-icon.png"] forState:UIControlStateNormal];
    } else {
        [playPauseButton setImage:[UIImage imageNamed:@"Play-icon.png"] forState:UIControlStateNormal];
    }
    
    
    // Update volume slider
    
    [volumeSlider setValue:[musicPlayer volume]];
    
    
    // Update now playing info
    
    MPMediaItem *currentItem = [musicPlayer nowPlayingItem];
    
    MPMediaItemArtwork *artwork = [currentItem valueForProperty: MPMediaItemPropertyArtwork];
    UIImage *artworkImage = [artwork imageWithSize: CGSizeMake (320, 320)];
    
    if (!artworkImage) {
        artworkImage = [UIImage imageNamed:@"No- WorkArt.jpeg"];
    }
    
    [artworkImageView setImage:artworkImage];
    
    
    NSString *titleString = [currentItem valueForProperty:MPMediaItemPropertyTitle];
    if (titleString) {
        titleLabel.text = titleString;
    } else {
        titleLabel.text = @"Unknown title";
    }
    
    NSString *artistString = [currentItem valueForProperty:MPMediaItemPropertyArtist];
    if (artistString) {
        artistLabel.text = artistString;
    } else {
        artistLabel.text = @"Unknown artist";
    }
    
    NSString *albumString = [currentItem valueForProperty:MPMediaItemPropertyAlbumTitle];
    if (albumString) {
        albumLabel.text = albumString;
    } else {
        albumLabel.text = @"Unknown album";
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: MPMusicPlayerControllerNowPlayingItemDidChangeNotification
                                                  object: musicPlayer];
    
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: MPMusicPlayerControllerPlaybackStateDidChangeNotification
                                                  object: musicPlayer];
    
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: MPMusicPlayerControllerVolumeDidChangeNotification
                                                  object: musicPlayer];
    
    [musicPlayer endGeneratingPlaybackNotifications];

}

- (void) registerMediaPlayerNotifications
{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter addObserver: self
                           selector: @selector (handle_NowPlayingItemChanged:)
                               name: MPMusicPlayerControllerNowPlayingItemDidChangeNotification
                             object: musicPlayer];
    
    [notificationCenter addObserver: self
                           selector: @selector (handle_PlaybackStateChanged:)
                               name: MPMusicPlayerControllerPlaybackStateDidChangeNotification
                             object: musicPlayer];
    
    [notificationCenter addObserver: self
                           selector: @selector (handle_VolumeChanged:)
                               name: MPMusicPlayerControllerVolumeDidChangeNotification
                             object: musicPlayer];
    
    [musicPlayer beginGeneratingPlaybackNotifications];
}

- (IBAction)RepeatBtnPressed:(id)sender {
    if (self.Repetir == NO){
        self.Repetir = YES;
        self.Shuffle = NO;
        musicPlayer.repeatMode = 2;
        musicPlayer.shuffleMode = 0;
        lblStatus.text = @"RepeatOn";
    } else if(self.Repetir == YES){
        self.Repetir = NO;
        musicPlayer.repeatMode = 0;
        lblStatus.text = @"";
    }
}

- (IBAction)ShuffleBtnPressed:(id)sender {
    if (self.Shuffle == NO){
        self.Shuffle = YES;
        self.Repetir = NO;
        musicPlayer.repeatMode = 0;
        musicPlayer.shuffleMode = 2;
        lblStatus.text = @"ShuffleOn";
    } else if(self.Shuffle == YES){
        self.Shuffle = NO;
        musicPlayer.shuffleMode = 0;
        lblStatus.text = @"";
    }
}
- (void) handle_NowPlayingItemChanged: (id) notification
{
    
    if ([musicPlayer playbackState] != MPMusicPlaybackStateStopped) {
        MPMediaItem *currentItem = [musicPlayer nowPlayingItem];
        
        MPMediaItemArtwork *artwork = [currentItem valueForProperty: MPMediaItemPropertyArtwork];
        UIImage *artworkImage = [artwork imageWithSize: CGSizeMake (320, 320)];
        
        if (!artworkImage) {
            artworkImage = [UIImage imageNamed:@"IconoMyMusicPlayer.png"];
        }
        
        [artworkImageView setImage:artworkImage];
        
        NSString *titleString = [currentItem valueForProperty:MPMediaItemPropertyTitle];
        if (titleString) {
            titleLabel.text = titleString;
        } else {
            titleLabel.text = @"Unknown title";
        }
        
        NSString *artistString = [currentItem valueForProperty:MPMediaItemPropertyArtist];
        if (artistString) {
            artistLabel.text = artistString;
        } else {
            artistLabel.text = @"Unknown artist";
        }
        
        NSString *albumString = [currentItem valueForProperty:MPMediaItemPropertyAlbumTitle];
        if (albumString) {
            albumLabel.text = albumString;
        } else {
            albumLabel.text = @"Unknown album";
        }
        
    }
}
- (void) handle_PlaybackStateChanged: (id) notification
{
    MPMusicPlaybackState playbackState = [musicPlayer playbackState];
    
    if (playbackState == MPMusicPlaybackStatePaused) {
        [playPauseButton setImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
        
        
    } else if (playbackState == MPMusicPlaybackStatePlaying) {
        [playPauseButton setImage:[UIImage imageNamed:@"Pause.png"] forState:UIControlStateNormal];
        
    } else if (playbackState == MPMusicPlaybackStateStopped) {
        
        [playPauseButton setImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
        [musicPlayer stop];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}
- (void) handle_VolumeChanged: (id) notification
{
    [volumeSlider setValue:[musicPlayer volume]];
}
- (IBAction)playPause:(id)sender
{
    if ([musicPlayer playbackState] == MPMusicPlaybackStatePlaying) {
        [musicPlayer pause];
        
    } else {
        [musicPlayer play];
    }
}

- (IBAction)nextSong:(id)sender
{
    [musicPlayer skipToNextItem];
}

- (IBAction)previousSong:(id)sender
{
    [musicPlayer skipToPreviousItem];
}

- (IBAction)volumeSliderChanged:(id)sender
{
    [musicPlayer setVolume:volumeSlider.value];
}
@end
