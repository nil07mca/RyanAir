//
//  Fare.h
//  RyanAir
//
//  Created by Macbook on 25/09/16.
//  Copyright © 2016 Macbook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fare : NSObject
/**
 @abstract Fare amount as double
 */
@property(nonatomic,assign) double amount;

/**
 @abstract Fare type as string
 */
@property(nonatomic,strong) NSString* type;

/**
 @abstract Pax Count type as string
 */
@property(nonatomic,strong) NSString* count;
@end
