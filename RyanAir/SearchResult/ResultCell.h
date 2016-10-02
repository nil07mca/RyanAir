//
//  ResultCell.h
//  RyanAir
//
//  Created by Macbook on 25/09/16.
//  Copyright © 2016 Macbook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblFlightNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblEcoPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblDepertute;
@property (weak, nonatomic) IBOutlet UILabel *lblArrival;
@property (weak, nonatomic) IBOutlet UILabel *lblDepertureTime;
@property (weak, nonatomic) IBOutlet UILabel *lblArrivalTime;
@property (weak, nonatomic) IBOutlet UILabel *lblFlightDuration;

@end
