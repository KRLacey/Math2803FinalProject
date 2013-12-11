//
//  StatisticsViewController.h
//  MATH2803
//
//  Created by Kevin Lacey on 12/10/13.
//  Copyright (c) 2013 KRL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatisticsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *totalPuzzlesSolvedLabel;

@property (weak, nonatomic) IBOutlet UILabel *totalFreePlayScoreLabel;

@property (weak, nonatomic) IBOutlet UITableView *timedScoresTableView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *difficultySegmentedControl;


- (IBAction)difficultySegmentedControlChanged:(id)sender;

@end
