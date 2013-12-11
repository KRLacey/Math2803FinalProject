//
//  StatisticsViewController.m
//  MATH2803
//
//  Created by Kevin Lacey on 12/10/13.
//  Copyright (c) 2013 KRL. All rights reserved.
//

#import "StatisticsViewController.h"

@interface StatisticsViewController ()

@end

@implementation StatisticsViewController
{
    NSArray *easyScores;
    NSArray *mediumScores;
    NSArray *advancedScores;
    NSString *freePlayScore;
    NSString *totalPuzzlesSolved;
}

@synthesize totalFreePlayScoreLabel, totalPuzzlesSolvedLabel, timedScoresTableView, difficultySegmentedControl;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    easyScores = [defaults objectForKey:@"easyTimedScores"];
    mediumScores = [defaults objectForKey:@"mediumTimedScores"];
    advancedScores = [defaults objectForKey:@"advancedTimedScores"];
    freePlayScore = [defaults objectForKey:@"freePlayScore"];
    totalPuzzlesSolved = [defaults objectForKey:@"totalPuzzlesSolved"];
    
    totalFreePlayScoreLabel.text = freePlayScore;
    totalPuzzlesSolvedLabel.text = totalPuzzlesSolved;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int numRows = 0;
    if(difficultySegmentedControl.selectedSegmentIndex == 0)
    {
        numRows = (int)[easyScores count];
    }
    else if(difficultySegmentedControl.selectedSegmentIndex == 1)
    {
        numRows = (int)[mediumScores count];
    }
    else if(difficultySegmentedControl.selectedSegmentIndex == 2)
    {
        numRows = (int)[advancedScores count];
    }
    
    return numRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScoreCell"];
    
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ScoreCell"];
    }
    
    if(difficultySegmentedControl.selectedSegmentIndex == 0)
    {
        cell.textLabel.text = [easyScores objectAtIndex:[easyScores count] - 1 - indexPath.row];
    }
    else if(difficultySegmentedControl.selectedSegmentIndex == 1)
    {
        cell.textLabel.text = [mediumScores objectAtIndex:[mediumScores count] - 1 - indexPath.row];
    }
    else if(difficultySegmentedControl.selectedSegmentIndex == 2)
    {
        cell.textLabel.text = [advancedScores objectAtIndex:[advancedScores count] - 1 - indexPath.row];
    }
    
    cell.detailTextLabel.text = @"Dec 10, 2013";
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)difficultySegmentedControlChanged:(id)sender
{
    [timedScoresTableView reloadData];
}

@end
