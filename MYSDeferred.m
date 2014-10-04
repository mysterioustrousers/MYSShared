//
//  FHSPromise.m
//  Firehose
//
//  Created by Adam Kirk on 2/22/14.
//  Copyright (c) 2014 Mysterious Trousers. All rights reserved.
//

#import "MYSDeferred.h"


@interface MYSDeferred ()
@property (nonatomic, assign) FHSPromiseState state;
@property (nonatomic, copy  ) NSMutableArray  *alwaysHandlers;
@property (nonatomic, copy  ) NSMutableArray  *doneHandlers;
@property (nonatomic, copy  ) NSMutableArray  *failHandlers;
@end


@implementation MYSDeferred

- (id)init
{
    self = [super init];
    if (self) {
        _state          = FHSPromiseStatePending;
        _alwaysHandlers = [NSMutableArray new];
        _doneHandlers   = [NSMutableArray new];
        _failHandlers   = [NSMutableArray new];
    }
    return self;
}

+ (instancetype)sharedDeferrerForActionName:(NSString *)actionName
{
    static NSMutableDictionary *__deferrers;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __deferrers = [NSMutableDictionary new];
    });

    if (!__deferrers[actionName]) {
        __deferrers[actionName] = [MYSDeferred new];
    }

    return __deferrers[actionName];
}

- (MYSDeferred *)always:(FHSPromiseHandler)handler
{
    if (handler) {
        if (self.state == FHSPromiseStateRejected || self.state == FHSPromiseStateResolved) {
            handler();
        }
        else {
            [self.alwaysHandlers addObject:handler];
        }
    }
    return self;
}

- (MYSDeferred *)done:(FHSPromiseHandler)handler
{
    if (handler) {
        if (self.state == FHSPromiseStateResolved) {
            handler();
        }
        else {
            [self.doneHandlers addObject:handler];
        }
    }
    return self;
}

- (MYSDeferred *)fail:(FHSPromiseHandler)handler
{
    if (handler) {
        if (self.state == FHSPromiseStateRejected) {
            handler();
        }
        else {
            [self.failHandlers addObject:handler];
        }
    }
    return self;
}

//- (FHSPromise *)then:(void (^)(id object))handler
//{
//    return self;
//}

//- (FHSPromise *)progress:(void (^)(id object))handler
//{
//
//}

//- (FHSPromise *)notify:(void (^)(id object))handler
//{
//
//}

- (void)reject
{
    self.state = FHSPromiseStateRejected;
    for (FHSPromiseHandler handler in [self.failHandlers arrayByAddingObjectsFromArray:self.alwaysHandlers]) {
        handler();
        [self.failHandlers removeObject:handler];
        [self.alwaysHandlers removeObject:handler];
    }
}

- (void)resolve
{
    self.state = FHSPromiseStateResolved;
    for (FHSPromiseHandler handler in [self.doneHandlers arrayByAddingObjectsFromArray:self.alwaysHandlers]) {
        handler();
        [self.doneHandlers removeObject:handler];
        [self.alwaysHandlers removeObject:handler];
    }
}

@end
