//
//  ConnectionManager.m
//  RyanAir
//
//  Created by Macbook on 24/09/16.
//  Copyright © 2016 Macbook. All rights reserved.
//

#import "ConnectionManager.h"
#import "Constants.h"
#import "DataManager.h"
#import "SearchData.h"

@interface ConnectionManager ()<NSURLSessionDelegate>
@property(nonatomic,copy) ConnectionManagerSuccessHandler successHandler;
@property(nonatomic,copy) ConnectionManagerFailureHandler failureHandler;
@end
@implementation ConnectionManager
+ (instancetype)sharedManager
{
    static ConnectionManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ConnectionManager alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

#pragma mark - Load Airport List
- (void)loadAirportsWithSuccessHandler:(ConnectionManagerSuccessHandler)success
                     andFailureHandler:(ConnectionManagerFailureHandler)failure
{
    self.successHandler = success;
    self.failureHandler = failure;
    NSURL *url = [[NSURL alloc]initWithString:STATION_LIST_URL];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error == nil)
        {
            [self parseAirportList:data];
        }
        else
        {
            [self handleError:error];
        }
        
    }];
    [dataTask resume];

}

#pragma mark - Flight Search
- (void)searchFlightsWithSuccessHandler:(ConnectionManagerSuccessHandler)success
                      andFailureHandler:(ConnectionManagerFailureHandler)failure
{
    self.successHandler = success;
    self.failureHandler = failure;
    NSString* strDeperture = [SearchData currentSearch].depertureAirport.airportCode;
    NSString* strArrival = [SearchData currentSearch].arrivalAirport.airportCode;
    NSString* strDateOut = [SearchData currentSearch].flyOutDate;
    NSString* strNumberofAdults = [NSString stringWithFormat:@"%d",[SearchData currentSearch].numberOfAdults];
    NSString* strNumberofTeen = [NSString stringWithFormat:@"%d",[SearchData currentSearch].numberOfTeens];
    NSString* strNumberofChild = [NSString stringWithFormat:@"%d",[SearchData currentSearch].numberOfChilds];
    
    
    NSString* strURL = [NSString stringWithFormat:SEARCH_URL,strDeperture,strArrival,strDateOut,strNumberofAdults,strNumberofTeen,strNumberofChild];
    NSURL *url = [[NSURL alloc]initWithString:strURL];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error == nil)
        {
            [self parseSearchData:data];
        }
        else
        {
            [self handleError:error];
        }
        
    }];
    [dataTask resume];
}

#pragma mark - Parsing
- (void) parseAirportList:(NSData *)responseData {
    [[DataManager sharedManager] parseAirportList:responseData];
    self.successHandler();
}

- (void) parseSearchData:(NSData *)responseData {
    [[DataManager sharedManager] parseSearchFlightList:responseData];
    self.successHandler();
}


#pragma mark - Handle Error
- (void) handleError:(NSError *)error {
    self.failureHandler(error);
}
@end
