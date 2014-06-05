//
//  NSColor+RGBHex.h
//  TwUI
//
//  Created by Adam Kirk on 6/1/13.
//
//

#import "MYSSharedTypes.h"

#if IOS
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#else
#define RGBA(r, g, b, a) [NSColor colorWithSRGBRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#endif

#define RGB(r, g, b) RGBA(r, g, b, 1.0f)

#define RGBAHex(rgbValue, a) RGBA( \
                                    ((float)((rgbValue & 0xFF0000) >> 16)), \
                                    ((float)((rgbValue & 0xFF00) >> 8)), \
                                    ((float)(rgbValue & 0xFF)), \
                                    a \
                                )

#define RGBHex(rgbValue) RGBAHex(rgbValue, 1.0)

@interface MYSColor (RGBHex)

+ (MYSColor *)mys_colorWithR:(NSInteger)r G:(NSInteger)g B:(NSInteger)b;
+ (MYSColor *)mys_colorWithR:(NSInteger)r G:(NSInteger)g B:(NSInteger)b A:(CGFloat)a;
+ (MYSColor *)mys_colorWithHex:(NSInteger)hex alpha:(CGFloat)alpha;
+ (MYSColor *)mys_colorWithHex:(NSInteger)hex;

@end
