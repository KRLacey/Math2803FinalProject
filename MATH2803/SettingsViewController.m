//
//  SettingsViewController.m
//  MATH2803
//
//  Created by Kevin Lacey on 12/10/13.
//  Copyright (c) 2013 KRL. All rights reserved.
//

#import "SettingsViewController.h"
#import "DataHold.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController
{
    DataHold *sharedRepository;
}

@synthesize difficultySegmentedControl;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    sharedRepository = [[DataHold alloc] init];
    
    difficultySegmentedControl.selectedSegmentIndex = sharedRepository.difficulty;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)difficultySegmentedControlChanged:(id)sender
{
    sharedRepository.difficulty = difficultySegmentedControl.selectedSegmentIndex;
}

@end
