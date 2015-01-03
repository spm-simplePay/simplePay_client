//
//  SharedUser.h
//  SimplePay
//
//  Created by Burak Colakoglu on 02.01.15.
//  Copyright (c) 2015 Colakoglu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Nutzer.h"

@interface SharedUser : NSObject{
    Nutzer *user;
}
@property (nonatomic, retain) Nutzer *user;

+ (id)sharedManager;

@end
