//
//  EnterCoordinates.m
//  Rendezvous
//
//  Created by Bruce Collie on 30/06/2012.
//  Copyright (c) 2012 Balerno High School. All rights reserved.
//

#import "EnterCoordinates.h"
#import "Utilities.h"
#import "ShowPIN.h"

@interface EnterCoordinates ()

@end

@implementation EnterCoordinates
@synthesize latEntry;
@synthesize lonEntry;
@synthesize titleEntry;
@synthesize descEntry;

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
    self.title = @"Enter Coordinates";
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setLatEntry:nil];
    [self setLonEntry:nil];
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
    double lati = [[latEntry text] doubleValue];
    double longi = [[lonEntry text] doubleValue];
    NSString *value = [titleEntry.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ((lati == 0) || (lati < -90) || (lati > 90)) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Invalid Coordinate" message:@"Please enter a valid latitude." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    if ((lati == 0) || (lati < -180) || (lati > 180)) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Invalid Coordinate" message:@"Please enter a valid longitude." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
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
    if (popToRootOnAppear) {
        popToRootOnAppear = NO;
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}
@end
