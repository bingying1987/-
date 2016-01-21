//
//  AppDelegate.m
//  雅思英语
//
//  Created by mac on 16/1/4.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "AppDelegate.h"
#import "SMS_SDK/SMSSDK.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface AppDelegate ()
@end

@implementation AppDelegate
@synthesize ph_num;
@synthesize ph_pw;
@synthesize _isMovieFullScreen;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [NSThread sleepForTimeInterval:3.0f];
    
     [SMSSDK registerApp:@"e3c7de0c0318" withSecret:@"899d7c1632db04a532e3850a6d4275b7"];
    
    /*
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willEnterFullScreen:) name:MPMoviePlayerWillEnterFullscreenNotification
                                                     object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willExitFullScreen:) name:MPMoviePlayerWillExitFullscreenNotification
                            object:nil];
    */
    return YES;
}

- (void)willEnterFullScreen:(NSNotification *)notification
{
    NSLog(@"screen full");
    _isMovieFullScreen = YES;
}

- (void)willExitFullScreen:(NSNotification *)notification
{
    NSLog(@"screen no full");
    _isMovieFullScreen = NO;
}

/*
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if (_isMovieFullScreen) {
        return UIInterfaceOrientationMaskAll;
    }
    else
    {
        return UIInterfaceOrientationMaskPortrait;
    }
    
}
*/

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
