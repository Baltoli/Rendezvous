//
//  MapView.h
//  Rendezvous
//
//  Created by Bruce Collie on 01/07/2012.
//  Copyright (c) 2012 Balerno High School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapView : UIViewController

- (id)initWithCenter:(CLLocationCoordinate2D)c Title:(NSString *)t Summary:(NSString *)s;

@property (weak, nonatomic) IBOutlet MKMapView *waypointMap;
@end
