//
//  FHSPromise.h
//  Firehose
//
//  Created by Adam Kirk on 2/22/14.
//  Copyright (c) 2014 Mysterious Trousers. All rights reserved.
//


typedef NS_ENUM(NSUInteger, FHSPromiseState) {
    FHSPromiseStatePending,
    FHSPromiseStateResolved,
    FHSPromiseStateRejected
};


typedef void (^FHSPromiseHandler)(void);


@interface MYSDeferred : NSObject

@property (nonatomic, assign, readonly) FHSPromiseState state;

+ (instancetype)sharedDeferrerForActionName:(NSString *)actionName;

- (MYSDeferred *)always:(FHSPromiseHandler)handler;

- (MYSDeferred *)done:(FHSPromiseHandler)handler;

- (MYSDeferred *)fail:(FHSPromiseHandler)handler;

//- (FHSPromise *)then:(void (^)(id object))handler;

//- (FHSPromise *)progress:(void (^)(id object))handler;

//- (FHSPromise *)notify:(void (^)(id object))handler;

- (void)reject;

- (void)resolve;

@end
