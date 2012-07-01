//
//  BSCViewController.m
//  Rendezvous
//
//  Created by Bruce Collie on 30/06/2012.
//  Copyright (c) 2012 Balerno High School. All rights reserved.
//

#import "BSCViewController.h"
#import "BSCCreateWaypointViewController.h"
#import "ShareLocationViewController.h"
#import "Utilities.h"
#import "FindFriends.h"
#import "FindWaypoint.h"
#import "About.h"

@interface BSCViewController ()

@end

@implementation BSCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Rendezvous";
    UIImage* logo = [UIImage imageNamed:@"logo_transparent.png"];
    logo = [Utilities resizeImage:logo newSize:CGSizeMake(30, 30)];
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.adjustsImageWhenHighlighted = YES;
    button.frame = CGRectMake(00.0f, 0.0f, 30.0f, 30.0f);
    [button addTarget:self action:@selector(about) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:logo forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if(interfaceOrientation == UIInterfaceOrientationPortrait){
        return YES;
    }
    return NO;
}

- (IBAction)createButtonPressed:(id)sender {
    [self.navigationController pushViewController:[[BSCCreateWaypointViewController alloc] init] animated:YES];
}

- (IBAction)shareLocation:(id)sender {
    [self presentModalViewController:[[ShareLocationViewController alloc] init] animated:YES];
}

- (IBAction)findFriends:(id)sender {
    [self.navigationController pushViewController:[[FindFriends alloc] init] animated:YES];
}

- (IBAction)findWaypoint:(id)sender {
    [self.navigationController pushViewController:[[FindWaypoint alloc] init] animated:YES];
}

- (void)about {
    [self presentModalViewController:[[About alloc] init] animated:YES];
}
@end
