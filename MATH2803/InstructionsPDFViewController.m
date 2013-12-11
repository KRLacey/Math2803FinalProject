//
//  InstructionsViewController.m
//  MATH2803
//
//  Created by Kevin Lacey on 12/10/13.
//  Copyright (c) 2013 KRL. All rights reserved.
//

#import "InstructionsPDFViewController.h"
#import "PageViewController.h"

@interface InstructionsPDFViewController ()

@end

@implementation InstructionsPDFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"RelevantText" ofType:@"pdf"];
    PageViewController *page = [[PageViewController alloc] initWithPDFAtPath:path];

    [self.view addSubview:page.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
