//
//  Utilities.m
//  Rendezvous
//
//  Created by Bruce Collie on 30/06/2012.
//  Copyright (c) 2012 Balerno High School. All rights reserved.
//

#import "Utilities.h"
#import "NSString+MD5.h"
#import <Parse/Parse.h>

@implementation Utilities

+ (NSString *)getPINFrom:(NSString *)title andDescription:(NSString *)desc {
    NSString* output = [NSString stringWithFormat:@"%@%@%@", title, [self genRandStringLength:8], desc];
    return [[output MD5] substringToIndex:8];
}

+ (NSString *) genRandStringLength: (int) len {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
    }
    return randomString;
}

+ (void)uploadWaypointToParseWithTitle:(NSString *)title Description:(NSString *)description Type:(NSString *)type Latitude:(double)latitude Longitude:(double)longitude PIN:(NSString *)pin {
    PFObject* waypoint = [PFObject objectWithClassName:@"Waypoints"];
    [waypoint setObject:title forKey:@"Title"];
    [waypoint setObject:description forKey:@"Summary"];
    [waypoint setObject:type forKey:@"type"];
    [waypoint setObject:[NSString stringWithFormat:@"%f", latitude] forKey:@"latitude"];
    [waypoint setObject:[NSString stringWithFormat:@"%f", longitude] forKey:@"longitude"];
    [waypoint setObject:pin forKey:@"pin"];
    [waypoint saveInBackground];
}


+ (UIImage *)resizeImage:(UIImage*)image newSize:(CGSize)newSize {
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    CGImageRef imageRef = image.CGImage;
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Set the quality level to use when rescaling
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGAffineTransform flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, newSize.height);
    
    CGContextConcatCTM(context, flipVertical);  
    // Draw into the context; this scales the image
    CGContextDrawImage(context, newRect, imageRef);
    
    // Get the resized image from the context and a UIImage
    CGImageRef newImageRef = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    CGImageRelease(newImageRef);
    UIGraphicsEndImageContext();    
    
    return newImage;
}
@end
