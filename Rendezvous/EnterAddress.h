//
//  EnterAddress.h
//  Rendezvous
//
//  Created by Bruce Collie on 30/06/2012.
//  Copyright (c) 2012 Balerno High School. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EnterAddress : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *titleEntry;
@property (weak, nonatomic) IBOutlet UITextField *descEntry;
@property (weak, nonatomic) IBOutlet UITextField *addressEntry;
- (IBAction)showGeneratedPIN:(id)sender;
@end
