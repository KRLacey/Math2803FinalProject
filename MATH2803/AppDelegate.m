//
//  AppDelegate.m
//  MATH2803
//
//  Created by Kevin Lacey on 12/8/13.
//  Copyright (c) 2013 KRL. All rights reserved.
//

#import "AppDelegate.h"
#import "DataHold.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    DataHold *sharedRepository = [[DataHold alloc] init];
    
    sharedRepository.greenColor = [UIColor colorWithRed:113.0/255.0f green:194.0/255.0f blue:179.0/255.0f alpha:1.0f];
    sharedRepository.redColor = [UIColor colorWithRed:239.0/255.0f green:73.0/255.0f blue:58.0/255.0f alpha:1.0f];
    sharedRepository.difficulty = 0;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *instance = [defaults objectForKey:@"firstLaunchSetup"];
    
    NSMutableArray *initialScores = [[NSMutableArray alloc] init];
    
    if(nil == instance)
    {
        [defaults setObject:@"VALID" forKey:@"firstLaunchSetup"];
        [defaults setObject:initialScores forKey:@"easyTimedScores"];
        [defaults setObject:initialScores forKey:@"mediumTimedScores"];
        [defaults setObject:initialScores forKey:@"advancedTimedScores"];
        [defaults setObject:@"0" forKey:@"freePlayScore"];
        [defaults setObject:@"0" forKey:@"totalPuzzlesSolved"];
        
        [defaults synchronize];
    }
    
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
