//
//  SharedUser.m
//  SimplePay
//
//  Created by Burak Colakoglu on 02.01.15.
//  Copyright (c) 2015 Colakoglu. All rights reserved.
//

#import "SharedUser.h"

@implementation SharedUser

@synthesize user;


#pragma mark Singleton Methods

+ (id)sharedManager {
    static SharedUser *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        user = nil;
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

@end
