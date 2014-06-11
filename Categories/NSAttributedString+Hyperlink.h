//
//  NSAttributedString+Hyperlink.h
//  FirehoseChat
//
//  Created by Adam Kirk on 6/11/14.
//  Copyright (c) 2014 Adam Kirk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (Hyperlink)

+ (instancetype)hyperlinkFromString:(NSString*)inString withURL:(NSURL*)aURL;

+ (instancetype)linkifiedAttributedStringFromString:(NSString *)string;

@end
