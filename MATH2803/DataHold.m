//
//  DataHold.m
//  MATH2803
//
//  Created by Kevin Lacey on 12/9/13.
//  Copyright (c) 2013 KRL. All rights reserved.
//

#import "DataHold.h"

@implementation DataHold

@synthesize difficulty;
@synthesize greenColor, redColor;

+ (DataHold *)sharedRepository
{
    static DataHold *sharedRepository = nil;
    
    if(!sharedRepository)
    {
        sharedRepository = [[super allocWithZone:nil] init];
    }
    
    return sharedRepository;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedRepository];
}

@end
