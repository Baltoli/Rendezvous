//
//  FindFriends.m
//  Rendezvous
//
//  Created by Bruce Collie on 01/07/2012.
//  Copyright (c) 2012 Balerno High School. All rights reserved.
//

#import "FindFriends.h"
#import "MapView.h"
#import <CoreLocation/CoreLocation.h>
#import <Parse/Parse.h>

@interface FindFriends ()

@end

@implementation FindFriends
@synthesize pinEntry;

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
    self.title = @"Find Friend";
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setPinEntry:nil];
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

- (IBAction)findFriends:(id)sender {
    PFQuery* query = [PFQuery queryWithClassName:@"Waypoints"];
    [query whereKey:@"pin" equalTo:[pinEntry text]];
    //[query whereKey:@"type" equalTo:@"individual"];
    NSArray* results = [query findObjects];
    if ([results count] == 0) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"No Such User" message:@"Could not find a user for the pin you entered. Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else {
        PFObject* waypoint = [results objectAtIndex:0];
        double lat = [[waypoint objectForKey:@"latitude"] doubleValue];
        double lon = [[waypoint objectForKey:@"longitude"] doubleValue];
        NSString* title = [waypoint objectForKey:@"Title"];
        NSString* summary = [waypoint objectForKey:@"Summary"];
        [self.navigationController pushViewController:[[MapView alloc] initWithCenter:CLLocationCoordinate2DMake(lat, lon) Title:title Summary:summary] animated:YES];
    }
}
@end
