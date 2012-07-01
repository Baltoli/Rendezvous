//
//  ShowPIN.h
//  Rendezvous
//
//  Created by Bruce Collie on 30/06/2012.
//  Copyright (c) 2012 Balerno High School. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowPIN : UIViewController

- (IBAction)donePressed:(id)sender;
- (id)initWithPIN:(NSString *)pin;
@property (weak, nonatomic) IBOutlet UILabel *PINLabel;
@end
