//
//  Bestellposition.h
//  SimplePay
//
//  Created by Burak Colakoglu on 02.01.15.
//  Copyright (c) 2015 Colakoglu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Produkt.h"

@interface Bestellposition : NSObject

@property Produkt *produkt;
@property(nonatomic,assign) NSInteger menge;

-(NSString*)getJsonBestellposition;

@end
