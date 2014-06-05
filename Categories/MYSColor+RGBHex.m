//
//  NSColor+RGBHex.m
//  TwUI
//
//  Created by Adam Kirk on 6/1/13.
//
//

#import "MYSColor+RGBHex.h"


@implementation MYSColor (RGBHex)


#pragma mark - RGB

+ (MYSColor *)mys_colorWithR:(NSInteger)r G:(NSInteger)g B:(NSInteger)b
{
    return [self mys_colorWithR:r G:g B:b A:1.0f];
}

+ (MYSColor *)mys_colorWithR:(NSInteger)r G:(NSInteger)g B:(NSInteger)b A:(CGFloat)a
{
#if IOS
    return [MYSColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a];
#else
    return [MYSColor colorWithCalibratedRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a];
#endif
}


#pragma mark - HEX

+ (MYSColor *)mys_colorWithHex:(NSInteger)hex alpha:(CGFloat)alpha
{
    NSInteger red   = (hex & 0xFF0000) >> 16;
    NSInteger green = (hex & 0xFF00)   >> 8;
    NSInteger blue  = (hex & 0xFF);
    return [self mys_colorWithR:red G:green B:blue A:alpha];
}

+ (MYSColor *)mys_colorWithHex:(NSInteger)hex
{
    return [self mys_colorWithHex:hex alpha:1.0f];
}

@end
