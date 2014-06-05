//
//  MYSByteCountFormatter.m
//  FirehoseChat
//
//  Created by Adam Kirk on 6/5/14.
//  Copyright (c) 2014 Adam Kirk. All rights reserved.
//

#import "MYSByteCountFormatter.h"

static const char sUnits[] = { '\0', 'K', 'M', 'G', 'T', 'P', 'E', 'Z', 'Y' };
static int sMaxUnits = sizeof sUnits - 1;

@implementation MYSByteCountFormatter

+(NSString *)stringFromByteCount:(long long)byteCount countStyle:(DOByteCountFormatterCountStyle)countStyle
{
    if ([NSByteCountFormatter class] != nil) {
        return [NSByteCountFormatter stringFromByteCount:byteCount countStyle:(NSByteCountFormatterCountStyle)countStyle];
    } else {
        MYSByteCountFormatter *formatter = [[MYSByteCountFormatter alloc] init];
        formatter.countStyle = countStyle;
        return [formatter stringFromByteCount:byteCount];
    }
}

-(BOOL)useDecimalStyle
{
    return self.countStyle == DOByteCountFormatterCountStyleDecimal ||
    self.countStyle == DOByteCountFormatterCountStyleBinary;
}

-(NSString *)stringForObjectValue:(id)obj
{
    if (![obj isKindOfClass:[NSNumber class]])
        return nil;

    if ([NSByteCountFormatter class] != nil) {
        return [NSByteCountFormatter stringFromByteCount:[obj longLongValue] countStyle:(NSByteCountFormatterCountStyle)[self countStyle]];
    } else {
        NSUInteger decimals = 0;
        NSUInteger multiplier = [self useDecimalStyle] ? 1000 : 1024;
        NSUInteger exponent = 0;

        double convertedSize = [obj doubleValue];

        while ((convertedSize >= multiplier) && (exponent < sMaxUnits)) {
            convertedSize /= multiplier;
            exponent++;
        }

        if (exponent == 1) {        // KB
            if (convertedSize >= 10)
                decimals = 0;
            else
                decimals = 1;
        } else if (exponent == 2) { // MB
            decimals = 1;
        } else {                    // Everything else
            decimals = 2;
        }

        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle: NSNumberFormatterDecimalStyle];
        [formatter setMinimumFractionDigits:0];
        [formatter setMaximumFractionDigits:decimals];

        NSString *bytesString = [NSString stringWithFormat:@"%@ %cB", [formatter stringFromNumber:[NSNumber numberWithDouble:convertedSize]], sUnits[exponent]];


        return bytesString;
    }
}

-(NSString *)stringFromByteCount:(long long)byteCount
{
    return [self stringForObjectValue:[NSNumber numberWithLongLong:byteCount]];
}

@end
