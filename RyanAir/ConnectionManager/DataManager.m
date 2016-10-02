//
//  DataManager.m
//  RyanAir
//
//  Created by Macbook on 24/09/16.
//  Copyright © 2016 Macbook. All rights reserved.
//

#import "DataManager.h"
#import "Airport.h"
#import "SearchResult.h"
#import "Flight.h"
#import "Fare.h"

@interface DataManager()
@property(nonatomic,strong)NSMutableArray* arrAirports;
@property(nonatomic,strong)NSMutableArray* arrFlights;
@end
@implementation DataManager
+ (instancetype)sharedManager
{
    static DataManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DataManager alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

- (void)parseAirportList:(NSData*)responseData {
    if(!_arrAirports)
       _arrAirports = [NSMutableArray array];
    if (responseData) {
        NSError* error;
        NSDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:responseData
                                                                 options:kNilOptions
                                                                   error:&error];
        if (jsonData) {
            NSArray* arr = [jsonData objectForKey:@"stations"];
            for (NSDictionary* dict in arr) {
                Airport* airport = [[Airport alloc] init];
                airport.airportName = [dict objectForKey:@"name"];
                airport.airportCode = [dict objectForKey:@"code"];
                airport.airportCountry = [dict objectForKey:@"countryName"];
                [_arrAirports addObject:airport];
            }
        }
        
    }
}

- (void)parseSearchFlightList:(NSData*)responseData {
    if(!_arrFlights)
        _arrFlights = [NSMutableArray array];
    else
        [_arrFlights removeAllObjects];
    if (responseData) {
        NSError* error;
        NSDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:responseData
                                                                 options:kNilOptions
        
                                                                   error:&error];
        if (jsonData) {
            NSString* currency = [jsonData objectForKey:@"currency"];
            NSArray* arrTrips = [jsonData objectForKey:@"trips"];
            if ([arrTrips count]>0) {
                NSDictionary* trip = [arrTrips objectAtIndex:0];
                NSString* depertureAirport = [trip objectForKey:@"origin"];
                NSString* arrivalAirport = [trip objectForKey:@"destination"];
                NSArray* arrDates = [trip objectForKey:@"dates"];
                for (NSDictionary* dict in arrDates) {
                    SearchResult *result = [[SearchResult alloc] init];
                    result.currency = currency;
                    result.arrivalAirport = arrivalAirport;
                    result.depertureAirport =depertureAirport;
                    result.depertureDate = [dict objectForKey:@"dateOut"];
                    NSArray* flights = [dict objectForKey:@"flights"];
                    NSMutableArray* arrFlightsLocal = [NSMutableArray array];
                    for (NSDictionary* dictFlight in flights) {
                        Flight *flight = [[Flight alloc] init];
                        flight.flightNumber = [dictFlight objectForKey:@"flightNumber"];
                        flight.flightDuration = [dictFlight objectForKey:@"duration"];
                        NSArray* arrTime = [dictFlight objectForKey:@"time"];
                        if ([arrTime count]>1) {
                            flight.depertureTime = [arrTime objectAtIndex:0];
                            flight.arrivalTime = [arrTime objectAtIndex:1];
                        }
                        
                        NSDictionary* dictRegFare = [dictFlight objectForKey:@"regularFare"];
                        NSArray* regFares = [dictRegFare objectForKey:@"fares"];
                        NSMutableArray* arrRegFare = [NSMutableArray array];
                        for (NSDictionary* dictFare in regFares) {
                            Fare* fare =[[Fare alloc] init];
                            fare.amount = [[dictFare valueForKey:@"amount"] doubleValue];
                            fare.count = [dictFare objectForKey:@"count"];
                            fare.type = [dictFare objectForKey:@"type"];
                            [arrRegFare addObject:fare];
                        }
                        flight.economyFares = arrRegFare;
                        
                        NSDictionary* dictBusFare = [dictFlight objectForKey:@"businessFare"];
                        NSArray* busFares = [dictBusFare objectForKey:@"fares"];
                        NSMutableArray* arrBusFare = [NSMutableArray array];
                        for (NSDictionary* dictFare in busFares) {
                            Fare* fare =[[Fare alloc] init];
                            fare.amount = [[dictFare valueForKey:@"amount"] doubleValue];
                            fare.count = [dictFare objectForKey:@"count"];
                            fare.type = [dictFare objectForKey:@"type"];
                            [arrBusFare addObject:fare];
                        }
                        flight.economyFares = arrBusFare;
                        
                        [arrFlightsLocal addObject:flight];
                    }
                    result.flights = arrFlightsLocal;
                    [_arrFlights addObject:result];
                }

            }
        }

//        NSLog(@"%@",jsonData);
    }
}

- (NSArray*)retriveAirportList {
    return _arrAirports;
}

- (NSArray*)retiveSearchResult {
    return _arrFlights;
}
@end
