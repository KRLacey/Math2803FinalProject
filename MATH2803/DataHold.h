//
//  DataHold.h
//  MATH2803
//
//  Created by Kevin Lacey on 12/9/13.
//  Copyright (c) 2013 KRL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataHold : NSObject
{
    UIColor *greenColor;
    UIColor *redColor;
    int difficulty;
}

@property int difficulty;
@property UIColor *greenColor, *redColor;

+ (DataHold *)sharedRepository;

@end
