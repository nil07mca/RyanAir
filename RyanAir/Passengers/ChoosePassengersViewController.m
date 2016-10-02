//
//  ChoosePassengersViewController.m
//  RyanAir
//
//  Created by Macbook on 23/09/16.
//  Copyright © 2016 Macbook. All rights reserved.
//

#import "ChoosePassengersViewController.h"
#import "Constants.h"
#import "SearchData.h"

@interface ChoosePassengersViewController (){
    int adults,teen,child;
}
@property (weak, nonatomic) IBOutlet UILabel *lblAdult;
@property (weak, nonatomic) IBOutlet UILabel *lblTeen;
@property (weak, nonatomic) IBOutlet UILabel *lblChild;

@end

@implementation ChoosePassengersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:PAX_SCREEN_TITLE];
    [self initiatePassengerData];
    [self.navigationItem setHidesBackButton:YES];
    // Do any additional setup after loading the view from its nib.
}

- (void)initiatePassengerData {
    adults = [SearchData currentSearch].numberOfAdults;
    teen= [SearchData currentSearch].numberOfTeens;
    child= [SearchData currentSearch].numberOfChilds;
    
    _lblAdult.text = [NSString stringWithFormat:@"%d",adults];
    _lblTeen.text = [NSString stringWithFormat:@"%d",teen];
    _lblChild.text = [NSString stringWithFormat:@"%d",child];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tapAddPax:(id)sender
{
    NSInteger tag = [sender tag];
    if (tag == 2) {
        if (adults<MAX_PAX) {
            adults++;
            _lblAdult.text = [NSString stringWithFormat:@"%d",adults];
        }
    }else if (tag == 4){
        if (teen<MAX_PAX) {
            teen++;
            _lblTeen.text = [NSString stringWithFormat:@"%d",teen];
        }
    }else if (tag == 6){
        if (child<MAX_PAX) {
            child++;
            _lblChild.text = [NSString stringWithFormat:@"%d",child];
        }
    }
}
- (IBAction)tapRemovePax:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    NSInteger tag = [btn tag];
    if (tag == 1) {
        if (adults>MIN_ADULT) {
            adults--;
            _lblAdult.text = [NSString stringWithFormat:@"%d",adults];
        }
    }else if (tag == 3){
        if (teen>MIN_TEEN) {
            teen--;
            _lblTeen.text = [NSString stringWithFormat:@"%d",teen];
        }
    }else if (tag == 5){
        if (child>MIN_CHILD) {
            child--;
            _lblChild.text = [NSString stringWithFormat:@"%d",child];
        }
    }
}

#pragma mark - pax selection complete delegae
- (IBAction)tapDone:(id)sender {
    [SearchData currentSearch].numberOfAdults = adults ;
    [SearchData currentSearch].numberOfTeens = teen;
    [SearchData currentSearch].numberOfChilds = child;
    [self.navigationController popViewControllerAnimated:YES];
}

@end
