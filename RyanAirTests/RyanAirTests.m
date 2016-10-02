//
//  RyanAirTests.m
//  RyanAirTests
//
//  Created by Macbook on 23/09/16.
//  Copyright © 2016 Macbook. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ConnectionManager.h"
#import "DataManager.h"
#import "Airport.h"
#import "SearchData.h"
#import "Utility.h"
#import "SearchResult.h"
#import "Flight.h"

@interface RyanAirTests : XCTestCase

@end

@implementation RyanAirTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testFetchAirportList {
    [[ConnectionManager sharedManager] loadAirportsWithSuccessHandler:^{
        NSArray* arrAirports = [[DataManager sharedManager] retriveAirportList];
        XCTAssertNotNil(arrAirports);
        if ([arrAirports count]>0) {
            Airport* airport = [arrAirports objectAtIndex:0];
            XCTAssertNotNil(airport.airportCode);
        }
    } andFailureHandler:^(NSError *error) {
        XCTAssertNil(error);
    }];
}


- (void)testFlightSearch {
    __block BOOL searchCompleted;
    [[ConnectionManager sharedManager] searchFlightsWithSuccessHandler:^{
        NSArray* arrResults = [[DataManager sharedManager] retiveSearchResult];
        searchCompleted = YES;
        XCTAssertNotNil(arrResults);
        
    } andFailureHandler:^(NSError *error) {
        XCTAssertNil(error);
    }];
    XCTAssertTrue(searchCompleted);
}

- (void)testSearchData {
    XCTAssertNotNil([SearchData currentSearch]);
    XCTAssertEqual([SearchData currentSearch].numberOfAdults, 1);
}


- (void)testExtractTimeFromDateString {
    NSString* actual = [[Utility sharedUtils] extractTimeFromDateString:@"2016-04-12T11:20:00.000"];
    NSString* expected = @"11:20";
    XCTAssertNotNil(actual);
    XCTAssertTrue([actual isEqualToString:expected]);
}

- (void)testExtractLongDateFromDateString {
    NSString* actual = [[Utility sharedUtils] extractLongDateFromDateString:@"2016-04-12T00:00:00.000"];
    NSString* expected = @"12, April";
    XCTAssertNotNil(actual);
    XCTAssertTrue([actual isEqualToString:expected]);
}

- (void)testFormatFlightDuration {
    NSString* actual = [[Utility sharedUtils] formatFlightDuration:@"11:50"];
    NSString* expected = @"11 Hour, 50 Minute";
    XCTAssertNotNil(actual);
    XCTAssertTrue([actual isEqualToString:expected]);
}

- (void)testFormatDateForSearch {
    [SearchData currentSearch].flyOutDate = [[Utility sharedUtils] formatDateForSearch:[NSDate date]];
    XCTAssertNotNil([SearchData currentSearch].flyOutDate);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testFare {
    Fare* fare = [Fare new];
    fare.amount = 100.20;
    XCTAssertNotNil(fare);
    XCTAssertEqual(fare.amount, 100.20);
}

- (void)testFlight {
    Flight* flight = [Flight new];
    flight.flightNumber = @"FR-2015";
    XCTAssertNotNil(flight);
    XCTAssertTrue([flight.flightNumber isEqualToString:@"FR-2015"]);
}


@end
