//
//  EnterAddress.m
//  Rendezvous
//
//  Created by Bruce Collie on 30/06/2012.
//  Copyright (c) 2012 Balerno High School. All rights reserved.
//

#import "EnterAddress.h"
#import "Utilities.h"
#import "ShowPIN.h"
#import <CoreLocation/CoreLocation.h>

@interface EnterAddress ()

@end

@implementation EnterAddress
@synthesize titleEntry;
@synthesize descEntry;
@synthesize addressEntry;

double lat;
double lon;
bool popToRootOnAppear;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dismissKeyboard {
    self.navigationItem.rightBarButtonItem = nil;
    [self.view endEditing:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(dismissKeyboard)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Enter Address";
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setTitleEntry:nil];
    [self setDescEntry:nil];
    [self setAddressEntry:nil];
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
    CLGeocoder* coder = [[CLGeocoder alloc] init];
    [coder geocodeAddressString:[addressEntry text] completionHandler: ^(NSArray *placemarks, NSError *error) {
        CLPlacemark* place = [placemarks objectAtIndex:0];
        lat = place.location.coordinate.latitude;
        lon = place.location.coordinate.longitude;
        NSString *value = [titleEntry.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if ([value length] == 0) {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Title is Empty" message:@"Please enter a title for this waypoint." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        if ((lat == 0) || (lon == 0)) {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Cannot Find Address" message:@"Could not find a location for the address you entered. Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        else {
            NSString* pin = [Utilities getPINFrom:[titleEntry text] andDescription:[descEntry text]];
            [Utilities uploadWaypointToParseWithTitle:[titleEntry text] Description:[descEntry text] Type:@"Waypoint" Latitude:lat Longitude:lon PIN:pin];
            ShowPIN* s = [[ShowPIN alloc] initWithPIN:pin];
            popToRootOnAppear = YES;
            [self presentModalViewController:s animated:YES];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    if (popToRootOnAppear) {
        popToRootOnAppear = NO;
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}
@end
