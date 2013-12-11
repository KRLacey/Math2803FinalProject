//
//  SplashViewController.m
//  MATH2803
//
//  Created by Kevin Lacey on 12/9/13.
//  Copyright (c) 2013 KRL. All rights reserved.
//

#import "SplashViewController.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)startNowButtonPressed:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    
    UINavigationController *navController = [storyboard instantiateViewControllerWithIdentifier:@"RootMenu"];
    
    [UIApplication sharedApplication].delegate.window.rootViewController = navController;
}

@end
