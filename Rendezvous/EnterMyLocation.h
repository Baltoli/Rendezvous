//
//  EnterMyLocation.h
//  Rendezvous
//
//  Created by Bruce Collie on 30/06/2012.
//  Copyright (c) 2012 Balerno High School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface EnterMyLocation : UIViewController <CLLocationManagerDelegate, UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *pinButton;
- (IBAction)showGeneratedPIN:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *latLabel;
@property (weak, nonatomic) IBOutlet UILabel *longLabel;
@property (strong, nonatomic) CLLocationManager* lm;
@property (weak, nonatomic) IBOutlet UITextField *titleEntry;
@property (weak, nonatomic) IBOutlet UITextField *descEntry;
@end
