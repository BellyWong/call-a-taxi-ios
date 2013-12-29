//
//  DataPersister.m
//  PersistingData
//
//  Created by Doncho Minkov on 12/21/13.
//  Copyright (c) 2013 minkovit. All rights reserved.
//

#import "DataPersister.h"

@implementation DataPersister

@synthesize delegate;

-(void) fetchData:(NSString *)url withAlias:(NSString *)alias{
    NSURL *dataUrl = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:dataUrl];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accepts"];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"test-phone-id" forHTTPHeaderField:@"x-phoneId"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        [delegate didReceiveData:dict withAlias:alias];
    }];
}

-(void) updateDate: (NSString*)url withAlias: (NSString*) alias withData:(NSObject*) data{
    NSURL *dataUrl = [NSURL URLWithString:url];
    NSMutableURLRequest *request=    [NSMutableURLRequest requestWithURL:dataUrl];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"PUT"];
    [request addValue:@"test-phone-id" forHTTPHeaderField:@"x-phoneId"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse *response, NSData *respData, NSError *connectionError) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:respData options:NSJSONReadingAllowFragments error:nil];
        [delegate didReceiveData:dict withAlias:alias];
    }];
}
-(void) sendData: (NSString*)url withAlias: (NSString*) alias withData: (NSObject*) data{
    
}

@end
