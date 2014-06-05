//
//  NSView+FromNib.m
//  Firehose
//
//  Created by Adam Kirk on 11/30/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "MYSView+FromNib.h"


static NSCache *nibCache = nil;


@implementation MYSView (FromNib)

+ (instancetype)loadedFromNib
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        nibCache = [NSCache new];
    });

    NSString *classNameString = NSStringFromClass([self class]);

    @synchronized(self) {
        id cachedNib = nil;
        if ((cachedNib = [nibCache objectForKey:classNameString])) {
            return [self viewFromNib:cachedNib];
        }
        else {
            NSNib *nib = [[NSNib alloc] initWithNibNamed:NSStringFromClass([self class]) bundle:nil];
            if (nib) {
                [nibCache setObject:nib forKey:classNameString];
                return [self viewFromNib:nib];
            }
        }
    }

    return nil;
}

+ (MYSView *)viewFromNib:(NSNib *)nib
{
    NSArray *nibObjects = nil;
    [nib instantiateWithOwner:nil topLevelObjects:&nibObjects];
    nibObjects = [nibObjects filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id obj, NSDictionary *bindings) {
        return [obj isKindOfClass:[MYSView class]];
    }]];
    return [nibObjects lastObject];
}

@end
