//
//  Airport.h
//  RyanAir
//
//  Created by Macbook on 24/09/16.
//  Copyright © 2016 Macbook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Airport : NSObject
/**
 @abstract Airport name as string
 */
@property(nonatomic,strong) NSString* airportName;

/**
 @abstract Airport country as string
 */
@property(nonatomic,strong) NSString* airportCountry;

/**
 @abstract Airport code as string
 */
@property(nonatomic,strong) NSString* airportCode;
@end
