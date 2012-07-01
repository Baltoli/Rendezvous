//
//  BSCCreateWaypointViewController.h
//  Rendezvous
//
//  Created by Bruce Collie on 30/06/2012.
//  Copyright (c) 2012 Balerno High School. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSCCreateWaypointViewController : UIViewController <UITabBarDelegate>

@property (weak, nonatomic) IBOutlet UITabBar *tabBar;
@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (nonatomic, retain) IBOutlet UIView *createAddress;
- (IBAction)pushMyLocationView:(id)sender;
- (IBAction)pushAddressView:(id)sender;
- (IBAction)pushCoordinateView:(id)sender;
@end
