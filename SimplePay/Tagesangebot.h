//
//  Tagesangebot.h
//  SimplePay
//
//  Created by Burak Colakoglu on 16.12.14.
//  Copyright (c) 2014 Colakoglu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tagesangebot : NSObject

@property(nonatomic,assign) NSInteger ta_id;
@property(strong, nonatomic) NSString * bezeichnung;
@property(strong, nonatomic) NSString * preis;
@property (strong, nonatomic) NSMutableArray *listOfProducts;

@end
