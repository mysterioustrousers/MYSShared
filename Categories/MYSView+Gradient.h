//
//  NSView+Gradient.h
//  Firehose
//
//  Created by Adam Kirk on 12/6/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "MYSSharedTypes.h"


@interface MYSView (Gradient)
- (void)drawGradientFromPoint:(CGPoint)point1 color:(MYSColor *)color1 toPoint:(CGPoint)point2 color:(MYSColor *)color2;
@end
