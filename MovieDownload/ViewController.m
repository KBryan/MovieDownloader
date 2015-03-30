//
//  ViewController.m
//  MovieDownload
//
//  Created by Kwame Bryan on 2015-03-30.
//  Copyright (c) 2015 3e Interactive. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController
- (IBAction)play:(id)sender {
    
    /**
     *  Download Video File
     *
     *  @return downloaded movie
     */
    NSString *basePath = [self applicationDocumentDirectory];
    NSString* filePath = [basePath stringByAppendingString:@"/"];
    filePath = [filePath stringByAppendingString:kMOVIEFILENAME];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:filePath]) {
        MPMoviePlayerViewController *moviePlayer = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL fileURLWithPath:filePath]];
        [self presentMoviePlayerViewControllerAnimated:moviePlayer];
        [moviePlayer.moviePlayer play];
        NSLog(@"File was written");
    } else {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:kMOVIEREMOTELOCATION]];
        _coverView.alpha = 0.0;
        [[NSURLConnection alloc]initWithRequest:request delegate:self];
        NSLog(@"Not Written");
    }
}

/**
 *  Sent when a connection has finished loading successfully.
    The delegate will receive no further messages for connection.
 *
 *  @param connection <#connection description#>
 */
-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSString *basePath = [self applicationDocumentDirectory];
    NSString *filePath = [basePath stringByAppendingString:@"/"];
    filePath = [filePath stringByAppendingString:kMOVIEFILENAME];
    
    if([_recievedData writeToFile:filePath atomically:YES]) NSLog(@"successfully wrote file");
    _coverView.alpha = 0.0;
    
    MPMoviePlayerViewController *mp = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:filePath]];
    [self presentMoviePlayerViewControllerAnimated:mp];
    [mp.moviePlayer play];
    

    
}
/**
 *  Sent when a connection fails to load its request successfully.
 *
 *  @param connection <#connection description#>
 *  @param error      <#error description#>
 */
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    UIAlertView *errorView = [[UIAlertView alloc] init];
    errorView.title = @"Download Failed";
    errorView.message = @"The movie file download failed. Please make sure you are connected to 3G/4G or WiFi.";
    [errorView addButtonWithTitle:@"Dismiss"];
    [errorView show];
    _coverView.alpha = 0.0;
}
/**
 *  Sent when the connection has received sufficient data to construct the URL response for its request.
 *
 *  @param connection <#connection description#>
 *  @param response   <#response description#>
 */
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _recievedData = [[NSMutableData alloc] init];
    contentLength = response.expectedContentLength;
    
}
/**
 *  Sent as a connection loads data incrementally.
 *
 *  @param connection <#connection description#>
 *  @param data       <#data description#>
 */
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_recievedData appendData:data];
    _progressView.progress = (float)[_recievedData length] / (float)contentLength;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _progressView.progress = 0.0;
    _coverView.alpha = 0.0;
}
-(NSString *)applicationDocumentDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* basePath = ([paths count] > 0) ? [paths objectAtIndex:0]:nil;
    return basePath;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
