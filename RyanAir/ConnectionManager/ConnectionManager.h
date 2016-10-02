//
//  ConnectionManager.h
//  RyanAir
//
//  Created by Macbook on 24/09/16.
//  Copyright © 2016 Macbook. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ConnectionManager : NSObject

typedef void (^ConnectionManagerSuccessHandler)(void);
typedef void (^ConnectionManagerFailureHandler)(NSError* error);
/**
 @return Singleton instance of ConnectionManager
 */
+ (instancetype)sharedManager;

/**
 @abstract Initiate service call to load list of airports
 */
- (void)loadAirportsWithSuccessHandler:(ConnectionManagerSuccessHandler)success
                     andFailureHandler:(ConnectionManagerFailureHandler)failure;

/**
 @abstract Initiate service call to search flights
 */
- (void)searchFlightsWithSuccessHandler:(ConnectionManagerSuccessHandler)success
                      andFailureHandler:(ConnectionManagerFailureHandler)failure;
@end

