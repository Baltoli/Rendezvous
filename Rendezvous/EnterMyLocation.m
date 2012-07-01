//
//  EnterMyLocation.m
//  Rendezvous
//
//  Created by Bruce Collie on 30/06/2012.
//  Copyright (c) 2012 Balerno High School. All rights reserved.
//

#import "EnterMyLocation.h"
#import "ShowPIN.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>
#import "Utilities.h"

@interface EnterMyLocation ()

@end

@implementation EnterMyLocation
@synthesize latLabel;
@synthesize longLabel;
@synthesize pinButton;
@synthesize lm;
@synthesize titleEntry;
@synthesize descEntry;

bool popToRootOnAppear;
double lati;
double longi;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"My Location";
    // Do any additional setup after loading the view from its nib.
}

- (void)dismissKeyboard {
    self.navigationItem.rightBarButtonItem = nil;
    [self.view endEditing:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(dismissKeyboard)];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(dismissKeyboard)];
}

- (void)viewDidUnload
{
    [self setPinButton:nil];
    [self setLatLabel:nil];
    [self setLongLabel:nil];
    [self setLm:nil];
    [self setTitleEntry:nil];
    [self setDescEntry:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if(interfaceOrientation == UIInterfaceOrientationPortrait){
        return YES;
    }
    return NO;
}

- (IBAction)showGeneratedPIN:(id)sender {
    NSString *value = [titleEntry.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([value length] == 0) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Title is Empty" message:@"Please enter a title for this waypoint." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else {
        NSString* pin = [Utilities getPINFrom:[titleEntry text] andDescription:[descEntry text]];
        [Utilities uploadWaypointToParseWithTitle:[titleEntry text] Description:[descEntry text] Type:@"Waypoint" Latitude:lati Longitude:longi PIN:pin];
        ShowPIN* s = [[ShowPIN alloc] initWithPIN:pin];
        popToRootOnAppear = YES;
        [self presentModalViewController:s animated:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    lm = [[CLLocationManager alloc] init];
    lm.delegate = self;
    lm.desiredAccuracy = kCLLocationAccuracyBest;
    lm.distanceFilter = kCLDistanceFilterNone; 
    [lm startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    lati = newLocation.coordinate.latitude;
    longi = newLocation.coordinate.longitude;
    self.latLabel.text = [NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
    self.longLabel.text = [NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];
}

- (void)viewWillDisappear:(BOOL)animated {
    lm.delegate = nil;
    lm = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    if (popToRootOnAppear) {
        popToRootOnAppear = NO;
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}
@end
