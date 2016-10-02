//
//  DataManager.h
//  RyanAir
//
//  Created by Macbook on 24/09/16.
//  Copyright © 2016 Macbook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject
/**
 @return Singleton instance of DataManager
 */
+ (instancetype)sharedManager;

/**
 @abstract Parse response for Airport List
 @param Response as NSData
 */
- (void)parseAirportList:(NSData*)responseData;

/**
 @abstract Parse search response
 @param Response as NSData
 */
- (void)parseSearchFlightList:(NSData*)responseData;

/**
 @abstract Retrive Airport List
 @return Airport List as array
 */
- (NSArray*)retriveAirportList;

/**
 @abstract Retrive Search results
 @return Search results as array
 */
- (NSArray*)retiveSearchResult;
@end
