//
//  PlayEEAViewController.h
//  MATH2803
//
//  Created by Kevin Lacey on 12/9/13.
//  Copyright (c) 2013 KRL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayEEAViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>
{
    BOOL timedMode;
}

@property BOOL timedMode;

@property (weak, nonatomic) IBOutlet UILabel *problemDescriptionLabel;

@property (weak, nonatomic) IBOutlet UITableView *gameTableView;

@property (weak, nonatomic) IBOutlet UIButton *checkRowButton;

- (IBAction)checkRowButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIProgressView *progressViewA;
@property (weak, nonatomic) IBOutlet UIProgressView *progressViewB;

@end
