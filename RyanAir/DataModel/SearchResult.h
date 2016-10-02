//
//  SearchResult.h
//  RyanAir
//
//  Created by Macbook on 24/09/16.
//  Copyright © 2016 Macbook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchResult : NSObject
/**
 @abstract Currency as string
 */
@property(nonatomic,strong) NSString* currency;

/**
 @abstract Array of Flight objects
 */
@property(nonatomic,strong) NSArray* flights;

/**
 @abstract Deperture date as string
 */
@property(nonatomic,strong) NSString* depertureDate;

/**
 @abstract Deperture airport as string
 */
@property(nonatomic,strong) NSString* depertureAirport;

/**
 @abstract Arrival airport as string
 */
@property(nonatomic,strong) NSString* arrivalAirport;

@end
