//
//  MKMapView+Center.m
//  FirehoseChat
//
//  Created by Dan Willoughby on 5/27/14.
//  Copyright (c) 2014 Adam Kirk. All rights reserved.
//

#import "MKMapView+Center.h"


@implementation MKMapView (Center)


- (MKMapRect)fhs_mapRectFromRegion:(MKCoordinateRegion)region
{
    CLLocationCoordinate2D topLeftCoordinate =
    CLLocationCoordinate2DMake(region.center.latitude
                               + (region.span.latitudeDelta/2.0),
                               region.center.longitude
                               - (region.span.longitudeDelta/2.0));
    
    MKMapPoint topLeftMapPoint = MKMapPointForCoordinate(topLeftCoordinate);
    
    CLLocationCoordinate2D bottomRightCoordinate =
    CLLocationCoordinate2DMake(region.center.latitude
                               - (region.span.latitudeDelta/2.0),
                               region.center.longitude
                               + (region.span.longitudeDelta/2.0));
    
    MKMapPoint bottomRightMapPoint = MKMapPointForCoordinate(bottomRightCoordinate);
    
    MKMapRect mapRect = MKMapRectMake(topLeftMapPoint.x,
                                      topLeftMapPoint.y,
                                      fabs(bottomRightMapPoint.x-topLeftMapPoint.x),
                                      fabs(bottomRightMapPoint.y-topLeftMapPoint.y));
    
    return mapRect;
}

@end
