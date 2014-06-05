//
//  MORDescriber.h
//  Firehose
//
//  Created by Adam Kirk on 11/13/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "MYSSharedTypes.h"


@interface MYSDescriber : NSObject

+ (NSString *)describeView:(MYSView *)view;

+ (NSString *)describeObject:(id)object;

@end
