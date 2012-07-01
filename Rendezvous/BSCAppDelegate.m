//
//  BSCAppDelegate.m
//  Rendezvous
//
//  Created by Bruce Collie on 30/06/2012.
//  Copyright (c) 2012 Balerno High School. All rights reserved.
//

#import "BSCAppDelegate.h"
#import <Parse/Parse.h>
#import "BSCViewController.h"
#import "NSString+MD5.h"
#import "Utilities.h"

@implementation BSCAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"mVi4YTWyPwowDMi65MNilKy6YWJoYrHF5th2CsIY"
                  clientKey:@"sH9EaQuylyjOpMbp20WHkGUImkwXef8nX75Cf9ZW"];
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"userpin"] == nil) {
        double time = [[[NSDate alloc] init] timeIntervalSince1970];
        NSString* pin = [[NSString stringWithFormat:@"%f", time] MD5];
        pin = [NSString stringWithFormat:@"%@%@", pin, [Utilities genRandStringLength:8]];
        pin = [pin substringToIndex:8];
        [defaults setObject:pin forKey:@"userpin"];
        [defaults synchronize];
    }
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[BSCViewController alloc] initWithNibName:@"BSCViewController" bundle:nil];
    UINavigationController* navcon = [[UINavigationController alloc] init];
    navcon.navigationBar.tintColor = UIColorFromRGB(0x0099cc);
    [navcon pushViewController:self.viewController animated:NO];
    self.window.rootViewController = navcon;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
