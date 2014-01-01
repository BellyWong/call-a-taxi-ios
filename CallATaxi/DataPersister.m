//
//  DataPersister.m
//  PersistingData
//
//  Created by Doncho Minkov on 12/21/13.
//  Copyright (c) 2013 minkovit. All rights reserved.
//

#import "DataPersister.h"
#import "CityModel.h"
#import "TaxiModel.h"

@implementation DataPersister

@synthesize delegate;

-(id)init{
    self = [super init];
    if(self){
        //custom logic
    }
    return self;
}

-(id) initWithHeaders:(NSDictionary *)theHeaders{
    self = [super init];
    if(self){
        headers = theHeaders;
    }
    return self;
}

-(void) fetchData:(NSString *)url withAlias:(NSString *)alias{
    NSURL *dataUrl = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:dataUrl];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accepts"];
    [request setHTTPMethod:@"GET"];
    if(headers){
        for (id key in headers) {
            id value = [headers objectForKey:key];
            [request addValue:value forHTTPHeaderField:key];
        }
    }
    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        [delegate didReceiveData:dict withAlias:alias];
    }];
}

-(void) updateDate: (NSString*)url withAlias: (NSString*) alias withData:(id) data{
    NSURL *dataUrl = [NSURL URLWithString:url];
    NSMutableURLRequest *request=    [NSMutableURLRequest requestWithURL:dataUrl];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"PUT"];
    if(headers){
        for (id key in headers) {
            id value = [headers objectForKey:key];
            [request addValue:key forHTTPHeaderField:value];
        }
    }
    if(data){
        //TODO add the data to the request
    }
    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse *response, NSData *respData, NSError *connectionError) {
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*) response;
        NSLog(@"%d", [httpResponse statusCode]);
        if([httpResponse statusCode] != 200 && [httpResponse statusCode] !=201){
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:respData options:NSJSONReadingAllowFragments error:nil];
            [delegate didHappenedError:dict withAlias:alias];
        }else{
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:respData options:NSJSONReadingAllowFragments error:nil];
            [delegate didReceiveData:dict withAlias:alias];
        }
        
    }];
}
-(void) sendData: (NSString*)url withAlias: (NSString*) alias withData: (NSObject*) data{
    
}

-(NSData*) parseToData: (NSObject *) obj{
    return [[NSData alloc] init];
}

@end
