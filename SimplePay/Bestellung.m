//
//  Bestellung.m
//  SimplePay
//
//  Created by Burak Colakoglu on 02.01.15.
//  Copyright (c) 2015 Colakoglu. All rights reserved.
//

#import "Bestellung.h"
#import "Bestellposition.h"
#import "KundeTisch.h"

@implementation Bestellung

@synthesize bestellpositionen;
@synthesize kunde;
@synthesize mwst_id;
@synthesize kundeTisch;

-(NSString*)getJsonBestellung {
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:bestellpositionen.count];
    
    for (int i=0; i<bestellpositionen.count;i++){
        Bestellposition *bp = bestellpositionen[i];
        [arr addObject:bp.getJsonBestellposition];
    }
    
    NSString *jsonBestellpositionen = [arr componentsJoinedByString:@", "];

    
    NSString* JSON = [NSString stringWithFormat:@"{\"Bestellposition\":[%@],\"Kunde_Tisch\":%@,\"k_id\":%li,\"mwst_id\":%li}",jsonBestellpositionen,kundeTisch.getJsonKundeTisch,kunde.n_id,mwst_id];
    
    return JSON;
}





@end
