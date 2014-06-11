//
//  MKMapView+Center.h
//  FirehoseChat
//
//  Created by Dan Willoughby on 5/27/14.
//  Copyright (c) 2014 Adam Kirk. All rights reserved.
//

#import <MapKit/MapKit.h>


@interface MKMapView (Center)
- (MKMapRect)fhs_mapRectFromRegion:(MKCoordinateRegion)region;
@end
