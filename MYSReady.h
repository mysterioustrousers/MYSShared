//
//  MYSReady.h
//  FirehoseChat
//
//  Created by Adam Kirk on 10/4/14.
//  Copyright (c) 2014 Adam Kirk. All rights reserved.
//


@interface MYSReady : NSObject

+ (instancetype)sharedReadyForActionName:(NSString *)actionName;

@property (nonatomic, strong) id object;

@property (nonatomic, strong) void (^actionBlock)(id object);

@end
