//
//  ShareLocationViewController.h
//  Rendezvous
//
//  Created by Bruce Collie on 01/07/2012.
//  Copyright (c) 2012 Balerno High School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ShareLocationViewController : UIViewController <CLLocationManagerDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *pinLabel;
- (IBAction)shareLocation:(id)sender;
@property (weak, nonatomic) IBOutlet UINavigationBar *navItem;
- (IBAction)cancel:(id)sender;
@property (weak, nonatomic) IBOutlet UINavigationItem *nav;
@property (weak, nonatomic) IBOutlet UITextField *descEntry;

@property (strong, nonatomic) CLLocationManager* lm;
@end
