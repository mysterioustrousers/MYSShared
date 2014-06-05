//
//  MORDescriber.m
//  Firehose
//
//  Created by Adam Kirk on 11/13/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "MYSDescriber.h"
#import "MYSByteCountFormatter.h"
#import <objc/runtime.h>


@implementation MYSDescriber

#if IOS
+ (NSString *)describeView:(UIView *)view
{
    NSMutableString *description = [NSMutableString new];
    [description appendFormat:@"<%@ %p>\n", NSStringFromClass([view class]), (void *)view];
    [description appendFormat:@"frame: %@\n", NSStringFromCGRect(view.frame)];
    [description appendFormat:@"bounds: %@\n", NSStringFromCGRect(view.bounds)];
    [description appendFormat:@"alpha: %f\n", view.alpha];
    [description appendFormat:@"hidden: %d\n", view.isHidden];
    return description;
}
#else
+ (NSString *)describeView:(NSView *)view
{
    NSMutableString *description = [NSMutableString new];
    [description appendFormat:@"<%@ %p>\n", NSStringFromClass([view class]), (void *)view];
    [description appendFormat:@"frame: %@\n", NSStringFromRect(view.frame)];
    [description appendFormat:@"bounds: %@\n", NSStringFromRect(view.bounds)];
    [description appendFormat:@"alpha: %f\n", view.alphaValue];
    [description appendFormat:@"hidden: %d\n", view.isHidden];
    return description;
}
#endif

+ (NSString *)describeObject:(id)object
{
    return [self describeObject:object indent:0];
}

+ (NSString *)describeObject:(id)object indent:(NSUInteger)level
{
    NSString *indent = [@"" stringByPaddingToLength:(level * 4) withString:@" " startingAtIndex:0];
    NSString *d = [NSString stringWithFormat:@"%@{\n", indent];

    unsigned int numberOfProperties = 0;
    NSUInteger longestNameLength = 0;
    objc_property_t *propertyArray = class_copyPropertyList([object class], &numberOfProperties);

    // First pass: determine the longest name so we can vertically align names and values.
    for (NSUInteger i = 0; i < numberOfProperties; i++) {
        objc_property_t property = propertyArray[i];
        NSString *name = [[NSString alloc] initWithUTF8String:property_getName(property)];
        if (name.length > longestNameLength) {
            longestNameLength = name.length;
        }
    }
    // Second pass: construct the string
    for (NSUInteger i = 0; i < numberOfProperties; i++) {
        objc_property_t property = propertyArray[i];
        NSString *name = [[NSString alloc] initWithUTF8String:property_getName(property)];
        NSString *paddedName = [name stringByPaddingToLength:longestNameLength withString:@" " startingAtIndex:0];

        id value = [object valueForKey:name];
        NSString *valueDescrip = nil;

        // If the class supports it, specify the indent level
        if ([value respondsToSelector:@selector(descriptionWithLocale:indent:)]) {
            valueDescrip = [value descriptionWithLocale:[NSLocale currentLocale] indent:(level + 1)];
            valueDescrip = [@"\n" stringByAppendingString:valueDescrip];
        } else {
            valueDescrip = [value description];
        }

        // Limit the output of data objects
        static NSUInteger maxLength = 100;
        if ([value isKindOfClass:[NSData class]] && valueDescrip.length > maxLength) {
            // Append the byte count
            NSString *byteCount = [MYSByteCountFormatter stringFromByteCount:[value length]
                                                                 countStyle:DOByteCountFormatterCountStyleMemory];
            valueDescrip = [NSString stringWithFormat:@"%@... (%@)",
                            [valueDescrip substringToIndex:(maxLength - 1)], byteCount];
        }

        d = [d stringByAppendingFormat:@"%@\t%@ : %@\n", indent, paddedName, valueDescrip];
    }
    free(propertyArray);

    d = [d stringByAppendingFormat:@"%@}", indent];

    return d;
}

@end
