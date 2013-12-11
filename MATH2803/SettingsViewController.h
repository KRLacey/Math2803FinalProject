//
//  SettingsViewController.h
//  MATH2803
//
//  Created by Kevin Lacey on 12/10/13.
//  Copyright (c) 2013 KRL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *difficultySegmentedControl;

- (IBAction)difficultySegmentedControlChanged:(id)sender;

@end
