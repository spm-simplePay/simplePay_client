//
//  SimplePayTests.m
//  SimplePayTests
//
//  Created by Burak Colakoglu on 09.11.14.
//  Copyright (c) 2014 Colakoglu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface SimplePayTests : XCTestCase

@end

@implementation SimplePayTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


// Diese Test-Methode prüft, ob Daten aus dem Server gelade werde können
- (void)testGetValues {
    // This is an example of a functional test case.
    
    
    NSError *error = nil;
    
    NSString *serviceURL = [NSString stringWithFormat:@"%@", @"http://54.173.138.214/api/Values"];
    
    NSURL *url = [[NSURL alloc] initWithString:serviceURL];
    
    NSData *data = [NSData dataWithContentsOfURL:url options:NSDataReadingUncached error:&error];
    
    
    if(!error){
        
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:data
                              options:NSJSONReadingMutableContainers
                              error:&error];
        
        if(!json) {
        XCTAssert(YES, @"Pass");
        } else {
        XCTAssert(NO, @"Test Failure");
        }
        
        
    }else {
    XCTAssert(NO, @"Test Failure");
    }

}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        
        NSError *error = nil;
        
        NSString *serviceURL = [NSString stringWithFormat:@"%@", @"http://54.173.138.214/api/Values"];
        
        NSURL *url = [[NSURL alloc] initWithString:serviceURL];
        
        NSData *data = [NSData dataWithContentsOfURL:url options:NSDataReadingUncached error:&error];
        
        
        if(!error){
            
            NSDictionary* json = [NSJSONSerialization
                                  JSONObjectWithData:data
                                  options:NSJSONReadingMutableContainers
                                  error:&error];
   
        }
        
    }];
}

@end
