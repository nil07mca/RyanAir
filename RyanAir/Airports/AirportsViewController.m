//
//  AirportsViewController.m
//  RyanAir
//
//  Created by Macbook on 24/09/16.
//  Copyright © 2016 Macbook. All rights reserved.
//

#import "AirportsViewController.h"
#import "SearchData.h"
#import "Airport.h"
#import "Constants.h"
#import "DataManager.h"

@interface AirportsViewController ()
@property(nonatomic,retain)NSArray* airportList;
@property (weak, nonatomic) IBOutlet UITableView *tblAirportList;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation AirportsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] init];
    barButton.title = @"Back";
    self.navigationController.navigationBar.topItem.backBarButtonItem = barButton;
    _airportList = [[DataManager sharedManager] retriveAirportList];
    if (_isDeperture)
        [self setTitle:DEPERTURE_TITLE];
    else
        [self setTitle:ARRIVAL_TITLE];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Airport *airport = _airportList[indexPath.row];
    if (_isDeperture)
        [SearchData currentSearch].depertureAirport = airport;
    else
        [SearchData currentSearch].arrivalAirport = airport;
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1; // only want one section to display data in this case
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_airportList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    Airport *airport = _airportList[indexPath.row];
    cell.textLabel.text = airport.airportName;
    cell.detailTextLabel.text = airport.airportCountry;
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

- (void)tableView: (UITableView *)tableView willDisplayCell: (UITableViewCell *)cell forRowAtIndexPath: (NSIndexPath *)indexPath {
    
    if (indexPath.row %2) { //change the "%2" depending on how many cells you want alternating.
        UIColor *altCellColor = [UIColor colorWithRed:255/255.0 green:237/255.0 blue:227/255.0 alpha:1.0]; //this can be changed, at the moment it sets the background color to red.
        cell.backgroundColor = altCellColor;
    }
    else {
        UIColor *altCellColor2 = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:227/255.0 alpha:1.0]; //this can be changed, at the moment it sets the background color to white.
        cell.backgroundColor = altCellColor2;
    }
}

#pragma mark - UISearchBar Delegate
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    //NSLog(@"%@",searchText);
    NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"airportName contains[c] %@ OR airportCountry contains[c] %@ OR airportCode contains[c] %@", searchText,searchText,searchText];
    _airportList = [[[DataManager sharedManager] retriveAirportList] filteredArrayUsingPredicate:filterPredicate];
    [_tblAirportList reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    _airportList = [[DataManager sharedManager] retriveAirportList];
    [_tblAirportList reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}
@end
