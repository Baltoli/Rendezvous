//
//  BSCCreateWaypointViewController.m
//  Rendezvous
//
//  Created by Bruce Collie on 30/06/2012.
//  Copyright (c) 2012 Balerno High School. All rights reserved.
//

#import "BSCCreateWaypointViewController.h"
#import "EnterMyLocation.h"
#import "EnterAddress.h"
#import "EnterCoordinates.h"

@interface BSCCreateWaypointViewController ()

@end

@implementation BSCCreateWaypointViewController
@synthesize tabBar;
@synthesize contentView;
@synthesize createAddress;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    self.title = @"Create Waypoint";
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tabBar setSelectedItem:[[self.tabBar items] objectAtIndex:0]];
    [self tabBar:tabBar didSelectItem:[[tabBar items] objectAtIndex:0]];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setTabBar:nil];
    [self setContentView:nil];
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

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {

}
- (IBAction)pushMyLocationView:(id)sender {
    EnterMyLocation* myLocationEntry = [[EnterMyLocation alloc] init];
    [self.navigationController pushViewController:myLocationEntry animated:YES];
}

- (IBAction)pushAddressView:(id)sender {
    EnterAddress* myLocationEntry = [[EnterAddress alloc] init];
    [self.navigationController pushViewController:myLocationEntry animated:YES];
}

- (IBAction)pushCoordinateView:(id)sender {
    EnterCoordinates* myLocationEntry = [[EnterCoordinates alloc] init];
    [self.navigationController pushViewController:myLocationEntry animated:YES];
}
@end
