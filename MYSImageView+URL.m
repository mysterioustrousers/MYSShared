//
//  FSImageView+URL.m
//  FirehoseChat
//
//  Created by Adam Kirk on 5/13/14.
//  Copyright (c) 2014 Adam Kirk. All rights reserved.
//

#import "MYSImageView+URL.h"
#import <objc/runtime.h>


static char imageURLKey;


@implementation MYSImageView (URL)

+ (NSCache *)sharedImageCache
{
    static NSCache *__cache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __cache = [NSCache new];
    });
    return __cache;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setImageWithContentsOfURL:(NSURL *)URL placeholder:(MYSImage *)placeholderImage
{
    if (!URL) return;

    // set the placeholder image so we have somethign there while we figure out if we can set the intended iamge.
    if (placeholderImage) {
        [self setImage:placeholderImage];
    }

    // set the image url so we know what image, when loaded, should be set on this image view
    [self setImageURL:URL];

    // register to know when the image is done loading
    [self registerForNotifications];

    // this value will either be nil, NSNull or NSImage. We'll handle each case below
    id imageOrNull = [[[self class] sharedImageCache] objectForKey:URL];

    // if the image is loaded, just set it and we're done
    if ([imageOrNull isKindOfClass:[MYSImage class]]) {
        [self setImage:imageOrNull];
        return;
    }

    // just return because the image with this url is currently loading, we'll get a notif when it's ready
    else if ([imageOrNull isKindOfClass:[NSNull class]]) {
        return;
    }

    // if it's nil, we need to be the instance that loads the image. We'll notify all other image views with this url when it's done.
    else {
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:URL]
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
        {
            MYSImage *image = [[MYSImage alloc] initWithData:data];
            if (image) {
                [[[self class] sharedImageCache] setObject:image forKey:URL];
                [[NSNotificationCenter defaultCenter] postNotificationName:MYSImageViewImageDidLoadFromURLNotification
                                                                    object:URL
                                                                  userInfo:@{ @"ImageKey" : image }];
            }
        }];
    }
}




#pragma mark - Properties

- (void)setImageURL:(NSURL *)imageURL
{
    objc_setAssociatedObject(self, &imageURLKey, imageURL, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSURL *)imageURL
{
    return objc_getAssociatedObject(self, &imageURLKey);
}




#pragma mark - Notifications

- (void)imageDidLoad:(NSNotification *)note
{
    MYSImage *image = note.userInfo[@"ImageKey"];
    [self setImage:image];
}




#pragma mark - Private

- (void)registerForNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(imageDidLoad:)
                                                 name:MYSImageViewImageDidLoadFromURLNotification
                                               object:[self imageURL]];
}


@end


NSString * const MYSImageViewImageDidLoadFromURLNotification = @"MYSImageViewImageDidLoadFromURLNotification";

