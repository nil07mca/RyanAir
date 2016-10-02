//
//  FlightSearchViewController.m
//  RyanAir
//
//  Created by Macbook on 24/09/16.
//  Copyright © 2016 Macbook. All rights reserved.
//

#import "FlightSearchViewController.h"
#import "ChoosePassengersViewController.h"
#import "SearchResultsViewController.h"
#import "AirportsViewController.h"
#import "ConnectionManager.h"
#import "Constants.h"
#import "SearchData.h"
#import "Utility.h"
#import "LoadingIndicatior.h"

@interface FlightSearchViewController (){
    BOOL isAirportListLoaded;
}
@property (weak, nonatomic) IBOutlet UILabel *lblPassenger;
@property (weak, nonatomic) IBOutlet UILabel *lblDeperture;
@property (weak, nonatomic) IBOutlet UILabel *lblArraival;
@property (weak, nonatomic) IBOutlet UILabel *lblOutDate;
@property (weak, nonatomic) IBOutlet UILabel *lblInDate;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;

@end

@implementation FlightSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:SEARCH_SCREEN_TITLE];
    [self loadAirports];
    _datePicker.minimumDate = [NSDate date];
    _containerView.hidden = YES;
    isAirportListLoaded = NO;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateSearchCriteria];
}

- (void)updateSearchCriteria {
    
//    Update Arrival and Deperture Airpotr
    if ([self isDepertureAirportSelected])
        _lblDeperture.text = [NSString stringWithFormat:@"%@, %@",[SearchData currentSearch].depertureAirport.airportName,[SearchData currentSearch].depertureAirport.airportCountry];
    
    if ([self isArrivalAirportSelected])
        _lblArraival.text = [NSString stringWithFormat:@"%@, %@",[SearchData currentSearch].arrivalAirport.airportName,[SearchData currentSearch].arrivalAirport.airportCountry];
    
//    Update Passengers count
    NSString* str = [NSString stringWithFormat:@"%d Adult(s)",[SearchData currentSearch].numberOfAdults];
    if ([SearchData currentSearch].numberOfTeens>0)
        str = [str stringByAppendingFormat:@", %d Teen(s)",[SearchData currentSearch].numberOfTeens];
    
    
    if ([SearchData currentSearch].numberOfChilds >0)
        str = [str stringByAppendingFormat:@", %d Child(s)",[SearchData currentSearch].numberOfChilds];
    
    _lblPassenger.text = str;
    
//    Update fly out date
    if ([self isFlyOutSelected])
        _lblOutDate.text = [SearchData currentSearch].flyOutDate;
    
    
//    Check all required are entered
    if ([self isDepertureAirportSelected] && [self isArrivalAirportSelected] && [self isFlyOutSelected])
        _btnSearch.enabled = YES;
    else
        _btnSearch.enabled = NO;
        
}
- (void)loadAirports {
    [[LoadingIndicatior indicator] showIndicatorOnView:self.view];
    [[ConnectionManager sharedManager] loadAirportsWithSuccessHandler:^{
        isAirportListLoaded = YES;
        [[LoadingIndicatior indicator] hideIndicator];
    } andFailureHandler:^(NSError *error) {
        isAirportListLoaded = NO;
        [[LoadingIndicatior indicator] hideIndicator];
        UIAlertController* alert = [[Utility sharedUtils] showAlertWithMessage:[error localizedDescription] andTitle:APP_NAME];
        [self presentViewController:alert animated:YES completion:nil];

    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tapOnSearch:(id)sender {
    SearchResultsViewController* obj = [[SearchResultsViewController alloc] initWithNibName:@"SearchResultsViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:obj animated:YES];
}


- (IBAction)tapOnDepertureOrArrival:(id)sender {
    if (isAirportListLoaded) {
        AirportsViewController* obj = [[AirportsViewController alloc] initWithNibName:@"AirportsViewController" bundle:[NSBundle mainBundle]];
        if ([sender tag] == 1) {
            obj.isDeperture = YES;
        }
        [self.navigationController pushViewController:obj animated:YES];
    }
}
- (IBAction)tapOnPassenger:(id)sender {
    ChoosePassengersViewController* obj = [[ChoosePassengersViewController alloc] initWithNibName:@"ChoosePassengersViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:obj animated:YES];
}
- (IBAction)tapOnDate:(id)sender {
    _containerView.hidden = NO;
    if (![self isFlyOutSelected]) {
       [SearchData currentSearch].flyOutDate = [[Utility sharedUtils] formatDateForSearch:[NSDate date]];
    }
}
- (IBAction)dateSelected:(id)sender {
    [SearchData currentSearch].flyOutDate = [[Utility sharedUtils] formatDateForSearch:_datePicker.date];
}
- (IBAction)tapOnClose:(id)sender {
    _containerView.hidden = YES;
    [self updateSearchCriteria];
}

#pragma mark - Required field checking
- (BOOL) isDepertureAirportSelected {
    return ([SearchData currentSearch].depertureAirport.airportCode)?YES:NO;
}
- (BOOL) isArrivalAirportSelected {
    return ([SearchData currentSearch].arrivalAirport.airportCode)?YES:NO;
}
- (BOOL) isFlyOutSelected {
    return ([SearchData currentSearch].flyOutDate)?YES:NO;
}
@end
