//
//  SQLResult.h
//  SimplePay
//
//  Created by Burak Colakoglu on 09.11.14.
//  Copyright (c) 2014 Colakoglu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQLResult : NSObject

@property(nonatomic) NSInteger WasSuccessful;
@property(strong, nonatomic) NSString * Exception;


@end
