//
//  EnterCoordinates.h
//  Rendezvous
//
//  Created by Bruce Collie on 30/06/2012.
//  Copyright (c) 2012 Balerno High School. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EnterCoordinates : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *latEntry;
@property (weak, nonatomic) IBOutlet UITextField *lonEntry;
@property (weak, nonatomic) IBOutlet UITextField *titleEntry;
@property (weak, nonatomic) IBOutlet UITextField *descEntry;
- (IBAction)showGeneratedPIN:(id)sender;
@end
