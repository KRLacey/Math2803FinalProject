//
//  BookPDFViewController.m
//  MATH2803
//
//  Created by Kevin Lacey on 12/10/13.
//  Copyright (c) 2013 KRL. All rights reserved.
//

#import "BookPDFViewController.h"
#import "PageViewController.h"

@interface BookPDFViewController ()

@end

@implementation BookPDFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"RelevantText" ofType:@"pdf"];
    PageViewController *page = [[PageViewController alloc] initWithPDFAtPath:path];
    
    [self.navigationController setViewControllers:[NSArray arrayWithObject:page] animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
