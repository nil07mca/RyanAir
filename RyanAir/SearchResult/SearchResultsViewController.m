//
//  SearchResultsViewController.m
//  RyanAir
//
//  Created by Macbook on 24/09/16.
//  Copyright © 2016 Macbook. All rights reserved.
//

#import "SearchResultsViewController.h"
#import "ConnectionManager.h"
#import "SearchResult.h"
#import "DataManager.h"
#import "Flight.h"
#import "ResultCell.h"
#import "Utility.h"
#import "Constants.h"
#import "LoadingIndicatior.h"

@interface SearchResultsViewController (){
    int currentDisplayIndex;
}
@property(nonatomic,retain)NSArray* searchResults;
@property(nonatomic,retain)NSArray* arrFlightsData;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UITableView *tblResults;

@end

@implementation SearchResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:RESULT_SCREEN_TITLE];
    [self initiateSearch];
    [_tblResults registerNib:[UINib nibWithNibName:@"ResultCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ResultCell"];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)tapOnPrevNext:(id)sender {
    if ([sender tag] ==1 ){
        if (currentDisplayIndex >1)
            currentDisplayIndex--;
    }
    else {
        if(currentDisplayIndex < [_searchResults count]-1)
            currentDisplayIndex++;
    }
    
    [self reconstructDatePanel];
}

- (void) initiateSearch {
    [[LoadingIndicatior indicator] showIndicatorOnView:self.view];
    [[ConnectionManager sharedManager] searchFlightsWithSuccessHandler:^{
        _searchResults = [[DataManager sharedManager] retiveSearchResult];
        currentDisplayIndex = (int)[_searchResults count]/2 ;
        [self reconstructDatePanel];
        [[LoadingIndicatior indicator] hideIndicator];
    } andFailureHandler:^(NSError *error) {
        [[LoadingIndicatior indicator] hideIndicator];
        UIAlertController* alert = [[Utility sharedUtils] showAlertWithMessage:[error localizedDescription] andTitle:APP_NAME];
        [self presentViewController:alert animated:YES completion:nil];
    }];
}

- (void)reconstructDatePanel {
    if ([_searchResults count]>0) {
        SearchResult *result = [_searchResults objectAtIndex:currentDisplayIndex];
        NSString* date = result.depertureDate;
        NSArray* ar = [date componentsSeparatedByString:@"T"];
        if ([ar count]>0) {
            date = [ar objectAtIndex:0];
        }
        _lblDate.text  = [[Utility sharedUtils] extractLongDateFromDateString:result.depertureDate];
        _arrFlightsData = result.flights;
    }
    [_tblResults reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    do more stuff here
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1; // only want one section to display data in this case
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arrFlightsData count];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString* headerTitle = @"";
    if ([_arrFlightsData count]==0) {
        headerTitle = NO_FLIGHTS;
    }
    return headerTitle;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"ResultCell";
    ResultCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell = [self configureCell:cell forIndexPath:indexPath];
    return cell;
}

- (ResultCell *) configureCell:(ResultCell *)cell forIndexPath:(NSIndexPath*)indexPath {
    SearchResult *result = [_searchResults objectAtIndex:currentDisplayIndex];
    Flight *flight = _arrFlightsData[indexPath.row];
    cell.lblFlightNumber.text = flight.flightNumber;
    cell.lblFlightDuration.text = flight.flightDuration;
    cell.lblDepertute.text = result.depertureAirport;
    cell.lblArrival.text = result.arrivalAirport;
    cell.lblFlightDuration.text = [[Utility sharedUtils] formatFlightDuration:flight.flightDuration];
    cell.lblDepertureTime.text = [[Utility sharedUtils] extractTimeFromDateString:flight.depertureTime];
    cell.lblArrivalTime.text = [[Utility sharedUtils] extractTimeFromDateString:flight.arrivalTime];
    NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"type contains[c] %@",@"ADT"];
    NSArray* ecoFares = [flight.economyFares filteredArrayUsingPredicate:filterPredicate];
    if ([ecoFares count]>0) {
        Fare* fare = [ecoFares objectAtIndex:0];
        cell.lblEcoPrice.text = [NSString stringWithFormat:@"%.2f\n%@",fare.amount,result.currency];
    }

    return cell;
}

@end
