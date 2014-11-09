//
//  JSONHelper.m
//  SimplePay
//
//  Created by Burak Colakoglu on 09.11.14.
//  Copyright (c) 2014 Colakoglu. All rights reserved.
//

#import "JSONHelper.h"
#import "SQLResult.h"

@implementation JSONHelper

+(NSDictionary *)loadJSONDataFromURL:(NSString *)urlString
{
    // This function takes the URL of a web service, calls it, and either returns "nil", or a NSDictionary,
    // describing the JSON data that was returned.
    //
    NSError *error;
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    // Call the web service, and (if it's successful) store the raw data that it returns
    NSData *data = [ NSURLConnection sendSynchronousRequest:request returningResponse: nil error:&error ];
    if (!data)
    {
        NSLog(@"Download Error: %@", error.localizedDescription);
        return nil;
    }
    
    // Parse the (binary) JSON data from the web service into an NSDictionary object
    id dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    // NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if (dictionary == nil) {
        NSLog(@"JSON Error: %@", error);
        return nil;
    }
    
    return dictionary;
}

+(SQLResult*)postJSONDataToURL:(NSString *)urlString JSONdata:(NSString*)JSONdata
{
    // Attempt to send some data to a "POST" JSON Web Service, then parse the JSON results
    // which get returned, into a SQLResult record.
    //
    SQLResult* result = [[SQLResult alloc] init];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSData *postData = [JSONdata dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    
    NSError *error;
    NSData *data = [ NSURLConnection sendSynchronousRequest:request returningResponse: nil error:&error ];
    if (!data)
    {
        // An error occurred while calling the JSON web service.
        // Let's return a [SQLResult] record, to tell the user the web service couldn't be called.
        result.WasSuccessful = 0;
        result.Exception = [NSString stringWithFormat:@"Could not call the web service: %@", urlString];
        return result;
    }
    
    
    // The JSON web call did complete, but perhaps it hit an error (such as a foreign key
    // constraint, if we've accidentally sent an unknown User_ID to the [Survey] INSERT command).
    //
    // The ResultString will return a "WasSuccessful" value, and an Exception value:
    //     { "Exception":"", "WasSuccesful":1 }
    // or this
    //     { "Exception:":"The INSERT statement conflicted with ...", "WasSuccesful":0 }"
    //
    
    NSString *resultString = [[NSString alloc] initWithBytes: [data bytes] length:[data length] encoding: NSUTF8StringEncoding];
    
    if (resultString == nil)
    {
        result.WasSuccessful = 0;
        result.Exception = [NSString stringWithFormat:@"An exception occurred: %@", error.localizedDescription];
        return result;
    } else {
        //Wenn die Abfrage erfolgreich ausgeführt wurde
        result.WasSuccessful = 1;
        NSLog(@"%@",resultString);
    }
    
    NSLog(@"%li",(long)result.WasSuccessful);
    
    
    return result;
    
    
    
}

@end


