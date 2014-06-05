//
//  FSSharedTypes.h
//  Firehose
//
//  Created by Adam Kirk on 2/10/14.
//  Copyright (c) 2014 Mysterious Trousers. All rights reserved.
//

#import "MYSMacros.h"

#if IOS
#define MYSView UIView
#define MYSImage UIImage
#define MYSColor UIColor
#define MYSImageView UIImageView
#else
#define MYSView NSView
#define MYSImage NSImage
#define MYSColor NSColor
#define MYSImageView NSImageView
#endif
