//
//  NSAttributedString+Hyperlink.m
//  FirehoseChat
//
//  Created by Adam Kirk on 6/11/14.
//  Copyright (c) 2014 Adam Kirk. All rights reserved.
//

#import "NSAttributedString+Hyperlink.h"

@implementation NSAttributedString (Hyperlink)

+ (instancetype)hyperlinkFromString:(NSString*)inString withURL:(NSURL*)aURL
{
    NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc] initWithString: inString];
    NSRange range = NSMakeRange(0, [attrString length]);

    [attrString beginEditing];
    [attrString addAttribute:NSLinkAttributeName value:[aURL absoluteString] range:range];

    // make the text appear in blue
//    [attrString addAttribute:NSForegroundColorAttributeName value:RGBHex(0xFF9E2C) range:range];

    // next make the text appear with an underline
    [attrString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:range];

    [attrString endEditing];

    return attrString;
}

+ (instancetype)linkifiedAttributedStringFromString:(NSString *)string
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSError *error = nil;
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:&error];
    if (!detector) {
        DLog(@"data detector error: %@", error);
    }
    NSArray *matches = [detector matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    for (NSTextCheckingResult *match in matches) {
        NSRange matchRange = [match range];
        if ([match resultType] == NSTextCheckingTypeLink) {
            NSURL *url = [match URL];
            NSString *URLString = [string substringWithRange:matchRange];
            NSAttributedString *linkedAttributedString = [self hyperlinkFromString:URLString withURL:url];
            [attributedString replaceCharactersInRange:matchRange withAttributedString:linkedAttributedString];
        }
    }
    return attributedString;
}

@end
