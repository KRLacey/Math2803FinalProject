//
//  GameTableViewCell.h
//  MATH2803
//
//  Created by Kevin Lacey on 12/9/13.
//  Copyright (c) 2013 KRL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameTableViewCell : UITableViewCell
{
    BOOL isEditing;
}

@property BOOL isEditing;

@property (weak, nonatomic) IBOutlet UILabel *largeValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *quantityValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *smallValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainderValueLabel;

@property (weak, nonatomic) IBOutlet UITextField *largeValueTextField;
@property (weak, nonatomic) IBOutlet UITextField *smallValueTextField;
@property (weak, nonatomic) IBOutlet UITextField *remainderValueTextField;



@end
