//
//  NSView+Gradient.m
//  Firehose
//
//  Created by Adam Kirk on 12/6/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "MYSView+Gradient.h"

@implementation MYSView (Gradient)

- (void)drawGradientFromPoint:(CGPoint)point1 color:(MYSColor *)color1 toPoint:(CGPoint)point2 color:(MYSColor *)color2
{
#if IOS
    CGContextRef context = UIGraphicsGetCurrentContext();
#else
    CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];
#endif
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    NSArray *colors = @[ (__bridge id)color1.CGColor, (__bridge id)color2.CGColor ];

    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colors, locations);
    CGContextDrawLinearGradient(context, gradient, point1, point2, 0);

    CFRelease(gradient);
    CFRelease(colorSpace);
}

@end
