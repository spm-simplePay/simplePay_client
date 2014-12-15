//
//  SharedCart.h
//  SimplePay
//
//  Created by Burak Colakoglu on 08.12.14.
//  Copyright (c) 2014 Colakoglu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Produkt.h"

@interface SharedCart : NSObject {

    Produkt *product;
    NSInteger quantity;
    
}

@property (nonatomic, retain) Produkt *product;
@property (nonatomic,assign)  NSInteger quantity;
@property (nonatomic, retain) NSMutableArray *products;

+ (id)sharedManager;

@end
