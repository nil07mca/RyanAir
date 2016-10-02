//
//  LoadingIndicatior.m
//  RyanAir
//
//  Created by Macbook on 25/09/16.
//  Copyright © 2016 Macbook. All rights reserved.
//

#import "LoadingIndicatior.h"

@interface LoadingIndicatior()
@property (nonatomic, strong) UIView *loadingView;
@property (nonatomic, strong) UILabel *loadingLabel;
@end
@implementation LoadingIndicatior
+ (instancetype)indicator
{
    static LoadingIndicatior *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LoadingIndicatior alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

- (void)showIndicatorOnView:(UIView*)view {
    if(!_loadingView){
     _loadingView = [[UIView alloc] initWithFrame:view.bounds];
    }
    _loadingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    if (!_loadingLabel) {
        _loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 320, view.frame.size.width-50, 22)];
    }
    _loadingLabel.backgroundColor = [UIColor clearColor];
    _loadingLabel.textColor = [UIColor whiteColor];
    _loadingLabel.adjustsFontSizeToFitWidth = YES;
    _loadingLabel.textAlignment = NSTextAlignmentCenter;
    _loadingLabel.text = @"Loading...";
    [_loadingView addSubview:_loadingLabel];
    
    [view addSubview:_loadingView];
}

- (void)hideIndicator {
    [_loadingView removeFromSuperview];
}
@end
