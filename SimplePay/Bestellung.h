//
//  Bestellung.h
//  SimplePay
//
//  Created by Burak Colakoglu on 02.01.15.
//  Copyright (c) 2015 Colakoglu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Produkt.h"
#import "Nutzer.h"
#import "Bestellposition.h"
#import "KundeTisch.h"

@interface Bestellung : NSObject

@property (strong, nonatomic) NSMutableArray *bestellpositionen;
@property Nutzer *kunde;
@property(nonatomic,assign) NSInteger mwst_id;
@property KundeTisch* kundeTisch;

-(NSString*)getJsonBestellung;

@end
