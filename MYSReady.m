//
//  MYSReady.m
//  FirehoseChat
//
//  Created by Adam Kirk on 10/4/14.
//  Copyright (c) 2014 Adam Kirk. All rights reserved.
//

#import "MYSReady.h"


@implementation MYSReady

+ (instancetype)sharedReadyForActionName:(NSString *)actionName
{
    static NSMutableDictionary *__objects;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __objects = [NSMutableDictionary new];
    });

    if (!__objects[actionName]) {
        __objects[actionName] = [MYSReady new];
    }

    return __objects[actionName];
}

- (void)setObject:(id)object
{
    _object = object;
    if (self.actionBlock) {
        self.actionBlock(object);
        _object = nil;
    }
}

- (void)setActionBlock:(void (^)(id object))actionBlock
{
    _actionBlock = actionBlock;
    if (self.object) {
        actionBlock(self.object);
        _object = nil;
    }
}


@end
