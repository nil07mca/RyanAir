//
//  Flight.h
//  RyanAir
//
//  Created by Macbook on 25/09/16.
//  Copyright © 2016 Macbook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fare.h"

@interface Flight : NSObject
/**
 @abstract Flight number as string
 */
@property(nonatomic,strong) NSString* flightNumber;

/**
 @abstract Flight duration as string
 */
@property(nonatomic,strong) NSString* flightDuration;

/**
 @abstract Deperture time as string
 */
@property(nonatomic,strong) NSString* depertureTime;

/**
 @abstract Arrival time as string
 */
@property(nonatomic,strong) NSString* arrivalTime;

/**
 @abstract Economy fares as Array of Fare object
 */
@property(nonatomic,strong) NSArray* economyFares;

/**
 @abstract Business fares as Array of Fare object
 */
@property(nonatomic,strong) NSArray* businessFares;
@end
