//
//  Utility.h
//  RyanAir
//
//  Created by Macbook on 25/09/16.
//  Copyright © 2016 Macbook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utility : NSObject
/**
 @return Singleton instance of Utility
 */
+ (instancetype)sharedUtils;

/**
 @abstract Extract time from date string
 @param Date and time as string
 @return Time as string
 */
- (NSString*) extractTimeFromDateString:(NSString*)dateSrting;

/**
 @abstract Extract date from date string
 @param Date and time as string
 @return Long date as string
 */
- (NSString*) extractLongDateFromDateString:(NSString*)dateSrting;

/**
 @abstract Format flight duration string
 @param Flight duration raw as string
 @return Formatted flighr duration as string
 */
- (NSString*) formatFlightDuration:(NSString*)duration;

/**
 @abstract Format date for search
 @param NSDate object
 @return Formatted date as string
 */
- (NSString*) formatDateForSearch:(NSDate*)date;

/**
 @abstract Show alert dialog
 @param Title and Message as string
 @return alert as UIAlertController object
 */
- (UIAlertController*) showAlertWithMessage:(NSString*)message andTitle:(NSString*)title;
@end
