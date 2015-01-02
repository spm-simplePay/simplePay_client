//
//  KundeTisch.h
//  SimplePay
//
//  Created by Burak Colakoglu on 02.01.15.
//  Copyright (c) 2015 Colakoglu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Nutzer.h"
#import "Tisch.h"

@interface KundeTisch : NSObject

@property Nutzer *kunde;
@property Tisch *tisch;

-(NSString*)getJsonKundeTisch;

@end
