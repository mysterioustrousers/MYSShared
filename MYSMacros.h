//
//  macros.h
//  Firehose
//
//  Created by Adam Kirk on 4/10/14.
//  Copyright (c) 2014 Mysterious Trousers. All rights reserved.
//

// swaps NSNull for nil
#define NILL(a) ([a isKindOfClass:[NSNull class]] ? nil : a)

// swaps nil for NSNull
#define NUL(a) a ? a : [NSNull null]

// Framework type
#define IOS (TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE)

// iPad interface detection
#if IOS
    // check if device is iPad or iPhone/iPod Touch
    #define PAD ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#endif
