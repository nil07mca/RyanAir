//
//  Utility.m
//  RyanAir
//
//  Created by Macbook on 25/09/16.
//  Copyright © 2016 Macbook. All rights reserved.
//

#import "Utility.h"


@implementation Utility
+ (instancetype)sharedUtils
{
    static Utility *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Utility alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}
- (id) init
{
    if (self = [super init])
    {
        // do your own initialisation here
    }
    return self;
}

- (NSString*) extractTimeFromDateString:(NSString*)dateSrting
{
    NSString* strTime = @"";
    if (dateSrting) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS";
        NSDate *date = [dateFormatter dateFromString:dateSrting];
        [dateFormatter setDateFormat:@"HH:mm"];
        strTime = [dateFormatter stringFromDate:date];
    }
    return strTime;
}

- (NSString*) extractLongDateFromDateString:(NSString*)dateSrting
{
    NSString* strTime = @"";
    if (dateSrting) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS";
        NSDate *date = [dateFormatter dateFromString:dateSrting];
        [dateFormatter setDateFormat:@"dd, MMMM"];
        strTime = [dateFormatter stringFromDate:date];
    }
    return strTime;
}

- (NSString*) formatFlightDuration:(NSString*)duration
{
    NSString* strDuration = @"";
    if (duration) {
        NSArray* arrComponents = [duration componentsSeparatedByString:@":"];
        if ([arrComponents count]>1) {
            strDuration = [NSString stringWithFormat:@"%@ Hour, %@ Minute",[arrComponents objectAtIndex:0],[arrComponents objectAtIndex:1]];
        }
        
    }
    return strDuration;
}

- (NSString*) formatDateForSearch:(NSDate*)date
{
    NSDateFormatter* dateformater=[[NSDateFormatter alloc]init];
    [dateformater setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateformater stringFromDate:date];
    return strDate;
}

- (UIAlertController*) showAlertWithMessage:(NSString*)message andTitle:(NSString*)title{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    [alert addAction:ok];
    return alert;
}

@end
