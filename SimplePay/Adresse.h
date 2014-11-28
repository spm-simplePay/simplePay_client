//
//  Adresse.h
//  SimplePay
//
//  Created by Burak Colakoglu on 19.11.14.
//  Copyright (c) 2014 Colakoglu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Adresse : NSObject

@property(nonatomic,assign) NSInteger a_id;
@property(strong, nonatomic) NSString * strasse;
@property(strong, nonatomic) NSString * hausnummer;
@property(nonatomic,assign) NSInteger plz;
@property(strong, nonatomic) NSString * ort;

-(NSString*)getJsonAdresse;

@end
