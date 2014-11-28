//
//  Nutzer.h
//  SimplePay
//
//  Created by Burak Colakoglu on 19.11.14.
//  Copyright (c) 2014 Colakoglu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Adresse.h"
#import "Nutzerart.h"

@interface Nutzer : NSObject

@property(nonatomic,assign) NSInteger n_id;
@property(strong, nonatomic) NSString * vorname;
@property(strong, nonatomic) NSString * nachname;
//@property(strong, nonatomic) NSDate * geburtstag;
@property(strong, nonatomic) NSString * geburtstag;
@property(strong, nonatomic) NSString * email;
@property(strong, nonatomic) NSString * passwort;
@property(strong, nonatomic) NSString * paypin;

@property Adresse* adresse;
@property Nutzerart* nutzerart;

-(NSString*)getJsonNutzer;



@end
