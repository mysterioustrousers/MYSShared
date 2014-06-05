//
//  FSImageView+URL.m
//  FirehoseChat
//
//  Created by Adam Kirk on 5/13/14.
//  Copyright (c) 2014 Adam Kirk. All rights reserved.
//

#import "MYSImageView+URL.h"
#import "FHSDownloader.h"
#import <objc/runtime.h>


static char boundModelKey;
static char boundModelKeyPathKey;


@implementation MYSImageView (URL)

- (void)setImageWithContentsOfURL:(NSURL *)URL placeholder:(MYSImage *)placeholderImage
{
    if (placeholderImage) {
        [self setImage:placeholderImage];
    }

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dataDidLoadFromURL:)
                                                 name:FHSDownloaderDidDownloadDataNotification
                                               object:URL];

    [[FHSDownloader sharedDownloader] downloadContentsOfURL:URL];
}

- (void)bindImageToKeyPath:(NSString *)keyPath object:(id)object
{
    id boundObject         = objc_getAssociatedObject(self, &boundModelKey);
    NSString *boundKeyPath = objc_getAssociatedObject(self, &boundModelKeyPathKey);
    if (object == boundObject && [keyPath isEqualToString:boundKeyPath]) {
        [self modelDidChange];
        return;
    }
    objc_setAssociatedObject(self, &boundModelKey, object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &boundModelKeyPathKey, keyPath, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self modelDidChange];
    [object addObserver:self forKeyPath:keyPath options:0 context:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    @try {
        id object           = objc_getAssociatedObject(self, &boundModelKey);
        NSString *keyPath   = objc_getAssociatedObject(self, &boundModelKeyPathKey);
        if (object && [keyPath length] > 0) {
            [object removeObserver:self forKeyPath:keyPath];
        }
    }
    @catch (NSException *exception) {}
}




#pragma mark - Notifications

- (void)dataDidLoadFromURL:(NSNotification *)note
{
    NSData *data = [note userInfo][@"data"];
    MYSImage *image = [[MYSImage alloc] initWithData:data];
    [self setImage:image];
}




#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self modelDidChange];
}




#pragma mark - Private

- (void)modelDidChange
{
    id object           = objc_getAssociatedObject(self, &boundModelKey);
    NSString *keyPath   = objc_getAssociatedObject(self, &boundModelKeyPathKey);
    MYSImage *image     = [object valueForKeyPath:keyPath];
    if (image) {
        [self setImage:image];
    }
}

@end
