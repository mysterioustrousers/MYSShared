//
//  FHLogging.h
//  Firehose
//
//  Created by Adam Kirk on 8/8/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#ifndef DLog
    #if defined(DEBUG)
        #define DLog(...) NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSString stringWithFormat:__VA_ARGS__])
    #else
        #define DLog(...) do { } while (0)
    #endif
#endif
