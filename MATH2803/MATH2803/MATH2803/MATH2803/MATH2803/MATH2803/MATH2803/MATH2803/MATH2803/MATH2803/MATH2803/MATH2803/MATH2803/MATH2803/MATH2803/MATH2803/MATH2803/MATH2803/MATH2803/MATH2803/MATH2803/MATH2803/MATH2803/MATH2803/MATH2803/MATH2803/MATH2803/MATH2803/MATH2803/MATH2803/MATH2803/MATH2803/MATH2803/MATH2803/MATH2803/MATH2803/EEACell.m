//
//  EEACell.m
//  MATH2803
//
//  Created by Kevin Lacey on 12/9/13.
//  Copyright (c) 2013 KRL. All rights reserved.
//

#import "EEACell.h"

@implementation EEACell

@synthesize isEditing;
@synthesize problemDifficulty;
@synthesize negateLeftButton, negateRightButton;
@synthesize leftValueLabel, quantityLeftValueTextField, rightValueLabel, quantityRightValueTextField, quantityLeftValueLabel, quantityRightValuelabel, remainderLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    problemDifficulty = 1;
    
    quantityLeftValueLabel.hidden = TRUE;
    quantityRightValuelabel.hidden = TRUE;
    
    if(isEditing)
    {
        negateLeftButton.hidden = FALSE;
        negateRightButton.hidden = FALSE;
        
        quantityLeftValueLabel.hidden = TRUE;
        quantityRightValuelabel.hidden = TRUE;
        
        quantityLeftValueTextField.hidden = FALSE;
        quantityRightValueTextField.hidden = FALSE;
    }
    else
    {
        negateLeftButton.hidden = TRUE;
        negateRightButton.hidden = TRUE;
        
        quantityLeftValueTextField.hidden = TRUE;
        quantityRightValueTextField.hidden = TRUE;
        
        quantityLeftValueLabel.hidden = FALSE;
        quantityRightValuelabel.hidden = FALSE;
    }
}

- (IBAction)negateLeftValueButtonPressed:(id)sender
{
    NSString *value = quantityLeftValueTextField.text;
    if([value length] > 0)
    {
        if([[value substringToIndex:1] isEqualToString:@"-"])
        {
            quantityLeftValueTextField.text = [value substringWithRange:NSMakeRange(1, [value length] - 1)];
        }
        else
        {
            quantityLeftValueTextField.text = [@"-" stringByAppendingString:value];
        }
    }
}

- (IBAction)negateRightValueButtonPressed:(id)sender
{
    NSString *value = quantityRightValueTextField.text;
    if([value length] > 0)
    {
        if([[quantityRightValueTextField.text substringToIndex:1] isEqualToString:@"-"])
        {
            quantityRightValueTextField.text = [value substringWithRange:NSMakeRange(1, [value length] - 1)];
        }
        else
        {
            quantityRightValueTextField.text = [@"-" stringByAppendingString:value];
        }
    }
}

@end
