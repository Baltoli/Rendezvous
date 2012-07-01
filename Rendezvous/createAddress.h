//
//  createAddress.h
//  Rendezvous
//
//  Created by Bruce Collie on 30/06/2012.
//  Copyright (c) 2012 Balerno High School. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface createAddress : UIView

@property (weak, nonatomic) IBOutlet UITextField *addressEntry;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
- (IBAction)okPressed:(id)sender;
@end
