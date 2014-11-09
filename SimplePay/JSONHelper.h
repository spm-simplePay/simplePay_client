//
//  JSONHelper.h
//  SimplePay
//
//  Created by Burak Colakoglu on 09.11.14.
//  Copyright (c) 2014 Colakoglu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLResult.h"

@interface JSONHelper : NSObject

+(NSDictionary *)loadJSONDataFromURL:(NSString *)urlString;
+(SQLResult*)postJSONDataToURL:(NSString *)urlString JSONdata:(NSString*)JSONdata;

@end
