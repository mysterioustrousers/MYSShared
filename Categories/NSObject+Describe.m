//
//  NSObject+Describe.m
//  FirehoseChat
//
//  Created by Adam Kirk on 7/11/14.
//  Copyright (c) 2014 Adam Kirk. All rights reserved.
//

#if DEBUG

#import "NSObject+Describe.h"
#import "MYSDescriber.h"
#import <objc/runtime.h>


@implementation NSObject (Describe)

- (NSString *)d
{
    return [MYSDescriber describeObject:self indent:1];
}

@end

#endif