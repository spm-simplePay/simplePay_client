//
//  Adresse.m
//  SimplePay
//
//  Created by Burak Colakoglu on 19.11.14.
//  Copyright (c) 2014 Colakoglu. All rights reserved.
//

#import "Adresse.h"

@implementation Adresse

@synthesize a_id;
@synthesize strasse;
@synthesize hausnummer;
@synthesize plz;
@synthesize ort;

-(NSString*)getJsonAdresse{
    
    NSString* JSON = [NSString stringWithFormat:@"{\"strasse\":\"%@\",\"hausnummer\":\"%@\",\"plz\":%ld,\"ort\":\"%@\"}",strasse,hausnummer,(long)plz,ort];
    
    return JSON;
    
}

@end
