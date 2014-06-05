//
//  NSView+FromNib.m
//  Firehose
//
//  Created by Adam Kirk on 11/30/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "MYSView+FromNib.h"


static NSCache *nibCache = nil;

#if IOS
#define MYSNib UINib
#else
#define MYSNib NSNib
#endif


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
#if IOS
            UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
#else
            NSNib *nib = [[NSNib alloc] initWithNibNamed:NSStringFromClass([self class]) bundle:nil];
#endif
            if (nib) {
                [nibCache setObject:nib forKey:classNameString];
                return [self viewFromNib:nib];
            }
        }
    }

    return nil;
}

+ (MYSView *)viewFromNib:(MYSNib *)nib
{
    NSArray *nibObjects = nil;
#if IOS
    nibObjects = [nib instantiateWithOwner:nil options:0];
#else
    [nib instantiateWithOwner:nil topLevelObjects:&nibObjects];
#endif
    nibObjects = [nibObjects filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id obj, NSDictionary *bindings) {
        return [obj isKindOfClass:[MYSView class]];
    }]];
    return [nibObjects lastObject];
}

@end
