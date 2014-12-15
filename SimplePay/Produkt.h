//
//  Produkt.h
//  SimplePay
//
//  Created by Burak Colakoglu on 08.12.14.
//  Copyright (c) 2014 Colakoglu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Produkt : NSObject

@property(nonatomic,assign) NSInteger p_id;
@property(strong, nonatomic) NSString * bezeichnung;
@property(strong, nonatomic) NSNumber * preis;
@property(strong, nonatomic) NSString * mengeneinheit;

@end
