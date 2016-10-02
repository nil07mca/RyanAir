//
//  SearchData.h
//  RyanAir
//
//  Created by Macbook on 24/09/16.
//  Copyright © 2016 Macbook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Airport.h"

@interface SearchData : NSObject
/**
 @return Singleton instance of SearchData
 */
+ (instancetype)currentSearch;

/**
 @abstract Deperture airport as Airport object
 */
@property(nonatomic,strong) Airport* depertureAirport;

/**
 @abstract Arrival airport as Airport object
 */
@property(nonatomic,strong) Airport* arrivalAirport;

/**
 @abstract Fly Out date as string
 */
@property(nonatomic,strong) NSString* flyOutDate;

/**
 @abstract Fly In date as string
 */
@property(nonatomic,strong) NSString* flyIn;

/**
 @abstract Number of adult passenger
 */
@property(nonatomic,assign) int numberOfAdults;

/**
 @abstract Number of child passenger
 */
@property(nonatomic,assign) int numberOfChilds;

/**
 @abstract Number of teen passenger
 */
@property(nonatomic,assign) int numberOfTeens;
@end
