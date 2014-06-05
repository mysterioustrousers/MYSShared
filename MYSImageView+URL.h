//
//  FSImageView+URL.h
//  FirehoseChat
//
//  Created by Adam Kirk on 5/13/14.
//  Copyright (c) 2014 Adam Kirk. All rights reserved.
//

#import "MYSSharedTypes.h"


@interface MYSImageView (URL)

- (void)setImageWithContentsOfURL:(NSURL *)URL placeholder:(MYSImage *)placeholderImage;

- (void)bindImageToKeyPath:(NSString *)keyPath object:(id)object;

@end
