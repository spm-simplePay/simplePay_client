//
//  Nutzer.m
//  SimplePay
//
//  Created by Burak Colakoglu on 19.11.14.
//  Copyright (c) 2014 Colakoglu. All rights reserved.
//

#import "Nutzer.h"

@implementation Nutzer

@synthesize n_id;
@synthesize vorname;
@synthesize nachname;
@synthesize geburtstag;
@synthesize email;
@synthesize passwort;
@synthesize paypin;
@synthesize adresse;
@synthesize nutzerart;


-(NSString*)getJsonNutzer{
    
    NSString* JSON = [NSString stringWithFormat:@"{\"vorname\":\"%@\",\"nachname\":\"%@\",\"geburtstag\":\"%@\",\"email\":\"%@\",\"passwort\":\"%@\",\"paypin\":\"%@\",\"na_id\":%ld,\"Adresse\":%@}",vorname,nachname,geburtstag,email,passwort,paypin,(long)nutzerart.na_id,adresse.getJsonAdresse];
    
    return JSON;
    
}

-(NSString*)getJsonUserLogin{
    
    NSString* JSON = [NSString stringWithFormat:@"{\"email\":\"%@\",\"password\":\"%@\"}",email,passwort];
    
    return JSON;
    
}


@end
