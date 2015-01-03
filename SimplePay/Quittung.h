//
//  Quittung.h
//  SimplePay
//
//  Created by Burak Colakoglu on 02.01.15.
//  Copyright (c) 2015 Colakoglu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Quittung : NSObject

@property (strong, nonatomic) NSMutableArray *bestellpositionen;
@property(strong, nonatomic) NSString * datum;
@property(strong, nonatomic) NSString * uhrzeit;
@property(strong, nonatomic) NSString * summe;

@end
