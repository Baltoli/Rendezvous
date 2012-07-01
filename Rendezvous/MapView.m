//
//  MapView.m
//  Rendezvous
//
//  Created by Bruce Collie on 01/07/2012.
//  Copyright (c) 2012 Balerno High School. All rights reserved.
//

#import "MapView.h"
#import "MKMapView+ZoomLevel.h"
#import <CoreLocation/CoreLocation.h>

@interface MapView ()

@end

@implementation MapView
@synthesize waypointMap;

CLLocationCoordinate2D center;
NSString* title;
NSString* summary;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCenter:(CLLocationCoordinate2D)c Title:(NSString *)t Summary:(NSString *)s {
    center = c;
    title = t;
    summary = s;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [waypointMap setCenterCoordinate:center zoomLevel:8 animated:NO];
    self.title = title;
    MKPointAnnotation* point = [[MKPointAnnotation alloc] init];
    [point setCoordinate:center];
    [point setTitle:summary];
    [waypointMap addAnnotation:point];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setWaypointMap:nil];
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

@end
