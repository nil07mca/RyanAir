//
//  LoadingIndicatior.h
//  RyanAir
//
//  Created by Macbook on 25/09/16.
//  Copyright © 2016 Macbook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LoadingIndicatior : NSObject
/**
 @return Singleton instance of LoadingIndicatior
 */
+ (instancetype)indicator;

/**
 @abstract Display indicator on view
 @parm View as UIView object
 */
- (void)showIndicatorOnView:(UIView*)view;

/**
 @abstract Hide indicator on view
 */
- (void)hideIndicator;
@end
