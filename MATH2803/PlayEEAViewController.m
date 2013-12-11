//
//  PlayEEAViewController.m
//  MATH2803
//
//  Created by Kevin Lacey on 12/9/13.
//  Copyright (c) 2013 KRL. All rights reserved.
//

#import "PlayEEAViewController.h"
#import "DataHold.h"
#import "GameTableViewCell.h"
#import "EEACell.h"

@interface PlayEEAViewController ()

@end

@implementation PlayEEAViewController
{
    DataHold *sharedRepository;
    NSString *numA;
    NSString *numB;
    NSString *gcd;
    NSMutableDictionary *problemDictionary;
    NSMutableDictionary *EEADictionary;
    int currentRow;
    BOOL EAComplete;
    BOOL problemComplete;
    NSTimer *updateTimer;
    int difficulty;
    int correct;
    int score;
}

@synthesize problemDescriptionLabel;
@synthesize gameTableView;
@synthesize checkRowButton;
@synthesize timedMode;
@synthesize progressViewA, progressViewB;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    sharedRepository = [[DataHold alloc] init];
    
    difficulty = sharedRepository.difficulty;
    
    if(timedMode)
    {
        progressViewA.hidden = FALSE;
        progressViewB.hidden = FALSE;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ready?" message:Nil delegate:self cancelButtonTitle:@"BEGIN!" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        [self resetGame];
        progressViewA.hidden = TRUE;
        progressViewB.hidden = TRUE;
    }
    
    UITapGestureRecognizer *exteriorTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:exteriorTap];
    
    gameTableView.tableFooterView = [UIView new];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [updateTimer invalidate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if((int)buttonIndex == 0)
    {
        [self resetGame];
        
        progressViewA.progress = 0.0;
        progressViewB.progress = 0.0;
        
        updateTimer = [NSTimer timerWithTimeInterval:0.1
                                              target:self
                                            selector:@selector(updateProgressBars)
                                            userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:updateTimer forMode:NSRunLoopCommonModes];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)updateProgressBars
{
    [progressViewA setProgress:progressViewA.progress + 1.0/900 animated:YES];
    [progressViewB setProgress:progressViewB.progress + 1.0/900 animated:YES];
    
    if(progressViewA.progress == 1.0)
    {
        [updateTimer invalidate];
        
        problemComplete = TRUE;
        
        [self saveScoresToDevice];
        
        UIAlertView *gameOver = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Game Over! Score: %d", score] message:Nil delegate:self cancelButtonTitle:@"Retry?" otherButtonTitles:@"No", nil, nil];
        
        [gameOver show];
    }
}

- (void)resetGame
{
    EAComplete = FALSE;
    problemComplete = FALSE;
    score = 0;
    correct = 0;
    currentRow = 0;
    problemDictionary = [[NSMutableDictionary alloc] init];
    EEADictionary = [[NSMutableDictionary alloc] init];
    [self generateProblem];
    
    [self toggleCheckRowButton];
    
    [gameTableView reloadData];
    
    problemDescriptionLabel.text = [NSString stringWithFormat:@"%@x + %@y = gcd(%@, %@)", numA, numB, numA, numB];
}

- (void)toggleCheckRowButton
{
    if(problemComplete)
    {
        [checkRowButton setTitle:@"New Problem" forState:UIControlStateNormal];
        [checkRowButton setBackgroundImage:[UIImage imageNamed:@"Red-Bar.png"] forState:UIControlStateNormal];
    }
    else
    {
        [checkRowButton setTitle:@"Evaluate Answer" forState:UIControlStateNormal];
        [checkRowButton setBackgroundImage:[UIImage imageNamed:@"Green-Bar.png"] forState:UIControlStateNormal];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return currentRow + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = (int)indexPath.row;
    
    if(EAComplete && row > (int)[problemDictionary count] - 1)          // Display Extended Euclidean Algorithm Cell
    {
        int EEARow = row - (int)[problemDictionary count];
        NSArray *EEACellData = [EEADictionary objectForKey:[NSString stringWithFormat:@"%d", EEARow]];
        
        EEACell *cell = [tableView dequeueReusableCellWithIdentifier:@"EEACell"];
        
        if (nil == cell)
        {
            cell = [[EEACell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"EEACell"];
        }
        
        if(row == [gameTableView numberOfRowsInSection:0] - 1 && !problemComplete)
        {
            cell.isEditing = TRUE;
        }
        else
        {
            cell.isEditing = FALSE;
        }
        
        cell.remainderLabel.text = gcd;
        cell.quantityLeftValueLabel.text = [EEACellData objectAtIndex:1];
        cell.leftValueLabel.text = [EEACellData objectAtIndex:2];
        cell.quantityRightValuelabel.text = [EEACellData objectAtIndex:3];
        cell.rightValueLabel.text = [EEACellData objectAtIndex:4];
        
        return cell;
    }
    else
    {
        NSArray *cellArray = [problemDictionary objectForKey:[NSString stringWithFormat:@"%d", row]];
        
        GameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GameCell"];
        
        if (nil == cell)
        {
            cell = [[GameTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"GameCell"];
        }
        
        if(row == currentRow && !EAComplete)
        {
            cell.isEditing = TRUE;
        }
        else
        {
            cell.isEditing = FALSE;
        }
        
        cell.largeValueLabel.text = [cellArray objectAtIndex:0];        // Large Value
        cell.quantityValueLabel.text = [cellArray objectAtIndex:1];     // Quantity Value
        cell.smallValueLabel.text = [cellArray objectAtIndex:2];        // Small Value
        cell.remainderValueLabel.text = [cellArray objectAtIndex:3];    // Remainder
        
//        int numEARows = (int)[problemDictionary count];
//        int numRowsInTable = (int)[gameTableView numberOfRowsInSection:0];
//        
//        int highlightRow = currentRow - numRowsInTable%numEARows - 1;
//        
//        NSLog(@"row: %d", (int)indexPath.row);
//        NSLog(@"current row: %d", currentRow);
//        NSLog(@"NumEARows: %d", numEARows);
//        NSLog(@"NumRowsINT: %d", numRowsInTable);
//        NSLog(@"highlight: %d", highlightRow);
//        
//        if(currentRow > (int)[problemDictionary count] - 1 && row == highlightRow)
//        {
//            cell.backgroundColor = sharedRepository.greenColor;
//        }
        
        return cell;
    }
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    cell.backgroundColor = [UIColor redColor];
//    
//}

- (void)updateGameTableView
{
    if(currentRow == [problemDictionary count] - 1)
    {
        EAComplete = TRUE;
        problemDescriptionLabel.text = [NSString stringWithFormat:@"%@x + %@y = %@", numA, numB, gcd];
    }
    if(currentRow == [problemDictionary count] - 1 + [EEADictionary count])
    {
        problemComplete = TRUE;
        [self saveScoresToDevice];
        
        NSArray *answersArray = [EEADictionary objectForKey:[NSString stringWithFormat:@"%d", (int)[EEADictionary count] - 1]];
        
        problemDescriptionLabel.text = [NSString stringWithFormat:@"%@(%@) + %@(%@) = %@", numA, [answersArray objectAtIndex:1], numB, [answersArray objectAtIndex:3], gcd];
        [self toggleCheckRowButton];
    }
    
    if(!problemComplete)
    {
        currentRow++;
    }
    
    [gameTableView reloadData];
    
    NSIndexPath *index = [NSIndexPath indexPathForRow:([gameTableView numberOfRowsInSection:0] -1) inSection:0];
    NSLog(@"row: %d", (int)index.row);
    
    [gameTableView scrollToRowAtIndexPath:index
                         atScrollPosition:UITableViewScrollPositionTop
                                 animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)generateProblem
{
    int A = arc4random_uniform(3000);
    int B = arc4random_uniform(3000);
    
    int evenA = arc4random_uniform(10);
    int evenB = arc4random_uniform(10);
    
    if(evenA > 3)
    {
        if(A % 2 == 1)
        {
            A += 1;
        }
    }
    
    if(evenB > 3)
    {
        if(B % 2 == 1)
        {
            B += 1;
        }
    }
    
    if(A < B)
    {
        int c = A;
        A = B;
        B = c;
    }
    
    numA = [NSString stringWithFormat:@"%d", A];
    numB = [NSString stringWithFormat:@"%d", B];
    
    [self createProblemDictionaryWithValues:A and:B];
    [self createEEADictionary];
    
    NSLog(@"%@", problemDictionary);
    NSLog(@"%@", EEADictionary);
}

- (void)createProblemDictionaryWithValues:(int)A and:(int)B
{
    NSString *largeValue = [NSString stringWithFormat:@"%d", A];
    NSString *quantity = [NSString stringWithFormat:@"%d",A/B];
    NSString *smallValue = [NSString stringWithFormat:@"%d",B];
    NSString *remainder = [NSString stringWithFormat:@"%d",A%B];
    
    NSString *key = [NSString stringWithFormat:@"%d", (int)[problemDictionary count]];
    
    [problemDictionary setObject:@[largeValue, quantity, smallValue, remainder] forKey:key];
    
    if([remainder intValue] != 0)
    {
        [self createProblemDictionaryWithValues:[smallValue intValue] and:[remainder intValue]];
    }
    else
    {
        gcd = smallValue;
    }
}

- (void)createEEADictionary
{
    int k = 0;
    for(int i = (int)[problemDictionary count] - 2; i >= 0; i--)
    {
        
        
        if([EEADictionary count] == 0)
        {
            NSArray *values = [problemDictionary objectForKey:[NSString stringWithFormat:@"%d", i]];
            
            int remainder = [gcd intValue];
            int largeValue = [[values objectAtIndex:0] intValue];
            int smallValue = [[values objectAtIndex:2] intValue];
            int largeQuantity = 1;
            int smallQuantity = -[[values objectAtIndex:1] intValue];
            
            NSArray *newValues = @[[self stringFromInt:remainder], [self stringFromInt:largeQuantity], [self stringFromInt:largeValue], [self stringFromInt:smallQuantity], [self stringFromInt:smallValue]];
            
            [EEADictionary setObject:newValues forKey:[NSString stringWithFormat:@"%d", k]];
        }
        else
        {
            NSArray *values = [problemDictionary objectForKey:[NSString stringWithFormat:@"%d", i]];
            NSArray *previousValues = [EEADictionary objectForKey:[NSString stringWithFormat:@"%d", k - 1]];
            
            int remainder = [gcd intValue];
            int largeValue = [[values objectAtIndex:0] intValue]; // 16, 22, 60
            int smallValue = [[values objectAtIndex:2] intValue]; // 6, 16, 22
            
            int intermediateLargeQuantity = [[previousValues objectAtIndex:1] intValue];
            int intermediateSmallQuantity = [[previousValues objectAtIndex:3] intValue];
            
            int largeQuantity = intermediateSmallQuantity;
            int smallQuantity = -[[values objectAtIndex:1] intValue] * intermediateSmallQuantity + intermediateLargeQuantity;
            
            NSArray *newValues = @[[self stringFromInt:remainder], [self stringFromInt:largeQuantity], [self stringFromInt:largeValue], [self stringFromInt:smallQuantity], [self stringFromInt:smallValue]];
            
            [EEADictionary setObject:newValues forKey:[NSString stringWithFormat:@"%d", k]];
        }
        
        NSLog(@"%@", EEADictionary);

        k++;
    }
}

#define MAXLENGTH 5
- (BOOL)textField:(UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSUInteger oldLength = [textField.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    
    BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
    
    return newLength <= MAXLENGTH || returnKey;
}

- (NSString *)quantityOfValueA:(NSString *)valueA inValueB:(NSString *)valueB
{
    int valA = [valueA intValue];
    int valB = [valueB intValue];
    
    if(valA > valB)
    {
        return [NSString stringWithFormat:@"%d", valA/valB];
    }
    else
    {
        return [NSString stringWithFormat:@"%d", valB/valA];
    }
}

- (NSString *)remainderOfValueA:(NSString *)valueA fromValueB:(NSString *)valueB
{
    int valA = [valueA intValue];
    int valB = [valueB intValue];
    
    if(valA > valB)
    {
        return [NSString stringWithFormat:@"%d", valA%valB];
    }
    else
    {
        return [NSString stringWithFormat:@"%d", valB%valA];
    }
}

- (NSString *)stringFromInt:(int)a
{
    return [NSString stringWithFormat:@"%d", a];
}

- (void)dismissKeyboard
{
    [self.view endEditing:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if([gameTableView numberOfRowsInSection:0] > 3)
    {
//        [self.view setFrame:CGRectMake(0,-100,320,460)];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if([gameTableView numberOfRowsInSection:0] > 3)
    {
//        [self.view setFrame:CGRectMake(0,0,320,460)];
    }
}

- (IBAction)checkRowButtonPressed:(id)sender
{
    if(problemComplete)
    {
        [self resetGame];
    }
    else if(!EAComplete)
    {
        NSArray *solutionArray = [problemDictionary objectForKey:[NSString stringWithFormat:@"%d", currentRow]];
        
        GameTableViewCell *cell = (GameTableViewCell *)[self.gameTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentRow inSection:0]];
        
        if(difficulty == 0)
        {
            if([cell.remainderValueTextField.text isEqualToString:[solutionArray objectAtIndex:3]])
            {
                correct +=1;
                score += 1;
                [self saveScoresToDevice];
                [self indicateValidEntriesAndUpdateTableView:cell];
            }
            else
            {
                [self indicateInvalidEntries:cell];
            }
        }
        else if(difficulty == 1)
        {
            BOOL Acorrect = [cell.remainderValueTextField.text isEqualToString:[solutionArray objectAtIndex:3]];
            BOOL Bcorrect = [cell.largeValueTextField.text isEqualToString:[solutionArray objectAtIndex:0]];
            
            if(Acorrect && Bcorrect)
            {
                correct +=1;
                score += 3;
                [self saveScoresToDevice];
                [self indicateValidEntriesAndUpdateTableView:cell];
            }
            else
            {
                [self indicateInvalidEntries:cell];
            }
        }
        else if(difficulty == 2)
        {
            BOOL Acorrect = [cell.remainderValueTextField.text isEqualToString:[solutionArray objectAtIndex:3]];
            BOOL Bcorrect = [cell.largeValueTextField.text isEqualToString:[solutionArray objectAtIndex:0]];
            BOOL Ccorrect = [cell.smallValueTextField.text isEqualToString:[solutionArray objectAtIndex:2]];
            
            if(Acorrect && Bcorrect && Ccorrect)
            {
                correct +=1;
                score += 5;
                [self saveScoresToDevice];
                [self indicateValidEntriesAndUpdateTableView:cell];
            }
            else
            {
                [self indicateInvalidEntries:cell];
            }
        }
    }
    else
    {
        int row = (int)[gameTableView numberOfRowsInSection:0] - 1;
        EEACell *cell = (EEACell *)[self.gameTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
        
        NSArray *solutionArray = [EEADictionary objectForKey:[NSString stringWithFormat:@"%d", row - (int)[problemDictionary count]]];
        
        if(difficulty == 0)
        {
            BOOL leftQuantityCorrect = [cell.quantityLeftValueTextField.text isEqualToString:[solutionArray objectAtIndex:1]];
            
            if(leftQuantityCorrect)
            {
                correct +=1;
                score += 3;
                [self saveScoresToDevice];
                [self indicateValidEntriesAndUpdateTableView:cell];
            }
        }
        if(difficulty == 1)
        {
            BOOL leftQuantityCorrect = [cell.quantityLeftValueTextField.text isEqualToString:[solutionArray objectAtIndex:1]];
            BOOL rightQuantityCorrect = [cell.quantityRightValueTextField.text isEqualToString:[solutionArray objectAtIndex:3]];
            
            if(leftQuantityCorrect && rightQuantityCorrect)
            {
                correct +=1;
                score += 7;
                [self saveScoresToDevice];
                [self indicateValidEntriesAndUpdateTableView:cell];
            }
            else
            {
                [self indicateInvalidEntries:cell];
            }
        }
        else if(difficulty == 2)
        {
            BOOL leftQuantityCorrect = [cell.quantityLeftValueTextField.text isEqualToString:[solutionArray objectAtIndex:1]];
            BOOL rightQuantityCorrect = [cell.quantityRightValueTextField.text isEqualToString:[solutionArray objectAtIndex:3]];
            BOOL leftValueCorrect = [cell.leftValueTextField.text isEqualToString:[solutionArray objectAtIndex:2]];
            BOOL rightValueCorrect = [cell.rightValueTextField.text isEqualToString:[solutionArray objectAtIndex:4]];
            
            if(leftQuantityCorrect && rightQuantityCorrect && leftValueCorrect && rightValueCorrect)
            {
                correct +=1;
                score += 13;
                [self saveScoresToDevice];
                [self indicateValidEntriesAndUpdateTableView:cell];
            }
            else
            {
                [self indicateInvalidEntries:cell];
            }
        }
    }
}

- (void)indicateValidEntriesAndUpdateTableView:(UITableViewCell *)cell
{
    [self animateCell:cell withColor:[UIColor greenColor]];
    
    [self performSelector:@selector(updateGameTableView) withObject:Nil afterDelay:1.0];
}

- (void)indicateInvalidEntries:(UITableViewCell *)cell
{
    [self animateCell:cell withColor:[UIColor redColor]];
}

- (void)animateCell:(GameTableViewCell *)cell withColor:(UIColor *)color
{
    UIView * selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    [selectedBackgroundView setBackgroundColor:color]; // set color here
    [cell setSelectedBackgroundView:selectedBackgroundView];
    
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveEaseInOut animations:^
     {
         [cell setHighlighted:YES animated:YES];
     } completion:^(BOOL finished)
     {
         [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveEaseInOut animations:^
          {
              [cell setHighlighted:NO animated:YES];
          } completion: NULL];
     }];
}

- (void)saveScoresToDevice
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if(timedMode && problemComplete)
    {
        if(difficulty == 0)
        {
            NSMutableArray *easy = [NSMutableArray arrayWithArray:[defaults objectForKey:@"easyTimedScores"]];
            [easy addObject:[NSString stringWithFormat:@"%d", score]];
            [defaults setObject:easy forKey:@"easyTimedScores"];
        }
        else if(difficulty == 1)
        {
            NSMutableArray *medium = [NSMutableArray arrayWithArray:[defaults objectForKey:@"mediumTimedScores"]];
            [medium addObject:[NSString stringWithFormat:@"%d", score]];
            [defaults setObject:medium forKey:@"mediumTimedScores"];
        }
        else if(difficulty == 2)
        {
            NSMutableArray *advanced = [NSMutableArray arrayWithArray:[defaults objectForKey:@"advancedTimedScores"]];
            [advanced addObject:[NSString stringWithFormat:@"%d", score]];
            [defaults setObject:advanced forKey:@"advancedTimedScores"];
        }
    }
    else
    {
        int totalScore = [[defaults objectForKey:@"freePlayScore"] intValue];
        totalScore += score;
        [defaults setObject:[NSString stringWithFormat:@"%d", totalScore] forKey:@"freePlayScore"];
    }
    
    int totalPlayed = [[defaults objectForKey:@"totalPuzzlesSolved"] intValue];
    totalPlayed += correct;
    [defaults setObject:[NSString stringWithFormat:@"%d", totalPlayed] forKey:@"totalPuzzlesSolved"];
    
    [defaults synchronize];
}

@end
