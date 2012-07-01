//
//  ShowPIN.m
//  Rendezvous
//
//  Created by Bruce Collie on 30/06/2012.
//  Copyright (c) 2012 Balerno High School. All rights reserved.
//

#import "EnterMyLocation.h"
#import "ShowPIN.h"
#import <CoreLocation/CoreLocation.h>

@interface ShowPIN ()

@end

@implementation ShowPIN
@synthesize PINLabel;

NSString* pinText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithPIN:(NSString *)pin {
    self = [super init];
    pinText = pin;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setPINLabel:nil];
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

- (IBAction)donePressed:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    PINLabel.text = pinText;
}
@end
