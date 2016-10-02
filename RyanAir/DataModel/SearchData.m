//
//  SearchData.m
//  RyanAir
//
//  Created by Macbook on 24/09/16.
//  Copyright © 2016 Macbook. All rights reserved.
//

#import "SearchData.h"
#import "Constants.h"

@implementation SearchData
+ (instancetype)currentSearch
{
    static SearchData *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SearchData alloc] init];
        // Do any other initialisation stuff here
        sharedInstance.numberOfAdults = MIN_ADULT;
        sharedInstance.numberOfChilds = MIN_CHILD;
        sharedInstance.numberOfTeens  = MIN_TEEN;
    });
    return sharedInstance;
}
@end
