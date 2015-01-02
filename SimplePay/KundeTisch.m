//
//  KundeTisch.m
//  SimplePay
//
//  Created by Burak Colakoglu on 02.01.15.
//  Copyright (c) 2015 Colakoglu. All rights reserved.
//

#import "KundeTisch.h"

@implementation KundeTisch

@synthesize kunde;
@synthesize tisch;

-(NSString*)getJsonKundeTisch {
    
    NSString* JSON = [NSString stringWithFormat:@"{\"t_id\":%li,\"k_id\":%li}",tisch.t_id,kunde.n_id];
    
    return JSON;
}

@end
