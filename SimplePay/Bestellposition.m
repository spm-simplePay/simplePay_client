//
//  Bestellposition.m
//  SimplePay
//
//  Created by Burak Colakoglu on 02.01.15.
//  Copyright (c) 2015 Colakoglu. All rights reserved.
//

#import "Bestellposition.h"

@implementation Bestellposition

@synthesize produkt;
@synthesize menge;

-(NSString*)getJsonBestellposition {
    
    NSString* JSON = [NSString stringWithFormat:@"{\"menge\":%li,\"p_id\":%li}",(long)menge,produkt.p_id];
    
    return JSON;
}



@end
