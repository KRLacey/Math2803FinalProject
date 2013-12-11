//
//  EEACell.h
//  MATH2803
//
//  Created by Kevin Lacey on 12/9/13.
//  Copyright (c) 2013 KRL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EEACell : UITableViewCell
{
    BOOL isEditing;
    int problemDifficulty;
}

@property BOOL isEditing;
@property int problemDifficulty;

@property (weak, nonatomic) IBOutlet UILabel *remainderLabel;

@property (weak, nonatomic) IBOutlet UILabel *quantityLeftValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftValueLabel;

@property (weak, nonatomic) IBOutlet UILabel *quantityRightValuelabel;
@property (weak, nonatomic) IBOutlet UILabel *rightValueLabel;

@property (weak, nonatomic) IBOutlet UITextField *quantityLeftValueTextField;
@property (weak, nonatomic) IBOutlet UITextField *quantityRightValueTextField;

@property (weak, nonatomic) IBOutlet UIButton *negateLeftButton;

@property (weak, nonatomic) IBOutlet UIButton *negateRightButton;

- (IBAction)negateLeftValueButtonPressed:(id)sender;
- (IBAction)negateRightValueButtonPressed:(id)sender;

@end
