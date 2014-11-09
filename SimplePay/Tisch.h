//
//  Tisch.h
//  SimplePay
//
//  Created by Burak Colakoglu on 09.11.14.
//  Copyright (c) 2014 Colakoglu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tisch : NSObject

@property(nonatomic,assign) NSInteger t_id;
@property(strong, nonatomic) NSString * bezeichnung;
@property(strong, nonatomic) NSString * eingetragen_am;

@end
