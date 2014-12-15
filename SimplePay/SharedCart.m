//
//  SharedCart.m
//  SimplePay
//
//  Created by Burak Colakoglu on 08.12.14.
//  Copyright (c) 2014 Colakoglu. All rights reserved.
//

#import "SharedCart.h"

@implementation SharedCart

@synthesize products;
@synthesize product;
@synthesize quantity;

#pragma mark Singleton Methods

+ (id)sharedManager {
    static SharedCart *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        products = nil;
        product = nil;
        quantity = 0;
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}



@end
