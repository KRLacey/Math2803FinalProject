//
//  GameTableViewCell.m
//  MATH2803
//
//  Created by Kevin Lacey on 12/9/13.
//  Copyright (c) 2013 KRL. All rights reserved.
//

#import "GameTableViewCell.h"
#import "DataHold.h"

@implementation GameTableViewCell

@synthesize isEditing;
@synthesize largeValueLabel, quantityValueLabel, smallValueLabel, remainderValueLabel, largeValueTextField, smallValueTextField, remainderValueTextField;

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
    
    int problemDifficulty = [[DataHold alloc] init].difficulty;
    
    largeValueTextField.text = @"";
    smallValueTextField.text = @"";
    remainderValueTextField.text = @"";
    
    largeValueLabel.hidden = TRUE;
    smallValueLabel.hidden = TRUE;
    remainderValueLabel.hidden = TRUE;
    largeValueTextField.hidden = TRUE;
    smallValueTextField.hidden = TRUE;
    remainderValueTextField.hidden = TRUE;

    if(problemDifficulty == 0)
    {
        if(isEditing)
        {
            largeValueLabel.hidden = FALSE;
            smallValueLabel.hidden = FALSE;
            
            remainderValueTextField.hidden = FALSE;
        }
        else
        {
            largeValueLabel.hidden = FALSE;
            smallValueLabel.hidden = FALSE;
            
            remainderValueLabel.hidden = FALSE;
        }
    }
    else if(problemDifficulty == 1)
    {
        if(isEditing)
        {
            smallValueLabel.hidden = FALSE;
            
            remainderValueTextField.hidden = FALSE;
            largeValueTextField.hidden = FALSE;
        }
        else
        {
            smallValueLabel.hidden = FALSE;
            
            remainderValueLabel.hidden = FALSE;
            largeValueLabel.hidden = FALSE;
        }
    }
    else if(problemDifficulty == 2)
    {
        if(isEditing)
        {
            largeValueTextField.hidden = FALSE;
            smallValueTextField.hidden = FALSE;
            remainderValueTextField.hidden = FALSE;
        }
        else
        {
            largeValueLabel.hidden = FALSE;
            smallValueLabel.hidden = FALSE;
            remainderValueLabel.hidden = FALSE;
        }
    }
    
    //[self defineColorScheme];
}

- (void)defineColorScheme
{
    if(!isEditing)
    {
        self.contentView.backgroundColor = [[DataHold alloc] init].greenColor;
        largeValueLabel.textColor = [UIColor whiteColor];
        quantityValueLabel.textColor = [UIColor whiteColor];
        smallValueLabel.textColor = [UIColor whiteColor];
        remainderValueLabel.textColor = [UIColor whiteColor];
    }
    else
    {
        self.contentView.backgroundColor = [UIColor whiteColor];
        largeValueLabel.textColor = [UIColor blackColor];
        quantityValueLabel.textColor = [UIColor blackColor];
        smallValueLabel.textColor = [UIColor blackColor];
        remainderValueLabel.textColor = [UIColor blackColor];
    }
}

@end
