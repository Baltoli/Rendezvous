//
//  Utilities.h
//  Rendezvous
//
//  Created by Bruce Collie on 30/06/2012.
//  Copyright (c) 2012 Balerno High School. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utilities : NSObject

+ (NSString *)getPINFrom:(NSString *)title andDescription:(NSString *)desc;
+ (NSString *) genRandStringLength: (int) len;
+ (void)uploadWaypointToParseWithTitle:(NSString *)title Description:(NSString *)description Type:(NSString *)type Latitude:(double)latitude Longitude:(double)longitude PIN:(NSString *)pin;
+ (UIImage *)resizeImage:(UIImage*)image newSize:(CGSize)newSize;
@end
