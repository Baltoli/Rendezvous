//
//  ShareLocationViewController.m
//  Rendezvous
//
//  Created by Bruce Collie on 01/07/2012.
//  Copyright (c) 2012 Balerno High School. All rights reserved.
//

#import "ShareLocationViewController.h"
#import "Utilities.h"
#import <Parse/Parse.h>

@interface ShareLocationViewController ()

@end

@implementation ShareLocationViewController
@synthesize nav;
@synthesize descEntry;
@synthesize navItem;
@synthesize pinLabel;
@synthesize lm;

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
    /*UIImage* logo = [UIImage imageNamed:@"logo_transparent.png"];
    logo = [Utilities resizeImage:logo newSize:CGSizeMake(30, 30)];
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.adjustsImageWhenHighlighted = NO;
    button.frame = CGRectMake(0.0f, 0.0f, 30.0f, 30.0f);
    [button setImage:logo forState:UIControlStateNormal];
    nav.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];*/
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString* pin = [defaults objectForKey:@"userpin"];
    pinLabel.text = pin;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setPinLabel:nil];
    [self setNavItem:nil];
    [self setNav:nil];
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
}

- (void)viewWillDisappear:(BOOL)animated {
    lm.delegate = nil;
    lm = nil;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[[alertView textFieldAtIndex:0] text] forKey:@"name"];
    [defaults synchronize];
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)shareLocation:(id)sender {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"name"] == nil) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Enter Name" message:@"Please enter your name to share your location with friends. This cannot be changed once it has been set." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alert show];
    }
    else {
        PFQuery* query = [PFQuery queryWithClassName:@"Waypoints"];
        [query whereKey:@"pin" equalTo:[defaults objectForKey:@"userpin"]];
        NSArray* results = [query findObjects];
        if ([results count] == 0) {
            [Utilities uploadWaypointToParseWithTitle:[defaults objectForKey:@"name"] Description:[descEntry text] Type:@"individual" Latitude:lati Longitude:longi PIN:[defaults objectForKey:@"userpin"]];
        }
        else {
            PFObject* user = [results objectAtIndex:0];
            [user setObject:[descEntry text] forKey:@"Summary"];
            [user setObject:[NSString stringWithFormat:@"%f", lati] forKey:@"latitude"];
            [user setObject:[NSString stringWithFormat:@"%f", longi] forKey:@"longitude"];
            [user saveInBackground];
        }
        [self dismissModalViewControllerAnimated:YES];
    }
}
- (IBAction)cancel:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
