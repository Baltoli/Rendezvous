//
//  FindWaypoint.h
//  Rendezvous
//
//  Created by Bruce Collie on 01/07/2012.
//  Copyright (c) 2012 Balerno High School. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindWaypoint : UIViewController

- (IBAction)findWaypoint:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *pinEntry;
@end
