//
//  ViewController.h
//  MovieDownload
//
//  Created by Kwame Bryan on 2015-03-30.
//  Copyright (c) 2015 3e Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController : UIViewController <NSURLConnectionDelegate, NSURLConnectionDataDelegate> {
    long long contentLength;
}
@property (strong, nonatomic) IBOutlet UIProgressView *progressView;

@property (strong,nonatomic) NSMutableData *recievedData;
@property (strong, nonatomic) IBOutlet UIView *coverView;

#define kMOVIEFILENAME @"2.mov"
#define kMOVIEREMOTELOCATION @"http://www.3einteractive.com/Images/2.mov"



@end

