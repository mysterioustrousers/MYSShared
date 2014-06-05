//
//  bitmaskhelpers.h
//  Firehose
//
//  Created by Adam Kirk on 6/1/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//


static inline BOOL isInMask(NSUInteger bitmask, NSUInteger value) { return (bitmask & value) == value; }

static inline NSUInteger maskOff(NSUInteger bitmask, NSUInteger value) { return (bitmask & ~value); }

static inline NSUInteger maskOn(NSUInteger bitmask, NSUInteger value) { return (bitmask | value); }
